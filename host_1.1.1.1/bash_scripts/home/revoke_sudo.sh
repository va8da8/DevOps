#!/bin/bash

# Проверяем, выполняется ли скрипт от root
if [ "$(id -u)" -ne 0 ]; then
    echo "Этот скрипт должен выполняться с правами root!" >&2
    exit 1
fi

# Определяем текущего пользователя (кто вызвал sudo)
TARGET_USER=${SUDO_USER:-$(whoami)}
if [ -z "$TARGET_USER" ]; then
    echo "Не удалось определить пользователя!" >&2
    exit 1
fi

echo "Работаем с пользователем: $TARGET_USER"

# Удаляем пользователя из группы sudo
if groups "$TARGET_USER" | grep -q '\bsudo\b'; then
    deluser "$TARGET_USER" sudo
    echo "Пользователь '$TARGET_USER' удалён из группы 'sudo'."
else
    echo "Пользователь '$TARGET_USER' не состоял в группе 'sudo'."
fi

# Удаляем все записи этого пользователя из sudoers
SUDOERS_FILES=("/etc/sudoers" "/etc/sudoers.d/*")
for file in ${SUDOERS_FILES[@]}; do
    if [ -f "$file" ]; then
        if grep -q "^$TARGET_USER" "$file"; then
            sed -i "/^$TARGET_USER/d" "$file"
            echo "Удалены права sudo из файла $file"
        fi
    fi
done

# Проверяем результат
echo ""
echo "Проверка результатов:"
echo "1. Группы пользователя: $(groups "$TARGET_USER")"
echo "2. Sudo-привилегии:"
sudo -U "$TARGET_USER" -l

echo ""
echo "Готово! Все sudo-права пользователя '$TARGET_USER' отозваны."
