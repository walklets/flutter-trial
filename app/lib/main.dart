import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:universal_platform/universal_platform.dart';

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
  Image? imageShown;

  void _uploadPicture(Image? image) {
    setState(() {
      imageShown = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 500,
                height: 500,
                child: imageShown != null
                    ? imageShown
                    : Container(
                        color: Colors.white,
                      )),
            SizedBox(
              height: 7,
            ),
            OutlinedButton(
              onPressed: () async {
                Image? image = await getImage();
                _uploadPicture(image);
              },
              child: Text(" Upload a Picture "),
              style: OutlinedButton.styleFrom(
                primary: Colors.black,
                shape: const StadiumBorder(),
                side: const BorderSide(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 画像の取得 ----------------------------------------
  Future<Image?> getImage() async {
    Image? image;
    // webの場合
    if (UniversalPlatform.isWeb) {
      image = await ImagePickerWeb.getImageAsWidget();
    }
    // ネイティブ(モバイル)アプリの場合
    else {
      ImagePicker picker = ImagePicker();
      XFile? xfile = await picker.pickImage(source: ImageSource.gallery);
      if (xfile != null) {
        File file = File(xfile.path);
        image = Image.file(file);
      }
    }
    return image;
  }
}