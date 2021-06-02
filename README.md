# Overview

This community-supported software is provided to you under the terms of the [MIT License][license]. Accordingly, it is offered with no warranty.  

Gallagher moderates this source code repository, and at times Gallagher employees may contribute source code changes, but this does not constitute official support nor a commitment to maintain the software. 

If you encounter a problem with the software you are encouraged to submit a Pull Request containing a proposed fix to help ensure the success of this community project.


## Android Bindings

The Xamarin Bindings project for Android can be found under the [bindings/android][bindingsandroid] directory

The Xamarin Sample application for Android can be found under the [samples/android][samplesandroid] directory.  
We recommend that you start by building and running the Sample application from its `.sln`, before moving on to integrate the bindings project into your own application

## iOS Bindings

The iOS SDK is written in "pure" Swift, which Xamarin cannot directly use.  
As per [Microsoft's iOS binding documentation](ms-ios-bindings), an Objective-C compatible "proxy" framework is required. The Xamarin bindings then reference this proxy framework.

The proxy framework for iOS (Xcode project) can be found under the [bindings/ios/mobileconnectsdkproxy][bindingsiosproxy] directory

The Xamarin Bindings project for iOS can be found under the [bindings/ios/MobileConnectSdk.iOS.Bindings][bindingsios] directory

The Xamarin Sample application for Android can be found under the [samples/ios][samplesios] directory.  
We recommend that you start by building and running the Sample application from its `.sln`, before moving on to integrate the bindings project into your own application

# Status

Note: A tick means that code exists for the feature. It does not indicate quality or testing.

| API                      | Android Binding | Android Sample | iOS Proxy | iOS Binding | iOS Sample |
| ------------------------ | --------------- | -------------- | --------- | ----------- | -----------|
| SDK initialisation       | ✅              | ✅             | ✅         | ✅          | ✅          |
| localisation             | ✅              | -              | ✅         | ✅          | -          |
| unlock notification config| ✅              | ✅            | ?          | ?          | ?          |
| register Credential      | ✅              | ✅             | ✅         | ✅          | ✅          |
| delete Credential        | ✅              | ✅             | ✅         | ✅          | -          |
| list Credentials         | ✅              | ✅             | ✅         | ✅          | -          |
| sdk state feedback       | ✅              | ✅             | ✅         | ✅          | -          |
| permissions              | ✅              | ✅             | -          | -          | -          |
| enable BLE scanning      | ✅              | ✅             | ✅         | ✅          | ✅         |
| enable BLE background    | ✅              | ✅             | ✅         | ✅          | -          |
| automatic access         | ✅              | ✅             | ✅         | ✅          | ✅         |
| automatic access feedback| ✅              | ✅             | ✅         | ✅          | -          |
| nearby reader feedback   | ✅              | ✅             | ✅         | ✅          | -          |
| manual access            | ✅              | ✅             | -          | -          | -          |
| manual access feedback   | ✅              | ✅             | -          | -          | -          |
| SALTO integration        | -               | -              | -          | -          | -         |
| Digital ID               | -               | -             | -          | -          | -          |
| Cross-site credentials   | -               | -             | -          | -          | -          |
| Android NFC              | ✅              | ✅             | n/a         | n/a       | n/a        |


[license]: LICENSE
[bindingsandroid]: bindings/android
[samplesandroid]: samples/android
[ms-ios-bindings]: https://docs.microsoft.com/en-us/xamarin/ios/platform/binding-swift/walkthrough
[bindingsiosproxy]: bindings/ios/mobileconnectsdkproxy
[bindingsios]: bindings/ios/MobileConnectSdk.iOS.Bindings
[samplesios]: samples/ios
