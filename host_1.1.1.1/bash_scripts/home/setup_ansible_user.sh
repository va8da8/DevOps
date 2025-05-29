#!/bin/bash

# Проверяем, выполняется ли скрипт от root
if [ "$(id -u)" -ne 0 ]; then
    echo "Этот скрипт должен выполняться с правами root!" >&2
    exit 1
fi

# Создаём пользователя ansible (если его нет)
if ! id "ansible" &>/dev/null; then
    useradd -m -s /bin/bash ansible
    echo "Пользователь 'ansible' создан."
    
    # Запрашиваем и устанавливаем пароль
    while true; do
        read -s -p "Введите пароль для пользователя 'ansible': " password
        echo
        read -s -p "Повторите пароль: " password_confirm
        echo
        
        if [ "$password" = "$password_confirm" ]; then
            echo "$ansible:$password" | chpasswd
            echo "Пароль успешно установлен."
            break
        else
            echo "Пароли не совпадают. Попробуйте снова."
        fi
    done
else
    echo "Пользователь 'ansible' уже существует."
fi

# Добавляем пользователя в группу sudo (если ещё не добавлен)
if ! groups ansible | grep -q '\bsudo\b'; then
    usermod -aG sudo ansible
    echo "Пользователь 'ansible' добавлен в группу 'sudo'."
else
    echo "Пользователь 'ansible' уже в группе 'sudo'."
fi

# Разрешаем sudo без пароля (если ещё не разрешено)
SUDOERS_LINE="ansible ALL=(ALL) NOPASSWD:ALL"
if ! grep -q "$SUDOERS_LINE" /etc/sudoers; then
    echo "$SUDOERS_LINE" | tee -a /etc/sudoers >/dev/null
    echo "Права 'sudo без пароля' добавлены для пользователя 'ansible'."
else
    echo "Права 'sudo без пароля' уже настроены для 'ansible'."
fi

echo "Готово! Пользователь 'ansible' настроен."
