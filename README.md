# React Native - Device Angles

-------------------------------
Get rotation information (pitch, yaw, roll) - ios


## Getting started

`$ npm install react-native-device-angles --save`

### Mostly automatic installation ( react-native < 0.60 )

`$ react-native link react-native-device-angles`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-device-angles` and add `DeviceAngles.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libDeviceAngles.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<


## Usage
```javascript
import { DeviceEventEmitter } from 'react-native';
import DeviceAngles from 'react-native-device-angles';

DeviceAngles.setDeviceMotionUpdateInterval(0.1);
...
DeviceAngles.startMotionUpdates();
...
DeviceEventEmitter.addListener('AnglesData', function (data) {
  console.log(data.pitch);
  console.log(data.roll);
  console.log(data.yaw);
});
```

**Log**
0.1.0 updated import statement by srt0422
0.1.2 Support for react-native 0.60+

**ToDo**
improve this readme

**Screens**

![example](screens/example.png)

**License**
MIT
