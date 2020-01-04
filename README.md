# Map.ir Flutter Plugin based on Mapbox GL

This Flutter plugin for [Map.ir Map SDKs](https://github.com/map-ir) enables
embedded interactive and customizable vector maps inside a Flutter widget by embedding Android and iOS views.

![screenshot.png](https://support.map.ir/wp-content/uploads/2020/01/FlutterBasicMapScreenShot-e1578121281391.jpg)

## Install
This project is available on [pub.dartlang](https://pub.dartlang.org/packages/mapir_gl), follow the [instructions](https://flutter.dev/docs/development/packages-and-plugins/using-packages#adding-a-package-dependency-to-an-app) to integrate a package into your flutter application.

### Running example app

- Install [Flutter](https://flutter.io/get-started/) and validate its installation with `flutter doctor`
- Clone this repository with `git clone git@github.com:map-ir/mapir-flutter-map-sdk.git`
- Run the app with `cd mapir-flutter-map-sdk/example && flutter run`

#### Mpair Access Token

This project uses Map.ir vector tiles, which requires a Map.ir account and an API key. Obtain a free access token on [Map.ir App Registration](https://corp.map.ir/registration).

##### Android
Add Mapi.ir read token value in the application manifest ```android/app/src/main/AndroidManifest.xml:```

```<manifest ...
  <application ...
    <meta-data android:name="ir.map.apikey" android:value="YOUR_TOKEN_HERE" />
```

#### iOS
Add these lines to your Info.plist

```plist
<key>io.flutter.embedded_views_preview</key>
<true/>
<key>MapirAPIKey</key>
<string>YOUR_TOKEN_HERE</string>
```

## Supported API

| Feature | Android | iOS |
| ------ | ------ | ----- |
| Style | :white_check_mark:   | :white_check_mark: |
| Camera | :white_check_mark:   | :white_check_mark: |
| Gesture | :white_check_mark:   | :white_check_mark: |
| User Location | :white_check_mark: | :white_check_mark: |
| Symbol | :white_check_mark:   | :white_check_mark: |
| Circle | :white_check_mark:   | :white_check_mark: |
| Line | :white_check_mark:   | :white_check_mark: |
| Fill |   |  |

## Offline Sideloading

Support for offline maps is available by *"side loading"* the required map tiles and including them in your `assets` folder.

* Place the tiles.db file generated in step one in your assets directory and add a reference to it in your `pubspec.yml` file.

```
   assets:
     - assets/cache.db
```

* Call `installOfflineMapTiles` when your application starts to copy your tiles into the location where Mapbox can access them.  **NOTE:** This method should be called **before** the Map widget is loaded to prevent collisions when copying the files into place.
 
```
    try {
      await installOfflineMapTiles(join("assets", "cache.db"));
    } catch (err) {
      print(err);
    }
```

## Documentation

Please visit [Map.ir Support](https://support.map.ir/developers/flutter/) for this flutter plugin, [iOS Maps SDK docs](https://support.map.ir/developers/ios/) and [Android Maps SDK docs](https://support.map.ir/developers/android/) for more info about native SDKs.

Visit [mapbox.com/android-docs](https://www.mapbox.com/android-docs/) if you'd like more information about the Mapbox Maps SDK for Android and [mapbox.com/ios-sdk](https://www.mapbox.com/ios-sdk/) for more information about the Mapbox Maps SDK for iOS.

## Getting Help

- **Need help with your code?**: Look for previous questions on the [#mapbox tag](https://stackoverflow.com/questions/tagged/mapbox+android) — or [ask a new question](https://stackoverflow.com/questions/tagged/mapbox+android).
- **Have a bug to report?** [Open an issue](https://github.com/map-ir/mapir-flutter-map-sdk/issues/new). If possible, include a full log and information which shows the issue.
- **Have a feature request?** [Open an issue](https://github.com/map-ir/mapir-flutter-map-sdk/issues/new). Tell us what the feature should do and why you want the feature.

## Sample code

[This repository's example library](https://github.com/map-ir/mapir-flutter-map-sdk/tree/master/example/lib) is currently the best place for you to find reference code for this project. See other samples at [Flutter docs](https://support.map.ir/developers/flutter/examples).

<!--
## Contributing

We welcome contributions to this repository!

If you're interested in helping build this Mapbox/Flutter integration, please read [the contribution guide](https://github.com/tobrun/flutter-mapbox-gl/blob/master/CONTRIBUTING.md) to learn how to get started.
-->
