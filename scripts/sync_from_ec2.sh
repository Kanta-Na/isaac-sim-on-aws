#!/bin/bash

# EC2からファイルをダウンロードするスクリプト

# ダウンロードするファイルのパス
FILE_PATH="~/isaac-sim-on-aws/"

# ローカルの同期先ディレクトリ（ここにEC2の内容が反映される）
LOCAL_DIR="$HOME/isaac-sim-on-aws/"

# 環境変数読み込み
source "$HOME/isaac-sim-on-aws/scripts/.env"

echo "🔁 EC2 からローカルに差分同期中..."
rsync -avz -e "ssh -i $KEY_PATH" "$EC2_USER@$EC2_HOST:$FILE_PATH" "$LOCAL_DIR"
echo "✅ ローカルへの同期完了！"
