## ファイル構成

```bash
.
|-- PV
|   |-- master
|   |   |-- .ssh ................... コンテナ内の /home/foo/.ssh/ に該当する
|   |   |   |-- config ............. SSH接続時の警告を無視するようにしている
|   |   |   |-- id_rsa ............. RSA 公開鍵
|   |   |   |-- id_rsa.pub ......... RSA 秘密鍵
|   |   |   `-- known_hosts
|   |   `-- share .................. 永続ボリューム. ここで実装していく
|   |-- slave01
|   |   |-- .ssh
|   |   |   `-- authorized_keys .... master の公開鍵 id_rsa.pub を登録済み
|   |   `-- share .................. 永続ボリューム. 
|   |-- slave02 〜 slave08 については slave01 と同じため省略する
略
|-- assets
|   `-- ubuntu1804
|       |-- Dockerfile ............. Master と Slave の両方で使用する Dockerfile
|       |-- foo .................... /etc/sudoers.d/foo として配置する (∵ sudo パスワード入力回避)
|       |-- setup-systemd.sh ....... コンテナ内で systemd を使うための設定処理をする
|       `-- ssh.service ............ /run/nologin を削除する処理を追記している
|
`-- docker-compose.yml
```


