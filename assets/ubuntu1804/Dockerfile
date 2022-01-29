FROM ubuntu:18.04

# ホストキーのチェックをしない(サーバなりすまし や MITM を疑わない)
ENV ANSIBLE_HOST_KEY_CHECKING False

# コンテナでの Proxy 設定を有効にする
# ENV http_proxy="http://proxy.co.jp:8080" \
#     https_proxy="http://proxy.co.jp:8080"
COPY environment /etc/environment

# 必須パッケージと Ansible をインストールする
RUN apt-get update \
&&  apt-get install -y software-properties-common

# Ansible 3.x をインストールする
RUN add-apt-repository ppa:ansible/ansible-3 \
&&  apt-get update \
&&  apt-get install -y ansible

# 日本語化パッケージリストをインストール && localeを日本語設定に変更
RUN apt-get install -y language-pack-ja-base locales \
&&  locale-gen ja_JP.UTF-8
# 言語を日本語に設定
ENV LANG ja_JP.UTF-8

# アカウント「foo」、グループ「foo」を作成する
RUN groupadd -g 1000 foo \
&&  useradd -m -s /bin/bash -u 1000 -g 1000 foo
# foo アカウントのパスワードを foo として設定する
RUN echo 'foo:foo' | chpasswd
# さらに sudo 時にパスワード無しで実行できるようにする
COPY foo /etc/sudoers.d/foo

# systemd を使うための設定をしておく
RUN apt-get install -y init sudo systemd

COPY setup-systemd.sh /root
RUN bash /root/setup-systemd.sh

# sshd に加えて、その他必要と思われるツールをインストールしておく
RUN apt-get install -y openssh-server vim curl jq wget iputils-ping net-tools tree
# /run/nologin を削除するために sshd が起動したあとに「/lib/systemd/systemd-user-sessions start」
# を実行させるように定義した /lib/systemd/system/ssh.service に差し替える
COPY ssh.service /lib/systemd/system/ssh.service

# Docker コンテナでは使用できないと思うが、network-manager をインストールしておく
RUN apt-get update \
&&  apt-get install -y network-manager

# root アカウントのパスワードを root とする
RUN echo 'root:root' | chpasswd

CMD ["/sbin/init"]

