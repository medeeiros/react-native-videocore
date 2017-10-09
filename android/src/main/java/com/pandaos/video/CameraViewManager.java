package com.pandaos.video;

import android.util.Log;

import com.facebook.infer.annotation.Assertions;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.ViewGroupManager;

import java.util.Locale;
import java.util.Map;

/**
 * Created by orenkosto on 8/31/17.
 */

public class CameraViewManager extends ViewGroupManager<CameraView> {

    public static final String REACT_CLASS = "CameraView";

    public static final int COMMAND_START_STREAMING = 1;
    public static final int COMMAND_STOP_STREAMING = 2;
    public static final int COMMAND_TOGGLE_TORCH = 3;
    public static final int COMMAND_FLIP_CAMERA = 4;

    private static CameraView cameraView;

    @Override
    public String getName() {
        return REACT_CLASS;
    }

    @Override
    protected CameraView createViewInstance(ThemedReactContext reactContext) {
        cameraView = new CameraView(reactContext);
        return cameraView;
    }

//    @ReactProp(name = "callback")
//    public void setCallback(CameraView view, @Nullable CameraView.CameraViewCallback callback) {
//        view.callback = callback;
//    }

    @Override
    public Map<String,Integer> getCommandsMap() {
        Log.d("React"," View manager getCommandsMap:");
        return MapBuilder.of(
                "startStreaming", COMMAND_START_STREAMING,
                "stopStreaming", COMMAND_STOP_STREAMING,
                "toggleTorch", COMMAND_TOGGLE_TORCH,
                "flipCamera", COMMAND_FLIP_CAMERA
                );
    }

    @Override
    public void receiveCommand(
            CameraView view,
            int commandType, ReadableArray args) {
        Assertions.assertNotNull(view);
        Assertions.assertNotNull(args);
        switch (commandType) {
            case COMMAND_START_STREAMING: {
                view.startStreaming(args.getString(0));
                return;
            }
            case COMMAND_STOP_STREAMING: {
                view.stopStreaming();
                return;
            }
            case COMMAND_TOGGLE_TORCH: {
                view.toggleTorch();
                return;
            }
            case COMMAND_FLIP_CAMERA: {
                view.flipCamera();
                return;
            }
            default:
                throw new IllegalArgumentException(String.format(Locale.getDefault(),
                        "Unsupported command %d received by %s.",
                        commandType,
                        getClass().getSimpleName()));
        }
    }
}
