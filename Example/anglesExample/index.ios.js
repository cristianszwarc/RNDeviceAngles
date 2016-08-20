/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  DeviceEventEmitter
} from 'react-native';
import Button from 'react-native-button';
import { DeviceAngles } from 'NativeModules';

DeviceAngles.setDeviceMotionUpdateInterval(0.1);

class anglesExample extends Component {

  constructor(props) {
    super(props);
    this.state = {
      pitch: 0,
      roll: 0,
      yaw: 0,
      enabled: false
    };
  }

  componentDidMount() {
    DeviceEventEmitter.addListener('DeviceAnglesData', function (data) {
      this.setState({
        pitch: data.pitch.toFixed(5),
        roll: data.roll.toFixed(5),
        yaw: data.yaw.toFixed(5)
      });
    }.bind(this));
  }

  componentWillUnmount() {
    DeviceAngles.stopMotionUpdates();
  }

  handleButton() {
    if (this.state.enabled) {
      this.setState({
        enabled: false
      });
      DeviceAngles.stopMotionUpdates();
    } else {
      this.setState({
        enabled: true
      });
      DeviceAngles.startMotionUpdates();
    }
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.title}>
          Angles example
        </Text>
        <Text>pitch: {this.state.pitch}</Text>
        <Text>roll: {this.state.roll}</Text>
        <Text>yaw: {this.state.yaw}</Text>
        {
          (this.state.enabled) ?
          <Button style={{color: 'red', margin: 20}} onPress={this.handleButton.bind(this)}>Stop</Button> :
          <Button style={{color: 'green', margin: 20}} onPress={this.handleButton.bind(this)}>Start</Button>
        }
        </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  title: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  }
});

AppRegistry.registerComponent('anglesExample', () => anglesExample);
