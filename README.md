
# react-native-horse-ride-gz-journey

## Getting started

`$ npm install react-native-horse-ride-gz-journey --save`

### Mostly automatic installation

`$ react-native link react-native-horse-ride-gz-journey`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-horse-ride-gz-journey` and add `RNHorseRideGzJourney.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNHorseRideGzJourney.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNHorseRideGzJourneyPackage;` to the imports at the top of the file
  - Add `new RNHorseRideGzJourneyPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-horse-ride-gz-journey'
  	project(':react-native-horse-ride-gz-journey').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-horse-ride-gz-journey/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-horse-ride-gz-journey')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNHorseRideGzJourney.sln` in `node_modules/react-native-horse-ride-gz-journey/windows/RNHorseRideGzJourney.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Horse.Ride.Gz.Journey.RNHorseRideGzJourney;` to the usings at the top of the file
  - Add `new RNHorseRideGzJourneyPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RNHorseRideGzJourney from 'react-native-horse-ride-gz-journey';

// TODO: What to do with the module?
RNHorseRideGzJourney;
```
  