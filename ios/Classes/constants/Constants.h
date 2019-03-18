//
//  Constants.h
//  Pods
//
//  Created by linwenhui on 2019/3/16.
//

#ifndef Constants_h
#define Constants_h

#pragma mark 使用方法名
// 初始化友盟
#define INIT @"initWithAppKey"
// 文本分享
#define SHARE_TEXT @"shareText"
// 分享图片
#define SHARE_IMAGE @"shareImage"
// 分享财富
#define SHARE_MEDIA @"shareMedia"
// 音乐类型
#define TYPE_MUSIC 0x01
// 视频类型
#define TYPE_VIDEO 0x02
// WEB类型
#define TYPE_WEB 0x03
// 登录
#define LOGIN @"login"
// 分享小程序
#define SHARE_MINI_APP @"shareMiniApp"
// 判断程序是否安装
#define CHECK_INSTALL @"checkInstall"

#pragma mark 错误
// 错误信息
#define ERROR_PARAM @"缺少必传参数"

#pragma mark 分享的平台
// QQ
#define QQ 0x01
// QZone
#define QZONE 0x02
// 微信
#define WEI_XIN 0x03
// 微信朋友圈
#define WEI_XIN_FRIEND 0x04

// 返回格式
// 状态
#define CODE @"um_code"
// 出错消息
#define MSG @"um_msg"
// 状态成功
#define CODE_SUC 0x00
// 状态出错
#define CODE_ERROR 0x02
// 状态取消
#define CODE_CANCEL 0x01

#pragma mark 使用的Key
// 分享到的平台
#define PLATFORM @"platform"
// 分享文本key
#define TEXT @"text"
// 分享封面图片
#define THUMB @"thumb"
// 分享图片
#define IMAGE @"image"
// 友盟app_key
#define APP_KEY @"AppKey"
// 微信app_key
#define WEI_XIN_APP_KEY @"WeiXinAppKey"
// 微信app_Secret
#define WEI_XIN_APP_SECRET @"WeiXinAppSecret"
// QQ app_key
#define QQ_APP_KEY @"QQAppKey"
// QQ app_Secret
#define QQ_APP_SECRET @"QQAppSecret"
// 分享媒体类型
#define TYPE @"type"
// 标题
#define TITLE @"title"
// 描述
#define DESC @"desc"
// 链接
#define LINK @"link"
#define URL @"url"
#define PATH @"path"
#define USER_NAME @"username"

#endif /* Constants_h */
