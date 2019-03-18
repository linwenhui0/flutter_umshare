package com.yf.umeng.share.constant;

public class Constants {

    /**
     * 初始化友盟
     */
    public static final String INIT = "initWithAppKey";

    /**
     * 文本分享
     */
    public static final String SHARE_TEXT = "shareText";

    /**
     * 分享图片
     */
    public static final String SHARE_IMAGE = "shareImage";

    /**
     * 分享财富
     */
    public static final String SHARE_MEDIA = "shareMedia";

    /**
     * 音乐类型
     */
    public static final int TYPE_MUSIC = 0x01;
    /**
     * 视频类型
     */
    public static final int TYPE_VIDEO = 0x02;
    /**
     * WEB类型
     */
    public static final int TYPE_WEB = 0x03;

    /**
     * 登录
     */
    public static final String LOGIN = "login";

    /**
     * 分享小程序
     */
    public static final String SHARE_MINI_APP = "shareMiniApp";

    /**
     * 判断程序是否安装
     */
    public static final String CHECK_INSTALL = "checkInstall";

    public static final String ERROR_PARAM = "缺少必传参数";

    /**
     * 平台
     */
    public static class PlatForm {
        public static final int QQ = 0x01;
        public static final int QZONE = 0x02;
        public static final int WEI_XIN = 0x03;
        public static final int WEI_XIN_FRIEND = 0x04;
    }

    public static class Key {

        /**
         * 状态
         */
        public static final String CODE = "um_code";

        /**
         * 出错消息
         */
        public static final String MSG = "um_msg";

        /**
         * 状态成功
         */
        public static final int CODE_SUC = 0x00;

        /**
         * 状态出错
         */
        public static final int CODE_ERROR = 0x02;

        /**
         * 取消取消
         */
        public static final int CODE_CANCEL = 0x01;

        /**
         * 分享到的平台
         */
        public static final String PLATFORM = "platform";
        /**
         * 分享文本key
         */
        public static final String TEXT = "text";
        /**
         * 分享封面图片
         */
        public static final String THUMB = "thumb";
        /**
         * 分享图片
         */
        public static final String IMAGE = "image";
        /**
         * 友盟app_key
         */
        public static final String APP_KEY = "AppKey";
        /**
         * 微信app_key
         */
        public static final String WEI_XIN_APP_KEY = "WeiXinAppKey";
        /**
         * 微信app_Secret
         */
        public static final String WEI_XIN_APP_SECRET = "WeiXinAppSecret";
        /**
         * QQ app_key
         */
        public static final String QQ_APP_KEY = "QQAppKey";
        /**
         * QQ app_Secret
         */
        public static final String QQ_APP_SECRET = "QQAppSecret";

        /**
         * 分享媒体类型
         */
        public static final String TYPE = "type";

        /**
         * 标题
         */
        public static final String TITLE = "title";

        /**
         * 描述
         */
        public static final String DESC = "desc";

        /**
         * 链接
         */
        public static final String LINK = "link";

        public static final String URL = "url";
        public static final String PATH = "path";
        public static final String USER_NAME = "username";
    }


}
