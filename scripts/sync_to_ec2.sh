#!/bin/bash

# アップロードするファイルのパス
FILE_PATH="$HOME/isaac-sim-on-aws"

# 除外するファイル
EXCLUDE_FILES="$HOME/isaac-sim-on-aws/.ssh/"

# 環境変数読み込み
source "$HOME/isaac-sim-on-aws/scripts/.env"

echo "🔁 差分だけEC2に同期中..."
rsync -avz --exclude="$EXCLUDE_FILES" -e "ssh -i $KEY_PATH" "$FILE_PATH/" "$EC2_USER@$EC2_HOST:~/isaac-sim-on-aws/"
echo "✅ 同期完了！"
