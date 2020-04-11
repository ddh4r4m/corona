# corona

A new Flutter application.

## Development Overview

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Developer Setup

Clone this project on your Windows/Mac/Linux.

### Google Maps API Key
You will need to generate a Google API key in order for the mapping features to work correctly. Refer to this guide [guide](https://developers.google.com/maps/documentation/ios-sdk/get-api-key) in order to create the API key.

Once created you will need to add it to two different places in the project. One for Android and one for iOS.

* Android - open `android/app/src/main/AndroidManifest.xml`and search for `com.google.android.geo.API_KEY`. Add your key to the `android:value` property.
* iOS - open `ios/SafePaths/AppDelegate.m` and search for `GMSServices provideAPIKey` and replace line with `[GMSServices provideAPIKey:@"YOUR_API_KEY"];`
