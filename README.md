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

### M1 pod installation issue
If you're having issues while installing pod dependencies on an M1 mac, please try the following:
```shell
# Install ffi
sudo arch -x86_64
gem install ffi

# Re-install dependencies
arch -x86_64 pod install
```
