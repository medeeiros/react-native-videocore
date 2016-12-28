/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  requireNativeComponent,
  NativeModules,
  DeviceEventEmitter,
  TouchableHighlight
} = require('react-native');

var VideoCoreView = requireNativeComponent('RCTVideoCoreView', null);

var VideoCore = React.createClass({
  statics: {
    startStreaming: function(url, key) {
      NativeModules.VideoCoreViewManager.startStreaming(url, key)
    },

    stopStreaming: function() {
      NativeModules.VideoCoreViewManager.stopStreaming()
    },
  },

  getInitialState: function() {
    return {
      status: 'VCSessionStateNone'
    }
  },

  componentWillMount: function(){
    NativeModules.VideoCoreViewManager.stopStreaming()
    this.connectionStatusChangedListener = DeviceEventEmitter.addListener('videocore.connectionStatusChanged', this._onConnectionStatusChanged)
  },

  _onConnectionStatusChanged: function(e) {
    this.setState({
      status: e
    })
    this.props.onConnectionStatusChanged && this.props.onConnectionStatusChanged(e)
  },

  componentWillUnmount: function(){
    this.connectionStatusChangedListener.remove();
    NativeModules.VideoCoreViewManager.stopStreaming()
  },

  render: function() {
    return <VideoCoreView {...this.props} />
  }

})

var RNVideoCore = React.createClass({

  getInitialState: function() {
    return {
      showPreview: false
    }
  },
  render: function() {
    var previewOrButton = (this.state.showPreview) ?
      <VideoCore style={{ alignSelf: 'stretch', flex: 1 }} onConnectionStatusChanged={(e) => console.log(e)}>
        <TouchableHighlight onPress={() => VideoCore.startStreaming('rtmp://104.155.71.82:1935/live', 'myStream')}><Text style={{color: "#fff", margin: 50}}>START Streaming</Text></TouchableHighlight>
        <TouchableHighlight onPress={() => VideoCore.stopStreaming()}><Text style={{color: "#fff", margin: 50}}>STOP Streaming</Text></TouchableHighlight>
      </VideoCore> :
      <TouchableHighlight onPress={() => this.setState({showPreview: true})}><Text>Open Streaming</Text></TouchableHighlight>

    return (
      <View style={styles.container}>
        {previewOrButton}
      </View>
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  }
});

// AppRegistry.registerComponent('RNVideoCore', () => RNVideoCore);

module.exports = VideoCore;
