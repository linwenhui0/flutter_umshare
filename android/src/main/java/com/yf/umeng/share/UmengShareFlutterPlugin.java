package com.yf.umeng.share;

import android.app.Activity;
import android.text.TextUtils;

import com.hlibrary.util.Logger;
import com.umeng.commonsdk.UMConfigure;
import com.umeng.socialize.PlatformConfig;
import com.umeng.socialize.ShareAction;
import com.umeng.socialize.UMAuthListener;
import com.umeng.socialize.UMShareAPI;
import com.umeng.socialize.bean.SHARE_MEDIA;
import com.umeng.socialize.media.UMImage;
import com.umeng.socialize.media.UMMin;
import com.umeng.socialize.media.UMVideo;
import com.umeng.socialize.media.UMWeb;
import com.umeng.socialize.media.UMusic;
import com.yf.umeng.share.constant.Constants;
import com.yf.umeng.share.listener.UmengShareActionListener;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import static com.yf.umeng.share.constant.Constants.TYPE_MUSIC;
import static com.yf.umeng.share.constant.Constants.TYPE_VIDEO;
import static com.yf.umeng.share.constant.Constants.TYPE_WEB;

/**
 * UmengshareFlutterPlugin
 *
 * @author linwenhui
 */
public class UmengShareFlutterPlugin implements MethodCallHandler {

    private Registrar mRegistrar;

    public UmengShareFlutterPlugin(Registrar registrar) {
        mRegistrar = registrar;
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "umengshare_flutter");
        channel.setMethodCallHandler(new UmengShareFlutterPlugin(registrar));
        UMConfigure.setLogEnabled(true);
    }

    private void init(MethodCall call, Result result) {
        Logger.getInstance().defaultTagD("调用init进行初始化");
        if (call.hasArgument(Constants.Key.APP_KEY)) {
            String appKey = call.argument(Constants.Key.APP_KEY);
            if (!TextUtils.isEmpty(appKey)) {
                UMConfigure.init(mRegistrar.context(), appKey, "umengshare", UMConfigure.DEVICE_TYPE_PHONE, "");
            } else {
                buildParamError(result);
            }
            if (call.hasArgument(Constants.Key.WEI_XIN_APP_KEY) && call.hasArgument(Constants.Key.WEI_XIN_APP_SECRET)) {
                String weiXinAppKey = call.argument(Constants.Key.WEI_XIN_APP_KEY);
                String weiXinAppSecret = call.argument(Constants.Key.WEI_XIN_APP_SECRET);
                if (!TextUtils.isEmpty(weiXinAppKey) && !TextUtils.isEmpty(weiXinAppSecret)) {
                    PlatformConfig.setWeixin(weiXinAppKey, weiXinAppSecret);
                }
            }
            if (call.hasArgument(Constants.Key.QQ_APP_KEY) && call.hasArgument(Constants.Key.QQ_APP_SECRET)) {
                String weiXinAppKey = call.argument(Constants.Key.QQ_APP_KEY);
                String weiXinAppSecret = call.argument(Constants.Key.QQ_APP_SECRET);
                if (!TextUtils.isEmpty(weiXinAppKey) && !TextUtils.isEmpty(weiXinAppSecret)) {
                    PlatformConfig.setQQZone(weiXinAppKey, weiXinAppSecret);
                }
            }
            buildSucResult(result);
        } else {
            buildParamError(result);
        }
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {
            case Constants.INIT:
                init(call, result);
                break;

            case Constants.SHARE_TEXT:
                shareText(call, result);
                break;

            case Constants.SHARE_IMAGE:
                shareImage(call, result);
                break;

            case Constants.SHARE_MEDIA:
                shareMedia(call, result);
                break;

            case Constants.LOGIN:
                login(call, result);
                break;

            case Constants.SHARE_MINI_APP:
                shareMiniApp(call, result);
                break;

            case Constants.CHECK_INSTALL:
                checkInstall(call, result);
                break;

            default:
                result.notImplemented();
                break;
        }

    }

    private SHARE_MEDIA getPlatForm(int platform) {
        final SHARE_MEDIA result;
        switch (platform) {
            case Constants.PlatForm.QQ:
                result = SHARE_MEDIA.QQ;
                break;
            case Constants.PlatForm.QZONE:
                result = SHARE_MEDIA.QZONE;
                break;
            case Constants.PlatForm.WEI_XIN:
                result = SHARE_MEDIA.WEIXIN;
                break;
            case Constants.PlatForm.WEI_XIN_FRIEND:
                result = SHARE_MEDIA.WEIXIN_CIRCLE;
                break;
            default:
                result = SHARE_MEDIA.QQ;
                break;
        }
        return result;
    }

    /**
     * 文本分享
     *
     * @param call
     * @param result
     */
    private void shareText(MethodCall call, final Result result) {
        Logger.getInstance().defaultTagD("文本分享");
        if (call.hasArgument(Constants.Key.PLATFORM) && call.hasArgument(Constants.Key.TEXT)) {
            int platform = call.argument(Constants.Key.PLATFORM);
            String text = call.argument(Constants.Key.TEXT);
            Logger.getInstance().defaultTagD("platform = ",platform," text = ",text);
            if (!TextUtils.isEmpty(text)) {
                new ShareAction(mRegistrar.activity()).setPlatform(getPlatForm(platform))
                        .withText(text)
                        .setCallback(new UmengShareActionListener(mRegistrar.activity(), result)).share();
            } else {
                buildParamError(result);
            }
        } else {
            buildParamError(result);
        }
    }

    /**
     * 图片分享
     *
     * @param call
     * @param result
     */
    private void shareImage(MethodCall call, final Result result) {
        if (call.hasArgument(Constants.Key.PLATFORM) &&
                call.hasArgument(Constants.Key.THUMB) &&
                call.hasArgument(Constants.Key.IMAGE)) {
            int platForm = call.argument(Constants.Key.PLATFORM);
            String thumb = call.argument(Constants.Key.THUMB);
            String image = call.argument(Constants.Key.IMAGE);
            if (!TextUtils.isEmpty(thumb) && !TextUtils.isEmpty(image)) {
                final Activity activity = mRegistrar.activity();
                UMImage thumbImage = new UMImage(activity, thumb);
                UMImage sImage = new UMImage(activity, image);
                sImage.setThumb(thumbImage);
                new ShareAction(activity)
                        .setPlatform(getPlatForm(platForm))
                        .withMedia(sImage)
                        .setCallback(new UmengShareActionListener(activity, result)).share();
            } else {
                buildParamError(result);
            }
        } else {
            buildParamError(result);
        }
    }

    /**
     * 分享音乐
     *
     * @param activity
     * @param call
     * @param result
     */
    private void shareMusic(Activity activity, MethodCall call, final Result result) {
        if (call.hasArgument(Constants.Key.THUMB) &&
                call.hasArgument(Constants.Key.LINK) &&
                call.hasArgument(Constants.Key.TITLE) &&
                call.hasArgument(Constants.Key.DESC) &&
                call.hasArgument(Constants.Key.PLATFORM)) {
            String thumb = call.argument(Constants.Key.THUMB);
            String link = call.argument(Constants.Key.LINK);
            String title = call.argument(Constants.Key.TITLE);
            String desc = call.argument(Constants.Key.DESC);
            int platform = call.argument(Constants.Key.PLATFORM);

            UMImage thumbImage = new UMImage(activity, thumb);
            UMusic music = new UMusic(link);
            /**
             * 标题
             */
            music.setTitle(title);
            /**
             * 缩略图
             *
             */
            music.setThumb(thumbImage);
            /**描述
             *
             */
            music.setDescription(desc);
            new ShareAction(activity).setPlatform(getPlatForm(platform))
                    .withMedia(music)
                    .setCallback(new UmengShareActionListener(activity, result)).share();
        } else {
            buildParamError(result);
        }
    }

    /**
     * 分享视频
     *
     * @param activity
     * @param call
     * @param result
     */
    private void shareVideo(Activity activity, MethodCall call, final Result result) {
        if (call.hasArgument(Constants.Key.THUMB) &&
                call.hasArgument(Constants.Key.LINK) &&
                call.hasArgument(Constants.Key.TITLE) &&
                call.hasArgument(Constants.Key.DESC) &&
                call.hasArgument(Constants.Key.PLATFORM)) {
            String thumb = call.argument(Constants.Key.THUMB);
            String link = call.argument(Constants.Key.LINK);
            String title = call.argument(Constants.Key.TITLE);
            String desc = call.argument(Constants.Key.DESC);
            int platform = call.argument(Constants.Key.PLATFORM);

            UMImage thumbImage = new UMImage(activity, thumb);
            UMVideo video = new UMVideo(link);
            /**
             * 标题
             */
            video.setTitle(title);
            /**
             * 缩略图
             */
            video.setThumb(thumbImage);
            /**
             * 描述
             */
            video.setDescription(desc);
            new ShareAction(activity).setPlatform(getPlatForm(platform))
                    .withMedia(video)
                    .setCallback(new UmengShareActionListener(activity, result)).share();
        } else {
            buildParamError(result);
        }
    }

    /**
     * 分享web
     *
     * @param activity
     * @param call
     * @param result
     */
    private void shareWeb(Activity activity, MethodCall call, final Result result) {
        if (call.hasArgument(Constants.Key.THUMB) &&
                call.hasArgument(Constants.Key.LINK) &&
                call.hasArgument(Constants.Key.TITLE) &&
                call.hasArgument(Constants.Key.DESC) &&
                call.hasArgument(Constants.Key.PLATFORM)) {
            String thumb = call.argument(Constants.Key.THUMB);
            String link = call.argument(Constants.Key.LINK);
            String title = call.argument(Constants.Key.TITLE);
            String desc = call.argument(Constants.Key.DESC);
            int platform = call.argument(Constants.Key.PLATFORM);


            UMImage thumbImage = new UMImage(activity, thumb);
            UMWeb web = new UMWeb(link);
            /**
             * 标题
             */
            web.setTitle(title);
            /**
             * 缩略图
             */
            web.setThumb(thumbImage);
            /**
             * 描述
             */
            web.setDescription(desc);

            new ShareAction(activity).setPlatform(getPlatForm(platform))
                    .withMedia(web)
                    .setCallback(new UmengShareActionListener(activity, result)).share();
        } else {
            buildParamError(result);
        }
    }

    /**
     * 分享多媒体
     *
     * @param call
     * @param result
     */
    private void shareMedia(
            MethodCall call, final Result result) {
        if (call.hasArgument(Constants.Key.TYPE)) {
            final int type = call.argument(Constants.Key.TYPE);
            Logger.getInstance().defaultTagD("type = ",type);
            switch (type) {
                case TYPE_MUSIC:
                    shareMusic(mRegistrar.activity(), call, result);
                    break;
                case TYPE_VIDEO:
                    shareVideo(mRegistrar.activity(), call, result);
                    break;
                case TYPE_WEB:
                    shareWeb(mRegistrar.activity(), call, result);
                    break;
                default:
                    Map<String, Object> map = new HashMap<>();
                    map.put(Constants.Key.CODE, Constants.Key.CODE_ERROR);
                    map.put(Constants.Key.MSG, "INVALID TYPE");
                    result.success(map);
                    break;
            }
        } else {
            buildParamError(result);
        }
    }

    /**
     * 登录
     *
     * @param call
     * @param result
     */
    private void login(MethodCall call, final Result result) {
        if (call.hasArgument(Constants.Key.PLATFORM)) {
            int platform = call.argument(Constants.Key.PLATFORM);
            UMShareAPI.get(mRegistrar.activity()).getPlatformInfo(mRegistrar.activity(), getPlatForm(platform), new UMAuthListener() {
                @Override
                public void onStart(SHARE_MEDIA share_media) {

                }

                @Override
                public void onComplete(SHARE_MEDIA share_media, int i, Map<String, String> params) {
                    Map<String, Object> map = new HashMap<>(1);
                    map.put(Constants.Key.CODE, Constants.Key.CODE_SUC);
                    result.success(map);
                }

                @Override
                public void onError(SHARE_MEDIA share_media, int i, Throwable throwable) {
                    Map<String, Object> map = new HashMap<>(2);
                    map.put(Constants.Key.CODE, Constants.Key.CODE_ERROR);
                    map.put(Constants.Key.MSG, throwable.getMessage());
                    result.success(map);
                }

                @Override
                public void onCancel(SHARE_MEDIA share_media, int i) {
                    Map<String, Object> map = new HashMap<>(1);
                    map.put(Constants.Key.CODE, Constants.Key.CODE_CANCEL);
                    result.success(map);
                }
            });
        } else {
            buildParamError(result);
        }
    }

    /**
     * 分享小程序
     *
     * @param call
     * @param result
     */
    private void shareMiniApp(MethodCall call, final Result result) {
        if (call.hasArgument(Constants.Key.URL) && call.hasArgument(Constants.Key.THUMB) &&
                call.hasArgument(Constants.Key.TITLE) && call.hasArgument(Constants.Key.DESC) &&
                call.hasArgument(Constants.Key.PATH) && call.hasArgument(Constants.Key.USER_NAME)) {
            String url = call.argument(Constants.Key.URL);
            String thumb = call.argument(Constants.Key.THUMB);
            String title = call.argument(Constants.Key.TITLE);
            String desc = call.argument(Constants.Key.DESC);
            String path = call.argument(Constants.Key.PATH);
            String username = call.argument(Constants.Key.USER_NAME);
            UMMin umMin = new UMMin(url);
            umMin.setThumb(new UMImage(mRegistrar.activity(), thumb));
            umMin.setTitle(title);
            umMin.setDescription(desc);
            umMin.setPath(path);
            umMin.setUserName(username);
            new ShareAction(mRegistrar.activity())
                    .withMedia(umMin)
                    .setPlatform(SHARE_MEDIA.WEIXIN)
                    .setCallback(new UmengShareActionListener(mRegistrar.activity(), result)).share();
        } else {
            buildParamError(result);
        }
    }

    /**
     * 判断是否安装
     *
     * @param call
     * @param result
     */
    private void checkInstall(MethodCall call, final Result result) {
        if (call.hasArgument(Constants.Key.PLATFORM)) {
            int platform = call.argument(Constants.Key.PLATFORM);
            boolean flag = UMShareAPI.get(mRegistrar.context()).isInstall(mRegistrar.activity(), getPlatForm(platform));
            Map<String, Object> map = new HashMap<>(1);
            if (flag) {
                map.put(Constants.Key.CODE, Constants.Key.CODE_SUC);
            } else {
                map.put(Constants.Key.CODE, Constants.Key.CODE_ERROR);
            }

            result.success(map);
        } else {
            buildParamError(result);
        }
    }

    private void buildSucResult(Result result) {
        Map<String, Object> map = new HashMap<>(1);
        map.put(Constants.Key.CODE, Constants.Key.CODE_SUC);
        result.success(map);
    }

    private void buildParamError(Result result) {
        Map<String, Object> map = new HashMap<>(1);

        map.put(Constants.Key.CODE, Constants.Key.CODE_ERROR);
        map.put(Constants.Key.MSG, Constants.ERROR_PARAM);


        result.success(map);
    }
}
