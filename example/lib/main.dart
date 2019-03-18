import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:umengshare_flutter/model/result.dart';
import 'package:umengshare_flutter/umengshare.dart';
import 'package:umengshare_flutter/utils/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StringBuffer textBuffer = StringBuffer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          children: <Widget>[
            RaisedButton(
              onPressed: () async {
                Result result =
                    await UmengShare.init("5c2ed71fb465f56c71000082");
                textBuffer.write("init 结果 = $result \n");
                this.setState(() {});
              },
              child: Text("初始化"),
            ),
            RaisedButton(
              onPressed: () async {
                Result result = await UmengShare.shareText(platform: PlatFormType.weiChat,text: "文本分享");
                textBuffer.write("文本分享 结果 = $result \n");
                this.setState(() {});
              },
              child: Text("文本分享"),
            ),
            RaisedButton(
              onPressed: () async {
                Result result = await UmengShare.checkInstall(platform:PlatFormType.weiChat,);
                textBuffer.write("是否安装微信 结果 = $result \n");
                this.setState(() {});
              },
              child: Text("是否安装微信"),
            ),
            RaisedButton(
              onPressed: () async {
                Result result = await UmengShare.checkInstall(platform:PlatFormType.qq,);
                textBuffer.write("是否安装微信 结果 = $result \n");
                this.setState(() {});
              },
              child: Text("是否安装qq"),
            ),
            Text(textBuffer.toString())
          ],
        ),
      ),
    );
  }
}
