/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  requireNativeComponent,
  NativeModules,
  TouchableHighlight
} = React;

var VideoCoreView = requireNativeComponent('RCTVideoCoreView', null);

var RNVideoCore = React.createClass({
  getInitialState: function() {
    return {
      showPreview: false
    }
  },
  render: function() {
    var previewOrButton = (this.state.showPreview) ?
      <VideoCoreView style={{position: 'absolute', top: 0 }} /> :
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
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('RNVideoCore', () => RNVideoCore);
