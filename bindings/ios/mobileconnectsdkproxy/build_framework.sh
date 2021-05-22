# adjust this to match your xcode compiler.
# run xcodebuild -showsdks to see which ones you have
XC_SDK_VERSION=14.5

xcodebuild -sdk iphoneos$XC_SDK_VERSION -project MobileConnectSdkProxy.xcodeproj -configuration Release
xcodebuild -sdk iphonesimulator$XC_SDK_VERSION -project MobileConnectSdkProxy.xcodeproj -configuration Release

rm -rf ./MobileConnectSdkProxy.xcframework
xcodebuild -create-xcframework -framework build/Release-iphoneos/MobileConnectSdkProxy.framework -framework build/Release-iphonesimulator/MobileConnectSdkProxy.framework -output MobileConnectSdkProxy.xcframework

# Generate ApiDefs using sharpie
# sharpie bind --sdk=iphoneos$XC_SDK_VERSION --output="XamarinApiDef" --namespace="Binding" --scope="MobileConnectSdkProxy.xcframework/ios-arm64/MobileConnectSdkProxy.framework/Headers" "MobileConnectSdkProxy.xcframework/ios-arm64/MobileConnectSdkProxy.framework/Headers/MobileConnectSdkProxy.h" "MobileConnectSdkProxy.xcframework/ios-arm64/MobileConnectSdkProxy.framework/Headers/MobileConnectSdkProxy-Swift.h"