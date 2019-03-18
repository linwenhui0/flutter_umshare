enum MediaType {
  none,

  /// 音乐类型
  music,

  /// 视频类型
  video,

  /// WEB类型
  web
}

enum PlatFormType { none, qq, qzone, weiChat, weiChatFriend }

class Constants {
  Constants._();

  /// 初始化友盟
  static const INIT = "initWithAppKey";

  /// 文本分享
  static const String SHARE_TEXT = "shareText";

  /// 分享图片
  static const String SHARE_IMAGE = "shareImage";

  /// 分享财富
  static const String SHARE_MEDIA = "shareMedia";

  /// 登录
  static const String LOGIN = "login";

  /// 分享小程序
  static const String SHARE_MINI_APP = "shareMiniApp";

  /// 判断程序是否安装
  static const String CHECK_INSTALL = "checkInstall";

  static const String ERROR_PARAM = "缺少必传参数";
}

class Key {
  Key._();

  /// 状态
  static const String CODE = "um_code";

  /// 出错消息
  static const String MSG = "um_msg";

  /// 状态成功
  static const CODE_SUC = 0x00;

  /// 状态出错
  static const CODE_ERROR = 0x02;

  /// 取消取消
  static const CODE_CANCEL = 0x01;

  /// 分享到的平台
  static const String PLATFORM = "platform";

  /// 分享文本key
  static const String TEXT = "text";

  /// 分享封面图片
  static const String THUMB = "thumb";

  /// 分享图片
  static const String IMAGE = "image";

  /// 友盟app_key
  static const String APP_KEY = "AppKey";

  /// 微信app_key
  static const String WEI_XIN_APP_KEY = "WeiXinAppKey";

  /// 微信app_Secret
  static const String WEI_XIN_APP_SECRET = "WeiXinAppSecret";

  /// QQ app_key
  static const String QQ_APP_KEY = "QQAppKey";

  /// QQ app_Secret
  static const String QQ_APP_SECRET = "QQAppSecret";

  /// 分享媒体类型
  static const String TYPE = "type";

  /// 标题
  static const String TITLE = "title";

  /// 描述
  static const String DESC = "desc";

  /// 链接
  static const String LINK = "link";

  static const String URL = "url";
  static const String PATH = "path";
  static const String USER_NAME = "username";
}
