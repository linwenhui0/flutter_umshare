package com.yf.umeng.share.listener;

import android.app.Activity;

import com.hlibrary.util.Logger;
import com.umeng.socialize.UMShareListener;
import com.umeng.socialize.bean.SHARE_MEDIA;
import com.yf.umeng.share.constant.Constants;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

/**
 * @author linwenhui
 */
public class UmengShareActionListener implements UMShareListener {

    private final Activity activity;
    private final MethodChannel.Result result;

    public UmengShareActionListener(Activity activity, MethodChannel.Result result) {
        this.activity = activity;
        this.result = result;
    }

    @Override
    public void onStart(SHARE_MEDIA shareMedia) {
        Logger.getInstance().defaultTagD("onStart == ", shareMedia.getName());
    }

    @Override
    public void onResult(SHARE_MEDIA shareMedia) {
        Logger.getInstance().defaultTagD("onResult == ", shareMedia.getName());
        Map<String, Object> map = new HashMap<>(1);
        map.put(Constants.Key.CODE, Constants.Key.CODE_SUC);
        result.success(map);
    }

    @Override
    public void onError(SHARE_MEDIA shareMedia, Throwable throwable) {
        Logger.getInstance().defaultTagD("onResult == ", shareMedia.getName());
        Map<String, Object> map = new HashMap<>(2);
        map.put(Constants.Key.CODE, Constants.Key.CODE_ERROR);
        map.put(Constants.Key.MSG, throwable.getMessage());
        result.success(map);
    }

    @Override
    public void onCancel(SHARE_MEDIA shareMedia) {
        Logger.getInstance().defaultTagD("onCancel == ", shareMedia.getName());
        Map<String, Object> map = new HashMap<>(1);
        map.put(Constants.Key.CODE, Constants.Key.CODE_CANCEL);
        result.success(map);
    }
}
