## 起動方法  
### 初回のみに必要な作業
docker-compose.yamlと同じディレクトリに`.env`を作成し，以下のように記述してください．
```
PORT=8080
LC_ALL=en_US.UTF-8
```  
また，Dockerのインストールも必要です．  

### ↑の作業終了後，以下のコマンドを実行
`docker-compose up --build`  
(あらかじめDockerをインストールしておく必要があります)  

## 備忘録
### 私が初めに試したこと  
`flutter create app`  

### もしうまくビルドできない場合  
`flutter clean`  

### flutterを動作させる上で不足がないかチェック  
`flutter doctor`  

### flutterのチャンネルを調べる  
`flutter channel`  

### flutterの公式ドキュメント
https://flutter.dev/docs/get-started

### その他参考
[Containerizing Flutter web apps with Docker](https://blog.logrocket.com/containerizing-flutter-web-apps-with-docker/)

