package com.pandaos.video;

import android.content.Context;
import android.util.AttributeSet;
import android.view.SurfaceView;
import android.widget.Toast;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.uimanager.events.RCTEventEmitter;
import com.pedro.builder.rtmp.RtmpBuilder;

import net.ossrs.rtmp.ConnectCheckerRtmp;

/**
 * Created by orenkosto on 8/31/17.
 */

public class CameraSurfaceView extends SurfaceView implements ConnectCheckerRtmp {

    public interface CameraViewCallback {
        void onStreamStarted();
        void onStreamStopped();
        void onConnectionFailed();
    }

    private RtmpBuilder rtmpBuilder;
    public CameraViewCallback callback;

    public CameraSurfaceView(Context context) {
        super(context);
        setup();
    }

    public CameraSurfaceView(Context context, AttributeSet attrs) {
        super(context, attrs);
        setup();
    }

    private void setup() {
        rtmpBuilder = new RtmpBuilder(this, this);
    }

    public void startStreaming(String streamUrl) {
        if (!isStreaming()) {
            if (rtmpBuilder.prepareAudio() && rtmpBuilder.prepareVideo()) {
                rtmpBuilder.startStream(streamUrl);
            } else {
                Toast.makeText(getContext(), "Error preparing stream, This device cant do it", Toast.LENGTH_SHORT)
                        .show();
            }
        }
    }

    public void stopStreaming() {
        if (isStreaming()) {
            rtmpBuilder.stopStream();
        }
    }

    public boolean isStreaming() {
        return rtmpBuilder.isStreaming();
    }

    @Override
    public void onConnectionSuccessRtmp() {
        if (callback != null) {
            callback.onStreamStarted();
        }
        WritableMap event = Arguments.createMap();
//        event.putString("message", "MyMessage");
        ReactContext reactContext = (ReactContext)getContext();
        reactContext.getJSModule(RCTEventEmitter.class).
                receiveEvent(getId(), "onStreamStarted" ,event);
    }

    @Override
    public void onConnectionFailedRtmp() {
        if (callback != null) {
            callback.onConnectionFailed();
        }

        WritableMap event = Arguments.createMap();
//        event.putString("message", "MyMessage");
        ReactContext reactContext = (ReactContext)getContext();
        reactContext.getJSModule(RCTEventEmitter.class).
                receiveEvent(getId(), "onConnectionFailed" ,event);
    }

    @Override
    public void onDisconnectRtmp() {
        if (callback != null) {
            callback.onStreamStopped();
        }
        WritableMap event = Arguments.createMap();
//        event.putString("message", "MyMessage");
        ReactContext reactContext = (ReactContext)getContext();
        reactContext.getJSModule(RCTEventEmitter.class).
                receiveEvent(getId(), "onStreamStopped" ,event);
    }

    @Override
    public void onAuthErrorRtmp() {

    }

    @Override
    public void onAuthSuccessRtmp() {

    }

    public void toggleTorch() {
        rtmpBuilder.toggleTorch();
    }

    public void flipCamera() {
        rtmpBuilder.switchCamera();
    }
}
