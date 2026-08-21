# McDonaldsGlobalFix

A narrowly scoped Theos tweak for GMALite `3.39.1` (`25279`). It overrides
the Firebase Remote Config value used as the minimum supported iOS app build.

## Scope

- Bundle ID: `com.mcdonalds.mobileapp`
- App version: `3.39.1`
- Build: `25279`
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
dpkg -i packages/com.paul159321.mcdonaldsglobalfix_1.5.0_iphoneos-arm64.deb
killall GMALite
```

If using an app-scoped injector, inject only the newly built dylib. Do not
combine it with a system-installed copy of the tweak, and remove any older
embedded McDonaldsGlobalFix dylib first.

## Notes

- Only the exact app version/build listed above is enabled.
- No decrypted app, proprietary framework, signing material, or compiled
  binary is included in this repository.
- A future app release may rename the Remote Config key or change its access
  path and will require a separate analysis.

## Disclaimer

This project is provided for interoperability research. It is not affiliated
with or endorsed by McDonald's, Firebase, or their respective owners. Use it
only on devices and software you are authorized to modify.

## License

[MIT](LICENSE)
