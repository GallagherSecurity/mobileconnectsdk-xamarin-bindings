using System;
using System.Threading.Tasks;
using Foundation;

#nullable enable

namespace MobileConnectSdk.iOS.Bindings
{
    /// <summary>
    /// The SDK makes use of the iOS "delegate" pattern for callback-objects, which is not idiomatic in C#.
    /// This class adds some extension methods to make things fit in better with C# conventions
    /// </summary>
    public static class BindingExtensions
    {
        public static Exception MapNSError(NSError error)
        {
            return new Exception(error.LocalizedDescription); // TODO a proper error hierarchy
        }

        class AnonymousRegistrationDelegate : RegistrationDelegate
        {
            TaskCompletionSource<MobileCredential> _tcs;
            Action<Action<bool, SecondFactorAuthenticationType>> _onAuthenticationTypeSelectionRequested;

            public AnonymousRegistrationDelegate(TaskCompletionSource<MobileCredential> tcs, Action<Action<bool, SecondFactorAuthenticationType>> onAuthenticationTypeSelectionRequested)
            {
                _tcs = tcs;
                _onAuthenticationTypeSelectionRequested = onAuthenticationTypeSelectionRequested;
            }

            public override void OnAuthenticationTypeSelectionRequested(Action<bool, SecondFactorAuthenticationType> selector)
            {
                _onAuthenticationTypeSelectionRequested(selector);
            }

            public override void OnRegistrationCompletedWithCredential(MobileCredential? credential, NSError? error)
            {
                if (error != null)
                    _tcs.TrySetException(MapNSError(error));
                else if (credential != null)
                    _tcs.TrySetResult(credential);
                else
                    _tcs.TrySetException(new ArgumentException("Bug; OnRegistrationCompletedWithCredential must always be called with either error or credential set"));
            }
        }

        public static Task<MobileCredential> RegisterCredential(
            this MobileAccess mobileAccess,
            NSUrl url,
            Action<Action<bool, SecondFactorAuthenticationType>> onAuthenticationTypeSelectionRequested)
        {
            var tcs = new TaskCompletionSource<MobileCredential>();
            mobileAccess.RegisterCredentialWithUrl(url, new AnonymousRegistrationDelegate(tcs, onAuthenticationTypeSelectionRequested));
            return tcs.Task;
        }
    }
}
