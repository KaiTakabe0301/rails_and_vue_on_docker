# rails 6.0 with Vue.js on docker

## これは何？

以下の構成を Docker 上で構築するリポジトリです:

- ruby 2.7.1
- rails 6.0
- nginx
- mysql

## どうやって使うの？

1. mysql の設定
   `environments/db.env`に、mysql の root password, user name, user password を設定する

   ```
   MYSQL_ROOT_PASSWORD=任意のroot password
   MYSQL_USER=任意のyour name
   MYSQL_PASSWORD=任意のyour password
   ```

2. mysql のユーザーに権限を付与
   `template/grant_user.sql`の`'user_name'`を、1.で設定した`MYSQL_USER`に書き換える

   ```
   GRANT ALL PRIVILEGES ON *.* TO 'MYSQL_USERに設定した名前'@'%';
   FLUSH PRIVILEGES;
   ```

3. `script/init.sh`の書き換え
   `script/init.sh`の 19 行目に記載されている`{your user name}`を、　 1.で設定した`MYSQL_USER`に書き換える

   ```
   sed -i ".bak" -e "s/user_name/MYSQL_USERに設定した名前/g" db/grant_user.sql
   ```

4. `script/init.sh`の実行
   1〜3 の設定が完了したら、script/init.sh を実行してください
   ```shell
   $ ./script/init.sh
   ```
5. db の作成
   `./script/init.sh`を実行すると、途中で DB 作成を行うために`MYSQL_PASSWORD`の入力を求められます。
   ```shell
   Enter password: ここにMYSQL_PASSWORDを入力
   ```
