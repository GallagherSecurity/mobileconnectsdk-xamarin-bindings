//
//         Copyright Gallagher Group Ltd 2021 All Rights Reserved
//

import Foundation
import GallagherMobileAccess


@objc(CloudTlsValidationMode)
public enum CloudTlsValidationMode : Int {
    case anyValidCertificateRequired
    case gallagherCertificateRequired
    case allowInvalidCertificate
    
    func toNative() -> GallagherMobileAccess.CloudTlsValidationMode {
        switch self {
        case .anyValidCertificateRequired: return .anyValidCertificateRequired
        case .gallagherCertificateRequired: return .gallagherCertificateRequired
        case .allowInvalidCertificate: return .allowInvalidCertificate
        }
    }
}


@objc(SecondFactorAuthenticationType)
public enum SecondFactorAuthenticationType : Int {
    case none = 0
    case fingerprintOrFaceId = 1
    case pin = 2
    
    func toNative() -> GallagherMobileAccess.SecondFactorAuthenticationType? {
        switch self {
        case .fingerprintOrFaceId: return .fingerprintOrFaceId
        case .pin: return .pin
        case .none: return nil
        }
    }
}

@objc(MobileCredentialFilter)
public enum MobileCredentialFilter : Int {
    case activeOnly
    case includeRevoked
    
    func toNative() -> GallagherMobileAccess.MobileCredentialFilter {
        switch self {
        case .activeOnly: return .activeOnly
        case .includeRevoked: return .includeRevoked
        }
    }
}

@objc(DeleteOption)
public enum DeleteOption : Int {
    case `default`
    case allowOffline
    case offlineOnly
    
    func toNative() -> GallagherMobileAccess.DeleteOption {
        switch self {
        case .default: return .default
        case .allowOffline: return .allowOffline
        case .offlineOnly: return .offlineOnly
        }
    }
}

@objc(BackgroundScanningMode)
public enum BackgroundScanningMode : Int {
    case standard
    case extended
    
    init(native: GallagherMobileAccess.BackgroundScanningMode) {
        switch native {
        case .standard: self = .standard
        case .extended: self = .extended
        @unknown default: fatalError("Unhandled BackgroundScanningMode")
        }
    }
    
    func toNative() -> GallagherMobileAccess.BackgroundScanningMode {
        switch self {
        case .standard: return .standard
        case .extended: return .extended
        }
    }
}

@objc(MobileAccessState)
public enum MobileAccessState : Int {
    case errorDeviceNotSupported
    case errorNoPasscodeSet
    case errorNoCredentials
    case errorUnsupportedOsVersion
    case errorNoBleFeature
    case bleErrorLocationServiceDisabled
    case bleErrorNoLocationPermission
    case bleWarningExtendedBackgroundScanningRequiresLocationServiceEnabled
    case bleWarningExtendedBackgroundScanningRequiresLocationAlwaysPermission
    case bleErrorDisabled
    case bleErrorUnauthorized
    case nfcErrorDisabled
    case noNfcFeature
    case credentialRequiresBiometricsEnrolment
    case credentialBiometricsLockedOut
    case bleErrorNoBackgroundLocationPermission
    
    init(native: GallagherMobileAccess.MobileAccessState) {
        switch native {
        case .errorDeviceNotSupported: self = .errorDeviceNotSupported
        case .errorNoPasscodeSet: self = .errorNoPasscodeSet
        case .errorNoCredentials: self = .errorNoCredentials
        case .errorUnsupportedOsVersion: self = .errorUnsupportedOsVersion
        case .errorNoBleFeature: self = .errorNoBleFeature
        case .bleErrorLocationServiceDisabled: self = .bleErrorLocationServiceDisabled
        case .bleErrorNoLocationPermission: self = .bleErrorNoLocationPermission
        case .bleWarningExtendedBackgroundScanningRequiresLocationServiceEnabled: self = .bleWarningExtendedBackgroundScanningRequiresLocationServiceEnabled
        case .bleWarningExtendedBackgroundScanningRequiresLocationAlwaysPermission: self = .bleWarningExtendedBackgroundScanningRequiresLocationAlwaysPermission
        case .bleErrorDisabled: self = .bleErrorDisabled
        case .bleErrorUnauthorized: self = .bleErrorUnauthorized
        case .nfcErrorDisabled: self = .nfcErrorDisabled
        case .noNfcFeature: self = .noNfcFeature
        case .credentialRequiresBiometricsEnrolment: self = .credentialRequiresBiometricsEnrolment
        case .credentialBiometricsLockedOut: self = .credentialBiometricsLockedOut
        case .bleErrorNoBackgroundLocationPermission: self = .bleErrorNoBackgroundLocationPermission
        @unknown default: fatalError("Unknown MobileAccessState")
        }
    }
    
    func toNative() -> GallagherMobileAccess.MobileAccessState {
        switch self {
        case .errorDeviceNotSupported: return .errorDeviceNotSupported
        case .errorNoPasscodeSet: return .errorNoPasscodeSet
        case .errorNoCredentials: return .errorNoCredentials
        case .errorUnsupportedOsVersion: return .errorUnsupportedOsVersion
        case .errorNoBleFeature: return .errorNoBleFeature
        case .bleErrorLocationServiceDisabled: return .bleErrorLocationServiceDisabled
        case .bleErrorNoLocationPermission: return .bleErrorNoLocationPermission
        case .bleWarningExtendedBackgroundScanningRequiresLocationServiceEnabled: return .bleWarningExtendedBackgroundScanningRequiresLocationServiceEnabled
        case .bleWarningExtendedBackgroundScanningRequiresLocationAlwaysPermission: return .bleWarningExtendedBackgroundScanningRequiresLocationAlwaysPermission
        case .bleErrorDisabled: return .bleErrorDisabled
        case .bleErrorUnauthorized: return .bleErrorUnauthorized
        case .nfcErrorDisabled: return .nfcErrorDisabled
        case .noNfcFeature: return .noNfcFeature
        case .credentialRequiresBiometricsEnrolment: return .credentialRequiresBiometricsEnrolment
        case .credentialBiometricsLockedOut: return .credentialBiometricsLockedOut
        case .bleErrorNoBackgroundLocationPermission: return .bleErrorNoBackgroundLocationPermission
        }
    }
}


@objc(ReaderDistance)
public enum ReaderDistance : Int {
    case far
    case medium
    case near
    
    init(native: GallagherMobileAccess.ReaderDistance) {
        switch native {
        case .far: self = .far
        case .medium: self = .medium
        case .near: self = .near
        @unknown default: fatalError("Unknown ReaderDistance")
        }
    }
}

@objc(ReaderUpdateType)
public enum ReaderUpdateType : Int {
    init(native: GallagherMobileAccess.ReaderUpdateType) {
        switch native {
        case .attributesChanged: self = .attributesChanged
        case .readerUnavailable: self = .readerUnavailable
        @unknown default: fatalError("Unknown ReaderUpdateType")
        }
    }
    
    case attributesChanged
    case readerUnavailable
}

@objc(AccessDecision)
public enum AccessDecision : Int, CustomStringConvertible {
    init?(native: GallagherMobileAccess.AccessDecision) {
        self.init(rawValue: Int(native.rawValue)) // rawValues are the same, so we can shortcut
    }
    
    case withDualAuth = 5
    case withEscort = 4
    case grantedWithPassback = 3
    case grantedWithCompetencies = 2
    case granted = 1
    case deniedZone = -1
    case deniedZoneTime = -2
    case deniedAuth = -3
    case deniedLockdown = -4
    case deniedLift = -5
    case deniedCompetency = -6
    case deniedCompetencies = -7
    case deniedDualAuth = -8
    case deniedSecondDualAuth = -9
    case deniedNotEscort = -10
    case deniedTailgatingVisitors = -11
    case deniedPassback = -12
    case deniedTailgating = -13
    case deniedDualAuthRepeat = -14
    case deniedChallenge = -15
    case deniedMobileNotSupported = -16
    case deniedCannotDisarmAlarmZone = -17
    case deniedUnexpected = -64
    
    public var description: String {
        switch self {
        case .withDualAuth:
            return "Second authentication required for access"
        case .withEscort:
            return "Escort or further visitors required for access"
        case .grantedWithPassback:
            return "Granted: Shouldn't have passed back"
        case .grantedWithCompetencies:
            return "Granted: Competency warning"
        case .granted:
            return "Granted"
        case .deniedZone:
            return "Denied: User does not have access to this zone"
        case .deniedZoneTime:
            return "Denied: User does not have access to this zone at this time"
        case .deniedAuth:
            return "Denied: Cardholder not recognised"
        case .deniedLockdown:
            return "Denied: User does not have access during lockdown"
        case .deniedLift:
            return "Denied: User does not have access to lift floor"
        case .deniedCompetency:
            return "Denied: User is missing at least one competency"
        case .deniedCompetencies:
            return "Denied: User is missing all competencies"
        case .deniedDualAuth:
            return "Denied: User is not part of the dual auth access group"
        case .deniedSecondDualAuth:
            return "Denied: Second dual auth user is not part of the access group"
        case .deniedNotEscort:
            return "Denied: User does not have the right to escort the visitor that attempted access"
        case .deniedTailgatingVisitors:
            return "Denied: Multiple visitors are not supported with anti-tailgating enabled"
        case .deniedPassback:
            return "Denied: Passback not allowed"
        case .deniedTailgating:
            return "Denied: User shouldn't have tailgated"
        case .deniedDualAuthRepeat:
            return "Denied: Dual auth failed because the same mobile was used"
        case .deniedChallenge:
            return "Denied: Challenge operator denied access"
        case .deniedMobileNotSupported:
            return "Denied: Mobile not supported"
        case .deniedCannotDisarmAlarmZone:
            return "Denied: User cannot disarm alarm zone"
        case .deniedUnexpected:
            return "Denied: Unexpected"
        }
    }
}

@objc(AccessMode)
public enum AccessMode : Int, CustomStringConvertible {
    init(native: GallagherMobileAccess.AccessMode) {
        switch native {
        case .access: self = .access
        case .challenge: self = .challenge
        case .evac: self = .evac
        case .search: self = .search
        @unknown default: fatalError("Unknown AccessMode")
        }
    }
    
    case access = 0
    case challenge = 1
    case evac = 2
    case search = 3
    
    /// Returns a text description of the AccessMode
    public var description: String {
        switch self {
        case .access:
            return "Access"
        case .challenge:
            return "AccessWithChallenge"
        case .search:
            return "CardholderLookup"
        case .evac:
            return "MobileEvacuation"
        }
    }
}
