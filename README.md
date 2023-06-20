# Swift Examples

This repository contains example Swift projects that use the brainCloud client. This is a good place to start learning how the various brainCloud APIs can be used.

### Standalone Client Lib

Find our latest releases of our ObjC client library [here](https://github.com/getbraincloud/braincloud-objc).

## Basic Example

This is Swift example demonstrates the following:

- brainCloud Setup
- Authentication with Email/Password and Google OpenId
- Entities
- Push Notifications
- Simple Relay Setup

![Basic](screenshots/Basic.png?raw=true "Basic")

### Basic example Setup

Edit the Info.plist with the App ID and Secret Key or edit the initialize call in AppDelegate.swift source code.
eg.

```
plutil -replace BCAppId -string "xxxxx" Basic\ Example/Basic\ Example/Info.plist
plutil -replace BCSecretKey -string "yyyyy" Basic\ Example/Basic\ Example/Info.plist
plutil -replace BCServerUrl -string "https://api.braincloudservers.com/dispatcherV2" Basic\ Example/Basic\ Example/Info.plist
```

```
AppDelegate._bc.initialize("https://api.braincloudservers.com/dispatcherv2",
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


## bcChat Example

This is Swift example demonstrates the following brainCloud features:

- Authentication with Email/Password and AuthenticateApple
- Apple In-app purchase with brainCloud product setup and verify purchase
- brainCloud RTT chat feature

![bcChat1](screenshots/bcChat1.png?raw=true "bcChat1")
![bcChat2](screenshots/bcChat2.png?raw=true "bcChat2")

### bcChat setup

- Install pods with the PodFile that under `bcChat Example` folder.

- Create a `config-dev.xcconfig` file under `Resources` folder, set the following values inside this config file respectively.

```
serverUrl = https:/$()/api.braincloudservers.com/dispatcherV2
secretKey = brainCloud app secretKey
appId = brainCloud appId
appVersion = 1.0.0
companyName = your company name
appName = brainCloud app name
```

- Optional: From your apple developer account set up In-app purchase and sign in apple capabilities to your app if your want to test apple IAP and apple signIn.

### M1 pod installation issue
If you're having issues while installing pod dependencies on an M1 mac, please try the following:
```shell
# Install ffi
sudo arch -x86_64
gem install ffi

# Re-install dependencies
arch -x86_64 pod install
```
