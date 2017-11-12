# KisiBeacon

This is a sample project using the iBeacons API and Kisi Door API to open doors and persist the number of times a particular door has been opened

To Run
- Open the Project in Xcode
- Open the Constants.swift file and update the iBeacon UUID you want to test on
- Thats it! Run the project in a device!

There are 3 singleton managers that handle API's and database handling
- Beacon Manager: Handles all the Location And Beacon API Calls
- KisiDoorManager: Handles the API Call for unlocking of a beacon door
- DataManager: Handles the persistence of the Beacon along with the number of times it was unlocked

CustomLockView
- This is the Custom view for creating and animating the Lock.

Every four seconds the app checks to see if the beacon being monitored is in the vicinity (~50cms) and then calls the Kisi Door API to unlock that door
