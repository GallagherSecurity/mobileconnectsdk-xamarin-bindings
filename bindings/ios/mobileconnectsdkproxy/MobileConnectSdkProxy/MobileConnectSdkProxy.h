//
//         Copyright Gallagher Group Ltd 2021 All Rights Reserved
//
#import <Foundation/Foundation.h>

//! Project version number for MobileConnectSdkProxy.
FOUNDATION_EXPORT double MobileConnectSdkProxyVersionNumber;

//! Project version string for MobileConnectSdkProxy.
FOUNDATION_EXPORT const unsigned char MobileConnectSdkProxyVersionString[];

/// Proxies the `SdkFeature` OptionSet from swift
typedef NS_OPTIONS(NSInteger, MCSdkFeature) {
    SdkFeatureSalto = 1,
    SdkFeatureDigitalId = 1 << 1,
    SdkFeatureNotifications = 1 << 2,
};

