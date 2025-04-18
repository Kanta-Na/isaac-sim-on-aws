#!/bin/bash

# EC2接続用スクリプト

# 環境変数読み込み
source "$HOME/isaac-sim-on-aws/scripts/.env"

# 接続コマンド
ssh -i "$KEY_PATH" "$EC2_USER@$EC2_HOST"
