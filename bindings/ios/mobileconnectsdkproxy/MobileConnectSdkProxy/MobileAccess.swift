//
//         Copyright Gallagher Group Ltd 2021 All Rights Reserved
//

import Foundation
import GallagherMobileAccess

@objc(MobileCredential)
public class MobileCredential : NSObject {
    @objc public var id: String { native.id }
    
    @objc public var facilityId: Int { native.facilityId }
    
    @objc public var facilityName: String { native.facilityName }
    
    // TODO @objc public var sharedCredentials: [SharedCredential] { get }
    
    @objc public var registeredDate: Date { native.registeredDate }
    
    @objc public var isSingleFactor: Bool { native.isSingleFactor }
    
    // TODO @objc public var secondFactorType: SecondFactorVerificationType? { get }
    
    @objc public var sessionUrl: URL { native.sessionUrl }
    
    // TODO var status: MobileCredentialStatus { get }
        
    @objc public var isRevoked: Bool { native.isRevoked }
    
    // internal
    let native: GallagherMobileAccess.MobileCredential
    
    init(native: GallagherMobileAccess.MobileCredential) {
        self.native = native
    }
}

public extension GallagherMobileAccess.ReaderConnectionError {
    func toNSError() -> NSError {
        let code: Int
        let userInfo: [String: Any]?
        switch self {
        case .forbidden:
            code = GallagherMobileAccessError.readerConnectionErrorForbidden
            userInfo = [NSLocalizedDescriptionKey: "Action Not Allowed"]
        case .readerUnavailable:
            code = GallagherMobileAccessError.readerConnectionErrorUnavailable
            userInfo = [NSLocalizedDescriptionKey: "Reader Not Available"]
        case .transactionInProgress:
            code = GallagherMobileAccessError.readerConnectionErrorTransactionInProgress
            userInfo = [NSLocalizedDescriptionKey: "Transaction In Progress"]
        case .bluetoothDisabled:
            code = GallagherMobileAccessError.readerConnectionErrorBluetoothDisabled
            userInfo = [NSLocalizedDescriptionKey: "Bluetooth Disabled"]
        case .userCancelled:
            code = GallagherMobileAccessError.readerConnectionErrorUserCancelled
            userInfo = [NSLocalizedDescriptionKey: "User Cancelled"]
        case .remoteClose:
            code = GallagherMobileAccessError.readerConnectionErrorRemoteClose
            userInfo = [NSLocalizedDescriptionKey: "Remote Close"]
        case .secondFactorRequired:
            code = GallagherMobileAccessError.readerConnectionErrorSecondFactorRequired
            userInfo = [NSLocalizedDescriptionKey: "Second Factor Required"]
        case .openAppRequired:
            code = GallagherMobileAccessError.readerConnectionErrorOpenAppRequired
            userInfo = [NSLocalizedDescriptionKey: "Open App Required"]
        case .invalidatedCredential:
            code = GallagherMobileAccessError.readerConnectionErrorInvalidatedCredential
            userInfo = [NSLocalizedDescriptionKey: "Credential Invalidated"]
        case .biometricsLockedOut:
            code = GallagherMobileAccessError.readerConnectionErrorBiometricsLockedOut
            userInfo = [NSLocalizedDescriptionKey: "Biometrics Locked Out"]
        case .unexpected(let s):
            code = GallagherMobileAccessError.readerConnectionErrorUnexpected
            userInfo = [NSLocalizedDescriptionKey: "Unexpected Error: \(s)"]
        @unknown default:
            code = GallagherMobileAccessError.readerConnectionErrorUnexpected
            userInfo = [NSLocalizedDescriptionKey: "Unexpected Error"]
        }
        return NSError(domain: GallagherMobileAccessError.domain, code: code, userInfo: userInfo)
    }
}

public extension GallagherMobileAccess.RegistrationError {
    func toNSError() -> NSError {
        let code: Int
        let userInfo: [String: Any]?
        switch self {
        case .networkFailure(let e):
            code = GallagherMobileAccessError.registrationErrorNetworkFailure
            userInfo = [NSLocalizedDescriptionKey: "Network Failure", NSUnderlyingErrorKey: e]
        case .invalidResponse(let s):
            code = GallagherMobileAccessError.registrationErrorInvalidResponse
            userInfo = [NSLocalizedDescriptionKey: "Invalid Response: \(s)"]
        case .userCancelledRegistration:
            code = GallagherMobileAccessError.registrationErrorUserCancelled
            userInfo = [NSLocalizedDescriptionKey: "User Cancelled Registration"]
        case .invitationGone:
            code = GallagherMobileAccessError.registrationErrorInvitationGone
            userInfo = [NSLocalizedDescriptionKey: "Invitation Gone"]
        case .invitationNotFound:
            code = GallagherMobileAccessError.registrationErrorInvitationNotFound
            userInfo = [NSLocalizedDescriptionKey: "Invitation Not Found"]
        case .devicePasscodeNotSet:
            code = GallagherMobileAccessError.registrationErrorDevicePasscodeNotSet
            userInfo = [NSLocalizedDescriptionKey: "Device Passcode Not Set"]
        case .deviceNotSupported:
            code = GallagherMobileAccessError.registrationErrorDeviceNotSupported
            userInfo = [NSLocalizedDescriptionKey: "Device Not Supported"]
        case .unexpected(let s):
            code = GallagherMobileAccessError.registrationErrorUnexpected
            userInfo = [NSLocalizedDescriptionKey: "Unexpected Error: \(s)"]
        @unknown default:
            code = GallagherMobileAccessError.registrationErrorUnexpected
            userInfo = [NSLocalizedDescriptionKey: "Unexpected Error"]
        }
        return NSError(domain: GallagherMobileAccessError.domain, code: code, userInfo: userInfo)
    }
}

@objc(RegistrationDelegate)
public protocol RegistrationDelegate {
    @objc func onRegistrationCompleted(credential: MobileCredential?, error: NSError?)
       
    @objc(onAuthenticationTypeSelectionRequested:)
    func onAuthenticationTypeSelectionRequested(selector: @escaping (_ succeeded: Bool, _ authenticationType: SecondFactorAuthenticationType) -> ())
}

@objc(SdkStateDelegate)
public protocol SdkStateDelegate {
    @objc // NOTE: states is an array of MobileAccessState enum values, wrapped in NSNumbers
    func onStateChange(isScanning: Bool, states: NSArray)
}

@objc(ReaderUpdateDelegate)
public protocol ReaderUpdateDelegate {
    @objc(onReaderUpdated:updateType:)
    func onReaderUpdated(reader: ReaderAttributes, updateType: ReaderUpdateType)
}

@objc(AccessResult)
public class AccessResult : NSObject {
    @objc public let accessDecision: AccessDecision
    @objc public let accessMode: AccessMode
    
    @objc public func isAccessGranted() -> Bool {
        return accessDecision.rawValue > 0
    }
    
    init(native: GallagherMobileAccess.AccessResult) {
        self.accessDecision = AccessDecision(native: native.accessDecision) ?? .deniedUnexpected
        self.accessMode = AccessMode(native: native.accessMode)
    }
}

@objc(AccessDelegate)
public protocol AccessDelegate {
    @objc
    func onAccessStarted(reader:Reader)
    
    @objc
    func onAccessCompleted(reader:Reader, result:AccessResult?, error:NSError?)
}

@objc(MobileAccess)
public class MobileAccess : NSObject {
    private let native: GallagherMobileAccess.MobileAccess
    
    init(native: GallagherMobileAccess.MobileAccess) {
        self.native = native
    }
        
    @objc
    public func registerCredential(url: URL, delegate: RegistrationDelegate) {
        class RegistrationDelegateAdapter : GallagherMobileAccess.RegistrationDelegate {
            let proxied: RegistrationDelegate
            fileprivate init(proxied: RegistrationDelegate) {
                self.proxied = proxied
            }
            
            func onRegistrationCompleted(credential: GallagherMobileAccess.MobileCredential?, error: GallagherMobileAccess.RegistrationError?) {
                let proxyCredential: MobileCredential?
                if let c = credential { proxyCredential = MobileCredential(native: c) } else { proxyCredential = nil }
                proxied.onRegistrationCompleted(credential: proxyCredential, error: error?.toNSError())
            }
            
            func onAuthenticationTypeSelectionRequested(selector: @escaping GallagherMobileAccess.SecondFactorAuthenticationTypeSelector) {
                proxied.onAuthenticationTypeSelectionRequested { succeeded, authType in
                    selector(succeeded, authType.toNative())
                }
            }
        }
        
        // ---------------------
        native.registerCredential(url: url, delegate: RegistrationDelegateAdapter(proxied: delegate))
    }
    
    @objc
    public var mobileCredentials: [MobileCredential] {
        native.mobileCredentials.map { MobileCredential(native: $0) }
    }
    
    @objc(getMobileCredentials:)
    public func getMobileCredentials(options: MobileCredentialFilter) -> [MobileCredential] {
        native.getMobileCredentials(options: options.toNative()).map { MobileCredential(native: $0) }
    }
    
    @objc(getMobileCredentialWithId:)
    public func getMobileCredential(credentialId: String) -> MobileCredential? {
        if let c = native.getMobileCredential(credentialId: credentialId) {
            return MobileCredential(native: c)
        } else {
            return nil
        }
    }
    
    @objc
    public func deleteMobileCredential(_ mobileCredential: MobileCredential, deleteOption: DeleteOption, onCredentialDeleteCompleted: @escaping (_ credential: MobileCredential, _ error: Error?) -> ()) {
        
        native.deleteMobileCredential(mobileCredential.native, deleteOption: deleteOption.toNative()) { cred, err in
            onCredentialDeleteCompleted(MobileCredential(native: cred), err)
        }
    }
    
    @objc(setScanning:)
    public func setScanning(enabled: Bool) {
        native.setScanning(enabled: enabled)
    }
    
    @objc
    public func resolveInvitationUrl(_ rawUrl: String, invitation: String) -> URL? {
        return native.resolveInvitationUrl(rawUrl, invitation: invitation)
    }
        
    // enables comparison by pointer
    struct Ref : Hashable, Equatable {
        static func == (lhs: MobileAccess.Ref, rhs: MobileAccess.Ref) -> Bool {
            lhs.value === rhs.value
        }
        func hash(into hasher: inout Hasher) {
            hasher.combine(ObjectIdentifier(value))
        }
        let value: AnyObject // must be class, not a struct
    }
    
    class SdkStateDelegateAdapter : GallagherMobileAccess.SdkStateDelegate {
        let proxied: SdkStateDelegate
        init(proxied: SdkStateDelegate) {
            self.proxied = proxied
        }
        
        func onStateChange(isScanning: Bool, states: [GallagherMobileAccess.MobileAccessState]) {
            proxied.onStateChange(isScanning: isScanning, states: NSArray(mobileAccessStates: states))
        }
    }
    
    var proxiedSdkStateDelegates: [Ref:SdkStateDelegateAdapter] = [:]
    
    @objc
    public func addSdkStateDelegate(_ delegate: SdkStateDelegate) {
        let adapter = SdkStateDelegateAdapter(proxied: delegate)
        proxiedSdkStateDelegates[Ref(value: adapter)] = adapter
        native.addSdkStateDelegate(adapter)
    }
    
    @objc
    public func removeSdkStateDelegate(_ delegate: SdkStateDelegate) {
        if let adapter = proxiedSdkStateDelegates[Ref(value: delegate)] {
            native.removeSdkStateDelegate(adapter)
        } else {
            print("warning: removing sdk state delegate that wasn't added?")
        }
    }
    
    var proxiedReaderUpdateDelegates: [Ref:ReaderUpdateDelegateAdapter] = [:]
    
    class ReaderUpdateDelegateAdapter : GallagherMobileAccess.ReaderUpdateDelegate {
        let proxied: ReaderUpdateDelegate
        init(proxied: ReaderUpdateDelegate) {
            self.proxied = proxied
        }
        
        func onReaderUpdated(_ reader: GallagherMobileAccess.ReaderAttributes, updateType: GallagherMobileAccess.ReaderUpdateType) {
            proxied.onReaderUpdated(reader: ReaderAttributes(native: reader), updateType: ReaderUpdateType(native: updateType))
        }
    }
    
    @objc
    public func addReaderUpdateDelegate(_ delegate: ReaderUpdateDelegate) {
        let adapter = ReaderUpdateDelegateAdapter(proxied: delegate)
        proxiedReaderUpdateDelegates[Ref(value: adapter)] = adapter
        native.addReaderUpdateDelegate(adapter)
    }
    
    @objc
    public func removeReaderUpdateDelegate(_ delegate: ReaderUpdateDelegate) {
        if let adapter = proxiedReaderUpdateDelegates[Ref(value: delegate)] {
            native.removeReaderUpdateDelegate(adapter)
        } else {
            print("warning: removing reader update delegate that wasn't added?")
        }
    }
    
    var proxiedAccessDelegates: [Ref:AccessDelegateAdapter] = [:]
    
    class AccessDelegateAdapter : GallagherMobileAccess.AccessDelegate {
        let proxied: AccessDelegate
        init(proxied: AccessDelegate) {
            self.proxied = proxied
        }
        
        func onAccessStarted(reader: GallagherMobileAccess.Reader) {
            proxied.onAccessStarted(reader: Reader(native: reader))
        }
        
        func onAccessCompleted(reader: GallagherMobileAccess.Reader, result: GallagherMobileAccess.AccessResult?, error: GallagherMobileAccess.ReaderConnectionError?) {
            
            let accessResult: AccessResult?
            if let ar = result { accessResult = AccessResult(native: ar) } else { accessResult = nil }
            
            let nsErr: NSError?
            if let er = error { nsErr = er.toNSError() } else { nsErr = nil }
            
            proxied.onAccessCompleted(reader: Reader(native: reader), result: accessResult, error: nsErr)
        }
    }
    
    @objc
    public func addAutomaticAccessDelegate(_ delegate: AccessDelegate) {
        let adapter = AccessDelegateAdapter(proxied: delegate)
        proxiedAccessDelegates[Ref(value: adapter)] = adapter
        native.addAutomaticAccessDelegate(adapter)
    }
    
    @objc
    public func removeAutomaticAccessDelegate(_ delegate: AccessDelegate) {
        if let adapter = proxiedAccessDelegates[Ref(value: delegate)] {
            native.removeAutomaticAccessDelegate(adapter)
        } else {
            print("warning: removing reader update delegate that wasn't added?")
        }
    }

    @objc
    public var isAutomaticAccessEnabled: Bool {
        get { return native.isAutomaticAccessEnabled }
        set(value) { native.isAutomaticAccessEnabled = value }
    }

    @objc
    public var backgroundScanningMode: BackgroundScanningMode {
        get { BackgroundScanningMode(native: native.backgroundScanningMode) }
        set(value) { native.backgroundScanningMode = value.toNative() }
    }


    // Values are NSNumbers which contain a MobileAccessState value
    @objc
    public var states: NSArray {
        NSArray(mobileAccessStates: native.states)
    }

//    /// :nodoc:
//    var bluetoothAdvertisementDelegate: BluetoothAdvertisementDelegate? { get set }
//
//    /// :nodoc:
//    var networkServiceFactory: NetworkServiceFactory { get }
//
//    /// Synchronously gets the feature states of the SDK
//    /// - Returns: The feature states of the SDK as a collection
//    var sdkFeatureStates: [SdkFeatureState] { get }
//
//    /// Listens to the feature states of the SDK. Warnings and errors will be announced via the handler provided
//    func addSdkFeatureStateDelegate(_ delegate: SdkFeatureStateDelegate)
//
//    /// Removes a feature state delegate by reference.
//    /// - Parameter delegate: An instance of a feature state delegate to remove. The functions on this object will not be called back on anymore.
//    func removeSdkFeatureStateDelegate(_ delegate: SdkFeatureStateDelegate)
//
//    /// Triggers an async request to the cloud for related item updates for registered mobile credentials
//    /// Resulting updates for Notifications, Salto Keys, Digital IDs will be published in the background through associated delegates
//    func syncCredentialItemUpdates()
//
//    /// Triggers an async request to the cloud for related item updates for registered mobile credentials, calling `onSyncCompleted` after the sync process finishes.
//    /// Resulting updates for Notifications, Salto Keys, Digital IDs will be published in the background through associated delegates
//    func syncCredentialItemUpdates(onSyncCompleted: @escaping (Result<Void, Error>) -> ())
//
//    /// Add a delegate for handling Digital IDs available to registered Mobile Credentials
//    /// Can be invoked from any thread
//    ///
//    /// - Parameter delegate: The delegate that will start having its relevant methods called with Digital ID updates
//    func addDigitalIdDelegate(_ delegate: DigitalIdDelegate)
//
//    /// Removes a Digital ID delegate by reference
//    /// Can be invoked from any thread
//    ///
//    /// - Parameter delegate: An instance of a Digital ID delegate to remove. The functions on this object will not be called back on anymore
//    func removeDigitalIdDelegate(_ delegate: DigitalIdDelegate)
//
//    /// Add a delegate for handling Salto Keys available to registered MobileCredentials
//    /// Can be invoked from any thread
//    ///
//    /// - Parameter delegate: The delegate that will start having its relevant methods called with Salto Key updates
//    func addSaltoUpdateDelegate(_ delegate: SaltoUpdateDelegate)
//
//    /// Add a delegate for handling Salto Keys available to registered MobileCredentials
//    /// Can be invoked from any thread
//    ///
//    /// - Parameter delegate: The Salto delegate to be removed
//    func removeSaltoUpdateDelegate(_ delegate: SaltoUpdateDelegate)
//
//    /// :nodoc:
//    func addNotificationsDelegate(_ delegate: NotificationsDelegate)
//
//    /// :nodoc:
//    func removeNotificationsDelegate(_ delegate: NotificationsDelegate)
//
//    /// :nodoc:
//    func sendNotificationToken(apnsToken: Data, forCredentials: [MobileCredential]?, onSendCompleted: @escaping (Result<[MobileCredential], Error>) -> ())
//
//    /// :nodoc:
//    func startAcceptingNotifications()
//
//    /// :nodoc:
//    func markNotificationAsRead(notification: BroadcastNotification)
//
//    /// :nodoc:
//    func deleteNotification(notification: BroadcastNotification)
//
//    /// Start opening a Salto Door with a given Salto Key Identifier
//    /// - Parameter saltoKeyIdentifier: The Salto Key Identifier the user wants access with
//    /// - Parameter delegate: The delegate that will have its methods called with peripheral found, access complete or an error received
//    func startOpeningSaltoDoor(saltoKeyIdentifier: SaltoKeyIdentifier, delegate: SaltoAccessDelegate)
//
//    /// :nodoc:
//    func addE2eDelegate(_ delegate: E2eEncryptionDelegate)
//
//    /// :nodoc:
//    func removeE2eDelegate(_ delegate: E2eEncryptionDelegate)
//
//    /// nodoc
//    func getE2eSiteAndDeviceKeysForDisplay(mobileCredential: MobileCredential) -> E2ePublicKeys?
}

extension NSArray {
    convenience init(mobileAccessStates: [GallagherMobileAccess.MobileAccessState]) {
        let r = NSMutableArray(capacity: mobileAccessStates.count)
        for s in mobileAccessStates {
            r.add(NSNumber(value: MobileAccessState(native: s).rawValue))
        }
        self.init(array: r)
    }
}
