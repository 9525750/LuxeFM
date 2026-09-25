#!/usr/bin/env bash
set -euo pipefail

# Luxe FM — скрипт первоначальной настройки сервера
# Запускать на сервере от root: bash setup.sh

echo "=== Luxe FM: Настройка сервера ==="

# 1. Обновление системы
echo "[1/5] Обновление системы..."
apt update && apt upgrade -y

# 2. Файрволл
echo "[2/5] Настройка файрволла..."
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 8000/tcp
ufw --force enable

# 3. Docker
echo "[3/5] Установка Docker..."
if ! command -v docker &>/dev/null; then
  curl -fsSL https://get.docker.com | sh
  systemctl enable docker
  systemctl start docker
fi

# 4. Caddy (reverse-proxy)
echo "[4/5] Установка Caddy..."
if ! command -v caddy &>/dev/null; then
  apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
  apt update
  apt install -y caddy
fi

# 5. Создание директории проекта
echo "[5/5] Подготовка директории..."
mkdir -p /opt/luxefm
echo ""
echo "=== Готово! ==="
echo "Следующие шаги:"
echo "  1. Скопируйте файлы проекта в /opt/luxefm/"
echo "  2. Отредактируйте config.yml — укажите свой домен и пароли"
echo "  3. Отредактируйте .env — задайте пароли для БД и Icecast"
echo "  4. Скопируйте Caddyfile в /etc/caddy/Caddyfile"
echo "  5. Запустите: cd /opt/luxefm && docker compose up -d"
echo "  6. Перезапустите Caddy: systemctl restart caddy"
