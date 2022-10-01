import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:universal_platform/universal_platform.dart';
// import 'package:image/image.dart' as Im;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Walklets Trial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TrialPage(title: "Let's Walklets !"),
    );
  }
}

class TrialPage extends StatefulWidget {
  const TrialPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TrialPage> createState() => _TrialPageState();
}

class _TrialPageState extends State<TrialPage> {
  late DropzoneViewController controller;
  bool highlighted = false;     // dropzone用
  Uint8List? imageShown = null; // 画像格納用
  String? fileType = null;      // ファイルタイプ格納用
  String? fileUrl = null;       // ファイル格納場所保存用


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [

          DropzoneView(
            operation: DragOperation.copy,
            cursor: CursorType.grab,
            onCreated: (ctrl) => controller = ctrl,
            onLoaded: () => print('Zone 1 loaded'),
            onError: (ev) => print('Zone 1 error: $ev'),
            onHover: () { setState(() => highlighted = true); },
            onLeave: () { setState(() => highlighted = false); },
            onDrop: (ev) async {

              final bytes = await controller.getFileData(ev);
              final type = await controller.getFileMIME(ev);

              //以下はまだ試せていない
              // final url = await controller.createFileUrl(ev);
              // controller.releaseFileUrl(url);
              
              // if (!UniversalPlatform.isWeb && type.endsWith('heic')) {
              //   // heicファイルをjpgに変換
              //   final jpegPath = await HeicToJpg.convert(url);
              //   // 変換したファイルを読み込む
              //   final jpegFile = File(jpegPath!);
              //   final bytes = await jpegFile.readAsBytes();
              // }

              setState(() {
                imageShown = bytes; // 画像データ
                fileType = type;    // ファイルタイプ
                // fileUrl = url;
                highlighted = false;
              });
            },
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.9,
                  height: size.height * 0.55,
                  //imageShownに画像が格納されていれば表示
                  //Shimmerエフェクトをロード中に表示
                  child: ((){
                    if (imageShown != null) {
                      return Image.memory(imageShown!);
                    } else {    // Shimmerエフェクト
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: size.width * 0.9,
                          height: size.height * 0.55,
                          color: Colors.grey,
                        ),
                      );
                    }
                  }()),
                ),

                // 雲のアイコン
                IconButton(
                  icon: const Icon(Icons.cloud_upload),
                  iconSize: 100,
                  color: highlighted ? Colors.blue : Colors.grey,
                  // 端末の画像ファイルを選択可
                  onPressed: () async {
                    final image = await getImage();
                    setState(() {
                      imageShown = image;
                      fileType = 'image/';
                      highlighted = false;
                    });
                  },
                ),

                Text(
                  'Drop your image here or click the icon',
                  style: TextStyle(
                    color: highlighted ? Colors.blue : Colors.grey,
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.info),   // infoアイコン(iマーク)
                  iconSize: 20,
                  color: Colors.grey,
                  // PC/webの場合：カーソルをiマークにかぶせた時に以下のメッセージを表示
                  // スマホ/webの場合：iマークをロングタップした時に以下のメッセージを表示
                  tooltip: 'This is a trial version.\nif you know more about Walklets, please click this icon.',
                  // iマークをクリック/タップした時にダイアログを表示
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Title'),         // ダイアログのタイトル
                          content: const Text('Fantastic!'),  // ダイアログの内容
                          actions: [
                            TextButton(
                              child: const Text('Got it!'),   // ボタンのテキスト
                              onPressed: () {
                                Navigator.of(context).pop();  // ダイアログを閉じる
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 画像を表示する関数
  Widget dropViewArea(BuildContext context) => Builder(builder: (context) {

    if (fileType == null) {
      return Center(child: Text(''));   // ファイルがインプットされていないとき

    } else if (fileType!.startsWith('image')) {  // 画像を表示
      return Center(child: Image.memory(imageShown!));

    } else {  // 想定していないタイプのファイルがドロップされたとき。
      final str = '画像をアップロードしてください';
      return Center(child: Text(str));
    }
  });

  // 画像の取得 ----------------------------------------
    Future<Uint8List?> getImage() async {
    Uint8List? image = null;

    if (UniversalPlatform.isWeb) {  // webの場合
      image = await ImagePickerWeb.getImageAsBytes();
    
    } else {  // ネイティブ(モバイル)アプリの場合

      ImagePicker picker = ImagePicker();
      XFile? xfile = await picker.pickImage(source: ImageSource.gallery);
      if (xfile != null) {
        File file = File(xfile.path);
        image = await file.readAsBytes();
      }
    }

    return image;

  }
}