# Isaac Sim × 深層強化学習 環境構築手順

このリポジトリは、NVIDIA Isaac Sim を **AWS EC2 インスタンス上で Docker 環境を用いて動作させる**ための設定とスクリプトをまとめたものです。  
ローカル PC から GUI 操作を行うための手順も含みます。

---

## ① AWS アカウント & EC2 インスタンス作成

1. AWS マネジメントコンソールでアカウントを作成  
2. **GPU 搭載インスタンス** を起動  
   - インスタンスタイプ：`g5.2xlarge` 以上（NVIDIA A10G または T4）  
   - OS：Ubuntu 22.04  
   - ストレージ：最低 200 GiB（無料枠外）  
3. セキュリティグループ（インバウンド）を設定  

   | プロトコル | ポート範囲            | 用途                      |
   |------------|------------------------|---------------------------|
   | TCP        | `22`                   | SSH                       |
   | TCP        | `3009,3010,8211`       | Isaac Sim 通信            |
   | TCP        | `47995–48012`          | WebRTC 映像/音声転送      |
   | UDP        | `47995–48012`          | WebRTC 映像/音声転送      |
   | TCP        | `49000–49007,49100`    | WebRTC 制御/ネゴシエーション |
   | UDP        | `49000–49007,49100`    | WebRTC 制御/ネゴシエーション |

---

## ② SSH 鍵の配置

```bash
mkdir -p .ssh
# EC2 作成時に取得した .pem を移動
mv ~/Downloads/your-key.pem .ssh/
chmod 600 .ssh/your-key.pem
```

---

## ③ 環境変数の設定

scripts/.env ファイルを作成し、以下を記述：
```ini
KEY_PATH="/absolute/path/to/.ssh/your-key.pem"
EC2_USER="ubuntu"
EC2_HOST="ec2-xx-xxx-xxx-xxx.compute-1.amazonaws.com" # or パブリックIPv4アドレス
```

---

## ④ スクリプトに実行権限を付与

```bash
chmod +x scripts/*.sh
```

---

## ⑤ EC2 へ SSH 接続

```bash
./scripts/connect.sh
```

---

## ⑥ リポジトリを EC2 に同期

```bash
./scripts/upload_to_ec2.sh
```

---

## ⑦ GPU + Docker 環境のセットアップ

EC2 上で以下を実行：
```bash
chmod +x scripts/*.sh
./scripts/install_gpu.sh
```  
   - NVIDIA ドライバ / CUDA
   - Docker Engine
   - NVIDIA Container Toolkit  
などが自動的にインストールされます。

---

## ⑧ Isaac Sim コンテナ起動

```bash
chmod +x scripts/start_isaac.sh
./scripts/start_isaac.sh
```

起動後、**ローカル PC の WebRTC Streaming Client** を使って以下を入力・接続：  
   - Server: EC2_HOST のパブリック IPv4 アドレス
   - Resolution: 1280x720 など

---

## **参考リンク**  
   - [Isaac Sim コンテナ](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/isaac-sim)
   - [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html)
   - [WebRTC Streaming Client](https://docs.isaacsim.omniverse.nvidia.com/latest/installation/manual_livestream_clients.html)
   - [AWS Marketplace AMI（代替手段）](https://aws.amazon.com/marketplace/search/results?searchTerms=isaac+sim)
