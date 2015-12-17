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
  NativeModules
} = React;

var VideoCoreView = requireNativeComponent('RCTVideoCoreView', null);

var RNVideoCore = React.createClass({
  render: function() {
    return (
      <View style={styles.container}>
        <VideoCoreView style={{position: 'absolute', top: 0 }} />
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
