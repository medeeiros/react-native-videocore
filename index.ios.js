/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

import React, {Component} from 'react';
import ReactNative, {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    requireNativeComponent,
    NativeModules,
    DeviceEventEmitter,
    TouchableHighlight
} from 'react-native';

var VideoCoreView = requireNativeComponent('RCTVideoCoreView', null);

export class VideoCore extends Component {
    constructor(props) {
        super(props);
        this.state = {
            status: 'VCSessionStateNone'
        }
    }


    componentWillMount() {
        NativeModules.VideoCoreViewManager.stopStreaming()
        this.connectionStatusChangedListener = DeviceEventEmitter.addListener('videocore.connectionStatusChanged', this._onConnectionStatusChanged.bind(this))
    }

    _onConnectionStatusChanged(e) {
        this.setState({
            status: e
        })
        this.props.onConnectionStatusChanged && this.props.onConnectionStatusChanged(e)
    }

    componentWillUnmount() {
        this.connectionStatusChangedListener.remove();
        NativeModules.VideoCoreViewManager.stopStreaming()
    }

    render() {
        return <VideoCoreView {...this.props} />
    }

    startStreaming(url, key) {
        NativeModules.VideoCoreViewManager.startStreaming(url, key);
    }

    stopStreaming() {
        NativeModules.VideoCoreViewManager.stopStreaming();
    }

    toggleTorch() {
        NativeModules.VideoCoreViewManager.toggleTorch();
    }

    flipCamera() {
        NativeModules.VideoCoreViewManager.flipCamera();
    }

    setResolution(width, height) {
        NativeModules.VideoCoreViewManager.setResolution(width, height);
    }

    setBitrate(bitrate) {
        NativeModules.VideoCoreViewManager.setBitrate(bitrate);
    }

    setFps(fps) {
        NativeModules.VideoCoreViewManager.setFps(fps);
    }
};


class RNVideoCore extends Component {

    getInitialState() {
        return {
            showPreview: false
        }
    }
    render() {
        var previewOrButton = (this.state.showPreview) ?
            <VideoCore style={{ alignSelf: 'stretch', flex: 1 }} onConnectionStatusChanged={(e) => console.log(e)}>
                <TouchableHighlight onPress={() => VideoCore.startStreaming('rtmp://stream.panda-os.com/pandaLive', 'mp4:0_fdm8zu97')}><Text style={{color: "#fff", margin: 50}}>START Streaming</Text></TouchableHighlight>
                <TouchableHighlight onPress={() => VideoCore.stopStreaming()}><Text style={{color: "#fff", margin: 50}}>STOP Streaming</Text></TouchableHighlight>
            </VideoCore> :
            <TouchableHighlight onPress={() => this.setState({showPreview: true})}><Text>Open Streaming</Text></TouchableHighlight>

        return (
            <View style={styles.container}>
                {previewOrButton}
            </View>
        );
    }
};

var styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
    }
});
AppRegistry.registerComponent('VideoCore', () => VideoCore);

AppRegistry.registerComponent('RNVideoCore', () => RNVideoCore);
