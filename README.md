# Swift Examples

This repository contains example Swift projects that use the brainCloud client. This is a good place to start learning how the various brainCloud APIs can be used.

### Standalone Client Lib

Find our latest releases of our ObjC client library [here](https://github.com/getbraincloud/braincloud-objc).

## Basic Example

This is Swift example demonstrates the following:

- brainCloud Setup
- Authentication
- Entities
- Push Notifications

![Basic](screenshots/Basic.png?raw=true "Basic")

## Setup

Edit the Info.plist with the App ID and Secret Key or edit the initialize call in AppDelegate.swift source code.
eg.

```
plutil -replace BCAppId -string "xxxxx" Basic\ Example/Basic\ Example/Info.plist
plutil -replace BCSecretKey -string "yyyyy" Basic\ Example/Basic\ Example/Info.plist
plutil -replace BCServerUrl -string "https://api.braincloudservers.com/dispatcherV2" Basic\ Example/Basic\ Example/Info.plist
```

```         AppDelegate._bc.initialize("https://api.braincloudservers.com/dispatcherv2",
         secretKey: YOUR_SECRET,
         gameId: YOUR_APPID,
         gameVersion: "1.0.0",
         companyName: YOUR_COMPANY,
         gameName: YOUR_GAME_NAME)
```

## SwiftUI Example

This is SwiftUI example demonstrates the following:

- brainCloud Initialize
- Authentication
- View the corresponding API doc simultaneously via WebView

![SwiftUIe2](screenshots/SwiftUI2.png?raw=true "SwiftUIe2")
![SwiftUIe1](screenshots/SwiftUI1.png?raw=true "SwiftUIe1")

### M1 pod installation issue
If you're having issues while installing pod dependencies on an M1 mac, please try the following:
```shell
# Install ffi
sudo arch -x86_64
gem install ffi

# Re-install dependencies
arch -x86_64 pod install
```
