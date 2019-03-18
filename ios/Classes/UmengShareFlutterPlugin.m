#import "UmengShareFlutterPlugin.h"
#import "constants/Constants.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>

@implementation UmengShareFlutterPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"umengshare_flutter"
                                     binaryMessenger:[registrar messenger]];
    UmengShareFlutterPlugin* instance = [[UmengShareFlutterPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString* method = call.method;
    if ([INIT isEqualToString:method]) {
        [self initWithAppKey:call result:result];
    } else if([SHARE_TEXT isEqualToString:method]){
        [self shareText:call result:result];
    } else if([SHARE_IMAGE isEqualToString:method]) {
        [self shareImage:call result:result];
    } else if([SHARE_MEDIA isEqualToString:method]) {
        [self shareMedia:call result:result];
    } else if([LOGIN isEqualToString:method]) {
        [self login:call result:result];
    } else if([SHARE_MINI_APP isEqualToString:method]){
        [self shareMiniApp:call result:result];
    } else if([CHECK_INSTALL isEqualToString:method]) {
        
    } else {
        result(FlutterMethodNotImplemented);
    }
}

#pragma mark 初始化
/**
 * 初始化
 **/
-(void)initWithAppKey:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* dic = call.arguments;
    NSArray* allKeys = [dic allKeys];
    if ([allKeys containsObject:APP_KEY]) {
        NSString* appKey = dic[APP_KEY];
        if([appKey length]>0){
            [UMConfigure initWithAppkey:appKey channel:@"App Store"];
            if([allKeys containsObject:WEI_XIN_APP_KEY] && [allKeys containsObject:WEI_XIN_APP_SECRET]){
                NSString* weiXinAppKey = dic[WEI_XIN_APP_KEY];
                NSString* weiXinAppSecret = dic[WEI_XIN_APP_SECRET];
                if ([weiXinAppKey length]>0&&[weiXinAppSecret length]>0) {
                    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:weiXinAppKey appSecret:weiXinAppSecret redirectURL:nil];
                }
            }
            if([allKeys containsObject:QQ_APP_KEY] && [allKeys containsObject:QQ_APP_SECRET]){
                NSString* qqAppKey = dic[QQ_APP_KEY];
                NSString* qqAppSecret = dic[QQ_APP_SECRET];
                if ([qqAppKey length]>0&&[qqAppSecret length]>0) {
                    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:qqAppKey appSecret:qqAppSecret redirectURL:nil];
                }
            }
            [self buildResultData:CODE_SUC withMessage:@""];
        } else{
            [self errorParamResult:result];
        }
    }else{
        [self errorParamResult:result];
    }
}

#pragma mark 文本分享
/**
 * 文本分享
 **/
-(void)shareText:(FlutterMethodCall*)call result:(FlutterResult)result{
    NSDictionary* dic = call.arguments;
    NSArray* allKeys = [dic allKeys];
    if ([allKeys containsObject:PLATFORM] && [allKeys containsObject:TEXT]) {
        int platform = [(NSNumber*)dic[PLATFORM] intValue];
        NSString* text = dic[TEXT];
        // 创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        // 设置文本
        [messageObject setText:text];
        [self commonShare:[self sharePlatform:platform] withMessageObject:messageObject withResult:result];
    } else {
        [self errorParamResult:result];
    }
}

#pragma mark 图片分享
/**
 * 图片分享
 **/
-(void)shareImage:(FlutterMethodCall*)call result:(FlutterResult)result{
    NSDictionary* dic = call.arguments;
    NSArray* allKeys = [dic allKeys];
    if ([allKeys containsObject:PLATFORM] && [allKeys containsObject:THUMB]
        && [allKeys containsObject:IMAGE]) {
        int platform = [(NSNumber*)dic[PLATFORM] intValue];
        NSString* thumb = dic[THUMB];
        NSString* image = dic[IMAGE];
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图本地
        [shareObject setThumbImage:thumb];
        [shareObject setShareImage:image];
        //分享消息对象设置分享内容对象
        [messageObject setShareObject:shareObject];
        [self commonShare:[self sharePlatform:platform] withMessageObject:messageObject withResult:result];
    } else {
        [self errorParamResult:result];
    }
}

#pragma mark 多媒体分享
/**
 * 从多媒体分享
 **/
-(void)shareMedia:(FlutterMethodCall*)call result:(FlutterResult)result{
    NSDictionary* dic = call.arguments;
    NSArray* allKeys = [dic allKeys];
    if ([allKeys containsObject:PLATFORM] && [allKeys containsObject:TYPE]
        && [allKeys containsObject:THUMB] && [allKeys containsObject:TITLE]
        && [allKeys containsObject:DESC] && [allKeys containsObject:LINK]) {
        int platform = ((NSNumber*)call.arguments[PLATFORM]).intValue;
        int type =((NSNumber*)call.arguments[TYPE]).intValue;
        NSString *thumb = call.arguments[THUMB];
        NSString *title = call.arguments[TITLE];
        NSString *desc = call.arguments[DESC];
        NSString *link = call.arguments[LINK];
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        switch (type) {
            case TYPE_MUSIC:
            {
                UMShareMusicObject *shareMusicObjet=[UMShareMusicObject shareObjectWithTitle:title descr:desc thumImage:thumb];
                shareMusicObjet.musicUrl = link;
                messageObject.shareObject = shareMusicObjet;
            }
                break;
                
            case TYPE_VIDEO:
            {
                UMShareVideoObject *shareVideoObjet=[UMShareVideoObject shareObjectWithTitle:title descr:desc thumImage:thumb];
                shareVideoObjet.videoUrl = link;
                messageObject.shareObject = shareVideoObjet;
            }
                break;
            case TYPE_WEB:
            {
                UMShareWebpageObject *shareWebPageObjet=[UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:thumb];
                shareWebPageObjet.webpageUrl=link;
                messageObject.shareObject=shareWebPageObjet;
            }
                break;
            default:
                break;
        }
        [self commonShare:[self sharePlatform:platform]  withMessageObject:messageObject withResult:result];
    } else {
        [self errorParamResult:result];
    }
}

#pragma mark 登录
/**
 * 登录
 **/
-(void)login:(FlutterMethodCall*)call result:(FlutterResult)result{
    NSDictionary* dic = call.arguments;
    NSArray* allKeys = [dic allKeys];
    if ([allKeys containsObject:PLATFORM]) {
        int platform = [(NSNumber*)dic[PLATFORM] intValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UMSocialManager defaultManager] getUserInfoWithPlatform:[self sharePlatform:platform] currentViewController:nil completion:^(id data, NSError *error) {
                if (error) {
                    if(error.code == 2009){
                        //error.code;
                        result( @{@"um_status":@"CANCEL"});
                    }else{
                        result(@{@"um_status":@"ERROR",@"um_msg":error.userInfo});
                    }
                } else {
                    UMSocialUserInfoResponse *resp = data;
                    NSDictionary *ret = @{@"um_status":@"SUCCESS",@"uid": resp.uid, @"openid": resp.openid, @"accessToken": resp.accessToken, @"expiration": resp.expiration, @"name": resp.name, @"iconurl": resp.iconurl, @"gender": resp.gender, @"originalResponse": resp.originalResponse};
                    result(ret);
                }
            }];
        });
    } else {
        [self errorParamResult:result];
    }
}

#pragma mark 分享到小程序
/**
 * 分享到小程序
 **/
-(void)shareMiniApp:(FlutterMethodCall*)call result:(FlutterResult)result{
    NSDictionary* dic = call.arguments;
    NSArray* allKeys = [dic allKeys];
    if ([allKeys containsObject:USER_NAME] && [allKeys containsObject:THUMB] &&
        [allKeys containsObject:TITLE] && [allKeys containsObject:DESC] &&
        [allKeys containsObject:URL] && [allKeys containsObject:PATH]) {
        NSString *username=call.arguments[USER_NAME];
        NSString *thumb=call.arguments[THUMB];
        NSString *title=call.arguments[TITLE];
        NSString *desc=call.arguments[DESC];
        NSString *url=call.arguments[URL];
        NSString *path=call.arguments[PATH];
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        UMShareMiniProgramObject *shareObject = [UMShareMiniProgramObject shareObjectWithTitle:title descr:desc thumImage:thumb];
        shareObject.webpageUrl = url;
        shareObject.userName = username;
        shareObject.path = path;
        //shareObject.hdImageData =UIImagePNGRepresentation(thumb);
        //shareObject.hdImageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"]];
        shareObject.miniProgramType = UShareWXMiniProgramTypeRelease;
        messageObject.shareObject = shareObject;
        [self commonShare:UMSocialPlatformType_WechatSession withMessageObject:messageObject withResult:result withCurrentViewController:self];
    } else {
        [self errorParamResult:result];
    }
}

#pragma mark 程序是否安装
/**
 * 登录
 **/
-(void)checkInstall:(FlutterMethodCall*)call result:(FlutterResult)result{
    NSDictionary* dic = call.arguments;
    NSArray* allKeys = [dic allKeys];
    if ([allKeys containsObject:PLATFORM]) {
        int platform = [(NSNumber*)dic[PLATFORM] intValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            BOOL flag=[[UMSocialManager defaultManager] isInstall:platform];
            [self buildResultData:flag?CODE_SUC:CODE_ERROR withMessage:@""];
        });
    } else {
        [self errorParamResult:result];
    }
}

-(void)commonShare:(UMSocialPlatformType)platformType withMessageObject:(UMSocialMessageObject*) messageObject withResult:(FlutterResult)result {
    [self commonShare:platformType withMessageObject:messageObject withResult:result withCurrentViewController:nil];
}

-(void)commonShare:(UMSocialPlatformType)platformType withMessageObject:(UMSocialMessageObject*) messageObject withResult:(FlutterResult)result withCurrentViewController:(id)currentViewController{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentViewController completion:^(id data, NSError *error) {
            if (error) {
                if(error.code == 2009){
                    result([self buildResultData:CODE_CANCEL withMessage:@""]);
                }else{
                    result([self buildResultData:CODE_ERROR withMessage:error.userInfo]);
                }
            }else{
                result([self buildResultData:CODE_SUC withMessage:@""]);
            }
        }];
    });
}

#pragma mark 返回数据格式组装
-(UMSocialPlatformType)sharePlatform:(int)platformType{
    UMSocialPlatformType type;
    switch (platformType) {
        case QQ:
            type  = UMSocialPlatformType_QQ;
            break;
        case WEI_XIN:
            type  = UMSocialPlatformType_WechatSession;
            break;
        default:
            type  = UMSocialPlatformType_QQ;
            break;
    }
    return type;
}

-(void) errorParamResult:(FlutterResult)result {
    result([self buildResultData:CODE_ERROR withMessage:ERROR_PARAM]);
}
/**
 * 返回数据格式
 **/
-(NSDictionary*) buildResultData:(int) code withMessage:(NSObject*) msg {
    NSMutableDictionary* resultDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    [resultDic setObject:[[NSNumber alloc] initWithInt:code] forKey:CODE];
    [resultDic setObject:msg forKey:MSG];
    return resultDic;
}

@end
