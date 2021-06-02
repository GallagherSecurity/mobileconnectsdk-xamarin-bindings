# Overview

This community-supported software is provided to you under the terms of the [MIT License][license]. Accordingly, it is offered with no warranty.  

Gallagher moderates this source code repository, and at times Gallagher employees may contribute source code changes, but this does not constitute official support nor a commitment to maintain the software. 

If you encounter a problem with the software you are encouraged to submit a Pull Request containing a proposed fix to help ensure the success of this community project.


## Android Bindings

The Xamarin Bindings project for Android can be found under the [bindings/android][bindingsandroid] directory

The Xamarin Sample application for Android can be found under the [samples/android][samplesandroid] directory. You may wish to start by checking you can build and run the Sample application before moving on to integrate the bindings project into your own application

## iOS Bindings

The Xamarin Bindings project for iOS can be found under the [bindings/ios][bindingsios] directory

The Xamarin Sample application for Android can be found under the [samples/ios][samplesios] directory. You may wish to start by checking you can build and run the Sample application before moving on to integrate the bindings project into your own application

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
[bindingsios]: bindings/ios
[samplesios]: samples/ios
