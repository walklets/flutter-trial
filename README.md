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

### ブラウザで以下のURLにアクセス  
127.0.0.1:8080  

## 備忘録
### 私が初めに試したこと  
`flutter create app`  

### もしうまくビルドできない場合  
`flutter clean`  

### flutterを動作させる上で不足がないかチェック  
`flutter doctor`  

### flutterのチャンネルを調べる  
`flutter channel`  

## 参考　　
[公式Doc](https://flutter.dev/docs/get-started)  
[【3.0対応】Flutter webをGithub PagesにデプロイするGithub Actions](https://zenn.dev/nekomimi_daimao/articles/26fd2e3b763191)  
[Containerizing Flutter web apps with Docker](https://blog.logrocket.com/containerizing-flutter-web-apps-with-docker/)  
[Flutter クロスプラットフォーム向け画像アップロード](https://www.grow-tag.com/flutter/flutter-picture-upload/)  
[[Flutter]コピペで使える！ボタンのデザイン16種類をまとめました](https://qiita.com/coka__01/items/30716f42e4a909334c9f)  

