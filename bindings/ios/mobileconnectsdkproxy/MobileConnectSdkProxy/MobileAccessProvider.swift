//
//         Copyright Gallagher Group Ltd 2021 All Rights Reserved
//

import Foundation
import GallagherMobileAccess

@objc(Reader)
public class Reader : NSObject {
    @objc public let id: UUID
    
    @objc public let name: String
    
    @objc
    public init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    
    init(native: GallagherMobileAccess.Reader) {
        self.id = native.id
        self.name = native.name
    }
}

@objc(ReaderAttributes)
public class ReaderAttributes : Reader { // note: Classes implementing this should consider the properties as immutable.
    init(native: GallagherMobileAccess.ReaderAttributes) {
        self.measuredPathLoss = native.measuredPathLoss
        self.distance = ReaderDistance(native: native.distance)
        self.autoConnectPathLoss = native.autoConnectPathLoss
        self.manualConnectPathLoss = native.manualConnectPathLoss
        self.isBleManualConnectEnabled = native.isBleManualConnectEnabled
        self.isBleAutoConnectEnabled = native.isBleAutoConnectEnabled
        self.isSecondFactorRequired = native.isSecondFactorRequired
        self.isBleActionsEnabled = native.isBleActionsEnabled
        super.init(native: native)
    }
    
    @objc public let measuredPathLoss: Double
    @objc public let distance: ReaderDistance
    @objc public let autoConnectPathLoss: Double
    @objc public let manualConnectPathLoss: Double
    @objc public let isBleManualConnectEnabled: Bool
    @objc public let isBleAutoConnectEnabled: Bool
    @objc public let isSecondFactorRequired: Bool
    @objc public let isBleActionsEnabled: Bool
    
    @objc
    public init(id: UUID,
                name: String,
                measuredPathLoss: Double,
                distance: ReaderDistance,
                autoConnectPathLoss: Double,
                manualConnectPathLoss: Double,
                isBleManualConnectEnabled: Bool,
                isBleAutoConnectEnabled: Bool,
                isSecondFactorRequired: Bool,
                isBleActionsEnabled: Bool)
    {
        self.measuredPathLoss = measuredPathLoss
        self.distance = distance
        self.autoConnectPathLoss = autoConnectPathLoss
        self.manualConnectPathLoss = manualConnectPathLoss
        self.isBleManualConnectEnabled = isBleManualConnectEnabled
        self.isBleAutoConnectEnabled = isBleAutoConnectEnabled
        self.isSecondFactorRequired = isSecondFactorRequired
        self.isBleActionsEnabled = isBleActionsEnabled
        super.init(id: id, name: name)
    }
}

@objc(TitleAndBody)
public class TitleAndBody : NSObject {
    @objc public let title: String
    @objc public let body: String
    
    @objc
    public init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}

@objc(MobileAccessLocalization)
public class MobileAccessLocalization : NSObject {
    @objc public let notificationDetails: (_ reader: Reader) -> TitleAndBody
    @objc public let registrationDetails: (_ siteName: String) -> String
    @objc public let authenticationDetails: (_ readerName: String) -> String
    
    @objc
    public init(notificationDetails: ((_ reader: Reader) -> TitleAndBody)? = nil,
                registrationDetails: ((_ siteName: String) -> String)? = nil,
                authenticationDetails: ((_ readerName: String) -> String)? = nil)
    {
        self.notificationDetails = notificationDetails ?? { TitleAndBody(title: "", body: $0.name.isEmpty ? "Open App to authenticate" : "Open App for \($0.name)") }
        self.registrationDetails = registrationDetails ?? { siteName in siteName.isEmpty ? "Register credential" : "Register for \"\(siteName)\"" }
        self.authenticationDetails = authenticationDetails ?? { readerName in readerName.isEmpty ? "Authenticate" : "Authenticate for \"\(readerName)\"" }
    }
    
    func toNative() -> GallagherMobileAccess.MobileAccessLocalization {
        return GallagherMobileAccess.MobileAccessLocalization(
            notificationDetails: { r in
                let tb = self.notificationDetails(Reader(native: r))
                return (tb.title, tb.body)
            },
            registrationDetails: self.registrationDetails,
            authenticationDetails: self.authenticationDetails)
    }
}


fileprivate extension MCSdkFeature {
    func toNative() -> [GallagherMobileAccess.SdkFeature] {
        var r = [GallagherMobileAccess.SdkFeature]()
        if self.contains(.SdkFeatureDigitalId) {
            r.append(.digitalId)
        }
        if self.contains(.SdkFeatureSalto) {
            r.append(.salto)
        }
        if self.contains(.SdkFeatureNotifications) {
            r.append(.notifications)
        }
        return r
    }
}

@objc(MobileAccessProvider)
public class MobileAccessProvider : NSObject {
    
    @objc public static func configure(
        databaseFilePath: URL? = nil,
        localization: MobileAccessLocalization? = nil,
        cloudTlsValidationMode: CloudTlsValidationMode = .anyValidCertificateRequired,
        enabledFeatures: MCSdkFeature = []) -> MobileAccess
    {
        return MobileAccess(native: GallagherMobileAccess.MobileAccessProvider.configure(
            databaseFilePath: databaseFilePath,
            localization: localization?.toNative(),
            cloudTlsValidationMode: cloudTlsValidationMode.toNative(),
            enabledFeatures: enabledFeatures.toNative()))
    }
}

@objc(GallagherMobileAccessError)
public class GallagherMobileAccessError : NSObject {
    @objc public static let domain = "GallagherMobileAccess"
    
    // error codes
    @objc public static let registrationErrorNetworkFailure = 100
    @objc public static let registrationErrorInvalidResponse = 101
    @objc public static let registrationErrorUserCancelled = 102
    @objc public static let registrationErrorInvitationGone = 103
    @objc public static let registrationErrorInvitationNotFound = 104
    @objc public static let registrationErrorDevicePasscodeNotSet = 105
    @objc public static let registrationErrorDeviceNotSupported = 106
    @objc public static let registrationErrorUnexpected = 107
    
    @objc public static let readerConnectionErrorForbidden = 400
    @objc public static let readerConnectionErrorUnavailable = 401
    @objc public static let readerConnectionErrorTransactionInProgress = 402
    @objc public static let readerConnectionErrorBluetoothDisabled = 403
    @objc public static let readerConnectionErrorUserCancelled = 404
    @objc public static let readerConnectionErrorRemoteClose = 405
    @objc public static let readerConnectionErrorSecondFactorRequired = 406
    @objc public static let readerConnectionErrorOpenAppRequired = 407
    @objc public static let readerConnectionErrorInvalidatedCredential = 408
    @objc public static let readerConnectionErrorBiometricsLockedOut = 409
    @objc public static let readerConnectionErrorUnexpected = 410

}
