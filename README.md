# docker ROS noetic

`Ubuntu20`がインストールされていないPC（`Ubuntu`の他のバージョンや`Raspbian`等）で`ROS1 Noetic`を動作させる`docker-compose`の設定ファイル群。

## 基本的な使い方

`PC`のホームディレクトリにクローンする。クローンは一度だけで良い。

```shell
git clone https://github.com/KMiyawaki/docker_ros_noetic
```

クローンしたら次のコマンドで実行する。

```shell
~/docker_ros_noetic/attach.sh
```

このコマンドを実行したターミナル内は`Docker`により`Ubuntu20+ROS1 noetic`が利用可能となっている。

## ショートカットを置いて簡単に使う方法

以下は`Ubuntu22`での説明となる。

`gnome-terminal`（通常使うターミナル）で新しいプロファイルを追加する。
ターミナルを開くときにカスタムコマンドを指定する。

```shell
bash -c $HOME/docker_ros_noetic/attach.sh
```

このプロファイル名を`docker_ros_noetic`にする。

次のようなファイルを作成し、`$HOME/デスクトップ/open_ros_noetic.desktop`として配置し実行権限をつける。

```text
[Desktop Entry]
Type=Application
Version=1.0
Name=ros1 noetic
Comment=open ros1 noetic
Exec=gnome-terminal --profile=docker_ros_noetic
Terminal=true
```

デスクトップ上に`open_ros_noetic.desktop`が出現するので、右クリックして「実行を許可する」をクリックする。
以降はこれをダブルクリックすれば`Ubuntu20+ROS1 noetic`環境が起動する。

## 現状の問題点

`Docker`内からユーザのグループを追加することができない（`useradd`ができない）。この場合はホスト側からグループを追加すればよい。

```shell
adduser: `/sbin/useradd -d /nonexistent -g audio -s /usr/sbin/nologin -u 130 festival' returned error code 1. Exiting.
dpkg: error processing package festival (--configure):
 installed festival package post-installation script subprocess returned error exit status 1

sudo /sbin/useradd -d /nonexistent -g audio -s /usr/sbin/nologin -u 130 festival
```
