# Changelog

## 1.6.0

- Remove the app version and build restrictions.
- Attempt the Remote Config override for every `com.mcdonalds.mobileapp`
  version.
- Skip initialization safely when `FIRRemoteConfig` is unavailable.

## 1.5.0

- Rename the tweak to `McDonaldsGlobalFix` and use package identifier
  `com.paul159321.mcdonaldsglobalfix`.
- Target GMALite `3.39.1` build `25279` only.
- Override `forceUpdate_minIOSBuild` through `FIRRemoteConfig` value accessors.
- Remove Kotlin/Native function hooks and executable-page patching.
- Build universal `arm64` and `arm64e` slices for rootless packaging.
