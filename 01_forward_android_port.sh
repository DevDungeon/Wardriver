# Use Android debug bridge to forward BlueNMEA data from Android to laptop

# Before doing this, the Android device must be running the BlueNMEA software
# and connected to the computer via USB. The device will likely also need
# USB debugging turned on 
# (In new versions, turn on debug mode from about->build number->tap 10 times)

adb forward tcp:4352 tcp:4352