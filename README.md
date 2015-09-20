# NanoWardriver

Generate a Google Earth .KML file with wireless access points pinned.
Pins are color coded based on encryption type. Clicking on a pin shows
information about the clients connected to that wireless access point.

## How it Works

The Android device should be connected to the laptop via USB. BlueNMEA runs
on the Android device and sends gps information to a local TCP port. The
laptop uses adb to forward that TCP port from the Android device to itself.
Gpsd is run on the laptop using the fowarded port as a data source.
When Kismet is run it automatically detects and uses the information from
gpsd. When Kismet is done running, it generates a .netxml file. Giskismet
uses that .netxml to create a SQLite database. Then, giskismet is used
to create the .kml file that can be opened in Google Earth.

## Instructions

**Prepare the Android device**

* Install the BlueNMEA app on the Android device
* Connect the Android device to the laptop via USB
* Run BlueNMEA. When running it will tell you it is listening on TCP 4352.

**On the laptop**

Forward port from Android device to computer (execute from laptop)

	adb forward tcp:4352 tcp:4352

Turn on gpsd and have it use the port we forwarded as the source

	gpsd -N -n -D5 tcp://localhost:4352

Launch Kismet. It will automatically use gpsd on default port

	kismet

When done, get KML file from results

	giskismet -x <KismetNetXmlOutputfile>.netxml

	giskismet -q "SELECT * FROM WIRELESS" -o access_points.kml
