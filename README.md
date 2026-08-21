# McDonaldsGlobalFix

A narrowly scoped Theos tweak for GMALite. It overrides the Firebase Remote
Config value used as the minimum supported iOS app build.

## Scope

- Bundle ID: `com.mcdonalds.mobileapp`
- App version/build: unrestricted
- Remote Config key: `forceUpdate_minIOSBuild`
- Architectures: `arm64`, `arm64e`
- Default package scheme: rootless

The tweak hooks only three `FIRRemoteConfig` value accessors. For the key above
it supplies a value of `0`; all other Remote Config keys use their original
implementations. It does not spoof `UIDevice.systemVersion`, modify requests,
or patch executable pages.

## Build

Install [Theos](https://theos.dev/docs/installation), then run:

```sh
export THEOS=/path/to/theos
make clean package
```

The generated package is placed in `packages/`. The default configuration
builds a rootless package with both `arm64` and `arm64e` slices.

## Installation

Install the package on a compatible rootless jailbreak:

```sh
dpkg -i packages/com.paul159321.mcdonaldsglobalfix_1.6.0_iphoneos-arm64.deb
```

Completely close GMALite before installation, then reopen it so the tweak is
loaded into the new app process.

If using an app-scoped injector, inject only the newly built dylib. Do not
combine it with a system-installed copy of the tweak, and remove any older
embedded McDonaldsGlobalFix dylib first.

## Notes

- Every `com.mcdonalds.mobileapp` version is allowed to load the tweak.
- If `FIRRemoteConfig` is unavailable, the tweak does nothing.
- Versions that no longer use `forceUpdate_minIOSBuild` are left unchanged.
- No decrypted app, proprietary framework, signing material, or compiled
  binary is included in this repository.

## Disclaimer

This project is provided for interoperability research. It is not affiliated
with or endorsed by McDonald's, Firebase, or their respective owners. Use it
only on devices and software you are authorized to modify.

## License

[MIT](LICENSE)
