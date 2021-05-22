using System;
using ObjCRuntime;

namespace MobileConnectSdk.iOS.Bindings
{
	[Flags]
	[Native]
	public enum MCSdkFeature : long
	{
		Salto = 0x1,
		DigitalId = 1L << 1,
		Notifications = 1L << 2
	}

	[Native]
	public enum AccessDecision : long
	{
		WithDualAuth = 5,
		WithEscort = 4,
		GrantedWithPassback = 3,
		GrantedWithCompetencies = 2,
		Granted = 1,
		DeniedZone = -1,
		DeniedZoneTime = -2,
		DeniedAuth = -3,
		DeniedLockdown = -4,
		DeniedLift = -5,
		DeniedCompetency = -6,
		DeniedCompetencies = -7,
		DeniedDualAuth = -8,
		DeniedSecondDualAuth = -9,
		DeniedNotEscort = -10,
		DeniedTailgatingVisitors = -11,
		DeniedPassback = -12,
		DeniedTailgating = -13,
		DeniedDualAuthRepeat = -14,
		DeniedChallenge = -15,
		DeniedMobileNotSupported = -16,
		DeniedCannotDisarmAlarmZone = -17,
		DeniedUnexpected = -64
	}

	[Native]
	public enum AccessMode : long
	{
		Access = 0,
		Challenge = 1,
		Evac = 2,
		Search = 3
	}

	[Native]
	public enum BackgroundScanningMode : long
	{
		Standard = 0,
		Extended = 1
	}

	[Native]
	public enum CloudTlsValidationMode : long
	{
		AnyValidCertificateRequired = 0,
		GallagherCertificateRequired = 1,
		AllowInvalidCertificate = 2
	}

	[Native]
	public enum DeleteOption : long
	{
		Default = 0,
		AllowOffline = 1,
		OfflineOnly = 2
	}

	[Native]
	public enum MobileAccessState : long
	{
		ErrorDeviceNotSupported = 0,
		ErrorNoPasscodeSet = 1,
		ErrorNoCredentials = 2,
		ErrorUnsupportedOsVersion = 3,
		ErrorNoBleFeature = 4,
		BleErrorLocationServiceDisabled = 5,
		BleErrorNoLocationPermission = 6,
		BleWarningExtendedBackgroundScanningRequiresLocationServiceEnabled = 7,
		BleWarningExtendedBackgroundScanningRequiresLocationAlwaysPermission = 8,
		BleErrorDisabled = 9,
		BleErrorUnauthorized = 10,
		NfcErrorDisabled = 11,
		NoNfcFeature = 12,
		CredentialRequiresBiometricsEnrolment = 13,
		CredentialBiometricsLockedOut = 14,
		BleErrorNoBackgroundLocationPermission = 15
	}

	[Native]
	public enum MobileCredentialFilter : long
	{
		ActiveOnly = 0,
		IncludeRevoked = 1
	}

	[Native]
	public enum ReaderDistance : long
	{
		Far = 0,
		Medium = 1,
		Near = 2
	}

	[Native]
	public enum ReaderUpdateType : long
	{
		AttributesChanged = 0,
		ReaderUnavailable = 1
	}

	[Native]
	public enum SecondFactorAuthenticationType : long
	{
		None = 0,
		FingerprintOrFaceId = 1,
		Pin = 2
	}
}
