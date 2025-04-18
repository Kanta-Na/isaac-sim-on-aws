#!/bin/bash

# EC2からファイルをダウンロードするスクリプト

# ダウンロードするファイルのパス
FILE_PATH="~/isaac-sim-on-aws/"

# 環境変数読み込み
source "$HOME/isaac-sim-on-aws/scripts/.env"

echo "Downloading files from EC2（$EC2_HOST）..."

# ダウンロードコマンド
scp -r -i "$KEY_PATH" "$EC2_USER@$EC2_HOST:$FILE_PATH"

echo "✅ Download completed!"
