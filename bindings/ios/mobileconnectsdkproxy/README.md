# Build Instructions

**Prerequisites:**

To build the proxy you just need Xcode. This document last tested against Xcode version 12.5

To build the Xamarin bindings library you need Visual Studio for Mac, with the Xamarin iOS tools installed.
This document was last tested against Visual Studio for Mac version 8.10 (preview) with Xamarin.iOS version 14.19.0.7

### Step 1. Configure Dependencies

To build the proxy library, please obtain the following from Gallagher.

1. **GallagherMobileAccess.xcframework**
2. **RxSwift.xcframework**

Place them in this directory (alongside README.md), as this is where the proxy xcodeproj expects them to be.

You should then be able to build the **MobileConnectSdkProxy** project in Xcode to verify the dependencies are in the right place

### Step 2. Build in release mode, and package into an xcframework

1. Open `build_framework.sh` in the editor of your choice and check that the `XC_SDK_VERSION` matches your installed version of Xcode

2. If you are also wanting to work on updating the Xamarin bindings, you probably want to uncomment the bit at the bottom to invoke objective-sharpie to regenerate the binding definitions. If you just want to build the proxy framework so you can use it, rather than editing it, then leaving this commented is fine.

3. Run `./build_framework.sh` from this directory. If successful, you should now see **MobileConnectSdkProxy.xcframework** generated in this directory, alongside the other two dependencies

### Step 3. Use the bindings

Open the iOS SDK Sample app, which references the bindings project, and build it. It should work, and you should be able to launch it on an iOS simulator as well as a device.
