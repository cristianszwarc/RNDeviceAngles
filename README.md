#React Native - DeviceAngles
Get rotation information (pitch, yaw, roll) - ios

#use

react-native init myProject

cd myProject

npm install react-native-device-angles --save

open the xcode project from your react-native application (myProject/ios/myProject.xcode)

right click on Libraries then "add files" then select node_modules/react-native-device-angles/RNDeviceAngles.xcode

click on your xCode project, then select the build phases tab and inside Link Binary With Libraries add libRNDeviceAngles.a to the list

run

# Develop this library
npm install
