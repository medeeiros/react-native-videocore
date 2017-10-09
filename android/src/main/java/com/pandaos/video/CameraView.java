package com.pandaos.video;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.FrameLayout;

/**
 * Created by orenkosto on 9/3/17.
 */

public class CameraView extends FrameLayout {

    private CameraSurfaceView cameraSurfaceView;

    public CameraView(Context context) {
        super(context);
        setup(context);
    }

    public CameraView(Context context, AttributeSet attrs) {
        super(context, attrs);
        setup(context);
    }

    private void setup(Context context) {
        cameraSurfaceView = new CameraSurfaceView(context);
        this.addView(cameraSurfaceView);
    }

    public void startStreaming(String streamUrl) {
        if (cameraSurfaceView != null) {
            cameraSurfaceView.startStreaming(streamUrl);
        }
    }

    public void stopStreaming() {
        if (cameraSurfaceView != null) {
            cameraSurfaceView.stopStreaming();
        }
    }

    public void toggleTorch() {
        if (cameraSurfaceView != null) {
            cameraSurfaceView.toggleTorch();
        }
    }

    public void flipCamera() {
        if (cameraSurfaceView != null) {
            cameraSurfaceView.flipCamera();
        }
    }
}
