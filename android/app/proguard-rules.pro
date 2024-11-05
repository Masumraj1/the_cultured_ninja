    -dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
    -dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
    -dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
    -dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
    -dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider
    # OkHttp3 জন্য প্রয়োজনীয় ক্লাস রক্ষা করুন
    -keep class okhttp3.** { *; }
    -dontwarn okhttp3.**

    # Conscrypt এর জন্য প্রয়োজনীয় নিয়ম
    -dontwarn org.conscrypt.**
