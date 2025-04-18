#!/bin/bash

echo "🚀 install_gpu.sh: NVIDIA Isaac Sim 環境構築スクリプト"

# 1. システム更新
echo "🔄 パッケージ更新中..."
sudo apt update && sudo apt upgrade -y

# 2. 必要なパッケージのインストール
echo "🔧 必須パッケージのインストール中..."
sudo apt install -y build-essential dkms curl wget unzip apt-transport-https ca-certificates gnupg lsb-release ubuntu-drivers-common

# 3. NVIDIA GPUドライバのインストール（自動）
echo "🎯 NVIDIA ドライバの自動インストール中..."
sudo ubuntu-drivers autoinstall

# --- ⚠️ 注意：この後、再起動が必要になることがあるので案内のみ ---
echo "⚠️ 再起動を推奨します： sudo reboot を実行してください！"

# "nvidia-smi" で GPU の詳細情報を見れる。

# 4. Docker のインストールと起動
echo "🐳 Docker のインストール中..."
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# グループ変更の即時反映（または再ログイン）
newgrp docker

# 5. NVIDIA Container Toolkit のインストール（参考：https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html）
echo "🧠 NVIDIA Container Toolkit のインストール中..."
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit


# 6. 動作確認（nvidia-smiをDocker内で実行）
echo "🧪 NVIDIA GPUのDocker内確認（nvidia-smi）"
docker run --rm --gpus all nvidia/cuda:12.4.1-runtime-ubuntu22.04 nvidia-smi

echo "✅ install_gpu.sh 実行完了！Isaac Sim の環境構築準備ができました。"
