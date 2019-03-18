import 'dart:async';

import 'package:flutter/services.dart';
import 'package:umengshare_flutter/model/result.dart';
import 'package:umengshare_flutter/utils/constants.dart';
import 'package:umengshare_flutter/utils/utils.dart' show Print;

class UmengShare {
  static const MethodChannel _channel =
      const MethodChannel('umengshare_flutter');

  UmengShare._();

  /// 初始化
  static Future<Result> init(String appKey,
      {String weiChatAppKey,
      String weiChatAppSecret,
      String qqAppKey,
      String qqAppSecret}) async {
    Map result = await _channel.invokeMethod(Constants.INIT, {
      Key.APP_KEY: appKey,
      Key.WEI_XIN_APP_KEY: weiChatAppKey,
      Key.WEI_XIN_APP_SECRET: weiChatAppSecret,
      Key.QQ_APP_KEY: qqAppKey,
      Key.QQ_APP_SECRET: qqAppSecret
    });
    Print().printNative("init result($result)");
    int code = result[Key.CODE];
    String msg = "";
    if (result.containsKey(Key.MSG)) {
      msg = result[Key.MSG];
    }
    return Result(code: code, message: msg);
  }

  /// 文本分享
  static Future<Result> shareText({PlatFormType platform, String text}) async {
    Map result = await _channel.invokeMethod(Constants.SHARE_TEXT, {
      Key.PLATFORM: platform.index,
      Key.TEXT: text,
    });
    Print().printNative("shareText result($result)");
    int code = result[Key.CODE];
    String msg = "";
    if (result.containsKey(Key.MSG)) {
      msg = result[Key.MSG];
    }
    return Result(code: code, message: msg);
  }

  /// 图片分享
  static Future<Result> shareImage(
      {PlatFormType platform, String image, String thumb}) async {
    Map result = await _channel.invokeMethod(Constants.SHARE_IMAGE,
        {Key.PLATFORM: platform.index, Key.IMAGE: image, Key.THUMB: thumb});
    Print().printNative("shareImage result($result)");
    int code = result[Key.CODE];
    String msg = "";
    if (result.containsKey(Key.MSG)) {
      msg = result[Key.MSG];
    }
    return Result(code: code, message: msg);
  }

  /// 多媒体分享
  static Future<Result> shareMedia(
      {MediaType type,
      String thumb,
      String image,
      String link,
      String title,
      String desc,
      PlatFormType platform}) async {
    Map result = await _channel.invokeMethod(Constants.SHARE_MEDIA, {
      Key.TYPE: type.index,
      Key.IMAGE: image,
      Key.THUMB: thumb,
      Key.LINK: link,
      Key.TITLE: title,
      Key.DESC: desc,
      Key.PLATFORM: platform.index
    });
    Print().printNative("shareMedia result($result)");
    int code = result[Key.CODE];
    String msg = "";
    if (result.containsKey(Key.MSG)) {
      msg = result[Key.MSG];
    }
    return Result(code: code, message: msg);
  }

  /// 登录
  static Future<Result> login(PlatFormType platform, String text) async {
    Map result = await _channel.invokeMethod(Constants.LOGIN, {
      Key.PLATFORM: platform.index,
    });
    Print().printNative("login result($result)");
    int code = result[Key.CODE];
    String msg = "";
    if (result.containsKey(Key.MSG)) {
      msg = result[Key.MSG];
    }
    return Result(code: code, message: msg);
  }

  /// 小程序分享
  static Future<Result> shareMiniApp(
      {String url,
      String thumb,
      String title,
      String desc,
      String path,
      String username}) async {
    Map result = await _channel.invokeMethod(Constants.SHARE_MINI_APP, {
      Key.URL: url,
      Key.THUMB: thumb,
      Key.TITLE: title,
      Key.DESC: desc,
      Key.PATH: path,
      Key.USER_NAME: username
    });
    Print().printNative("shareMiniApp result($result)");
    int code = result[Key.CODE];
    String msg = "";
    if (result.containsKey(Key.MSG)) {
      msg = result[Key.MSG];
    }
    return Result(code: code, message: msg);
  }

  /// 判断是否安装
  static Future<Result> checkInstall({PlatFormType platform}) async {
    Map result = await _channel
        .invokeMethod(Constants.CHECK_INSTALL, {Key.PLATFORM: platform.index});
    Print().printNative("checkInstall result($result)");
    int code = result[Key.CODE];
    String msg = "";
    if (result.containsKey(Key.MSG)) {
      msg = result[Key.MSG];
    }
    return Result(code: code, message: msg);
  }
}
