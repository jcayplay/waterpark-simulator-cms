#!/bin/bash

# Script cài đặt Docker và Docker Compose trên Ubuntu 22.04
# Tác giả: Claude AI
# Ngày tạo: $(date)

set -e  # Dừng script nếu có lỗi

echo "🚀 Bắt đầu cài đặt Docker và Docker Compose trên Ubuntu 22.04..."

# Cập nhật hệ thống
echo "📦 Cập nhật danh sách package..."
sudo apt update

# Cài đặt các gói cần thiết
echo "🔧 Cài đặt các gói phụ thuộc..."
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    apt-transport-https \
    software-properties-common

# Thêm Docker GPG key
echo "🔑 Thêm Docker GPG key..."
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Thêm Docker repository
echo "📋 Thêm Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Cập nhật lại package list
echo "🔄 Cập nhật lại danh sách package..."
sudo apt update

# Cài đặt Docker
echo "🐳 Cài đặt Docker Engine..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin

# Khởi động và enable Docker service
echo "⚡ Khởi động Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

# Thêm user hiện tại vào group docker
echo "👤 Thêm user $(whoami) vào Docker group..."
sudo usermod -aG docker $USER

# Cài đặt Docker Compose (phiên bản mới nhất)
echo "🔧 Cài đặt Docker Compose..."

# Lấy phiên bản mới nhất của Docker Compose
COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
echo "📥 Đang tải Docker Compose version: $COMPOSE_VERSION"

# Tải và cài đặt Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Phân quyền thực thi
sudo chmod +x /usr/local/bin/docker-compose

# Tạo symbolic link (tuỳ chọn)
sudo ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose



# Kiểm tra cài đặt
echo "✅ Kiểm tra cài đặt..."
echo "Docker version:"
sudo docker --version

echo "Docker Compose version:"
docker-compose --version

# Test chạy container hello-world
echo "🧪 Test chạy container hello-world..."
sudo docker run --rm hello-world

sudo usermod -aG docker $USER
newgrp docker

echo ""
echo "🎉 Cài đặt hoàn thành!"
echo ""
echo "📌 LƯU Ý QUAN TRỌNG:"
echo "   - Bạn cần LOGOUT và LOGIN lại để sử dụng Docker mà không cần sudo"
echo "   - Hoặc chạy lệnh: newgrp docker"
echo ""
echo "🔍 Các lệnh hữu ích:"
echo "   - Kiểm tra Docker: docker --version"
echo "   - Kiểm tra Docker Compose: docker-compose --version"
echo "   - Xem containers đang chạy: docker ps"
echo "   - Xem tất cả containers: docker ps -a"
echo "   - Xem images: docker images"
echo ""
echo "✨ Happy Dockerizing! ✨"

