# Papaya Farm Classic — iPhone client for Synology NAS

This project is an **unofficial fan recreation** of early Papaya Farm for iOS, built to share farms with **Papaya Farm Classic NAS Always-On v0.4** and Windows clients. It is original implementation/art, not a recovered PapayaMobile application.

**Status:** complete source for a native iOS 15+ wrapper with a touch-driven canvas game and native UDP NAS client. The iOS app has **not yet been compiled with Xcode or tested on an iPhone** in this environment. An `.ipa` can be generated with the provided macOS GitHub Actions workflow; it is unsigned and needs to be signed by a sideloading tool.

## Compatibility

- iPhone 15 Pro Max and iOS 26.4.1 are targeted; minimum deployment is iOS 15.0.
- Uses the same UDP protocol v3 as the NAS kit on port **37942**.
- Same farm name and PIN as Windows; same server-held crops, inventory, cash, XP, RP, and ranch state.
- Supports farming, harvesting, weeds, pests, seed store, selling, ranch tending, friends directory and farm visits.
- Classic-looking farm/ranch art and sprites, based on the Windows reconstruction.
- Landscape-only interface. Network required; there is **no offline mode** for this client.

## Build with GitHub Actions (macOS runner)

1. Create a new GitHub repository (can be private) and upload all contents of this folder **including the `.github` folder**.
2. Open **Actions → Build iPhone IPA → Run workflow**.
3. Download the artifact `PapayaFarmClassic_iOS_unsigned` after a successful build.
4. Extract it to find `PapayaFarmClassic_iOS_unsigned.ipa`.
5. Use Sideloadly or AltStore to **sign** and install the unsigned IPA on your iPhone.

The IPA filename indicates it is unsigned. A sideloading tool cannot use the source ZIP directly.

## Build with Xcode on a Mac

Requires Xcode (with iOS SDK), XcodeGen (`brew install xcodegen`) and command line tools.

```bash
./build_on_mac.sh
```

Unsigned IPA output: `dist/PapayaFarmClassic_iOS_unsigned.ipa`.

## Connect your phone

1. Have Papaya Farm NAS v0.4 server running on your Synology NAS (UDP 37942).
2. Put your phone on the same Wi-Fi network, or connect the phone and NAS over Tailscale for remote play.
3. Launch Papaya Farm, enter the NAS IP, your existing farm name, and PIN.
4. Allow local network access when iOS prompts for it.
5. Visit friends with **Friends** from the top toolbar. Progress is always stored on your NAS.

For remote play, both iPhone and NAS should be on a compatible private VPN network. Do **not** publicly forward the server UDP port: the existing game protocol sends the login PIN without app-level encryption.

## Important technical details

- Wire packet: little-endian 1080 bytes; magic `0x33464E50`, version 3.
- Uses Apple's Network framework to communicate with Synology and WebKit for the touch/game UI.
- PNG sprites/resources are locally bundled and no external downloads are needed during play.
- App ID: `org.papaya.classic.ios`, version 0.5.0.
- The server is the source of truth; disconnecting the phone does not stop crop growth.
- The remake is not endorsed by or affiliated with PapayaMobile.

## Not yet verified

The iOS source and JS pass available local syntax checks, but this Linux workspace lacks Xcode, Apple iOS SDK, and an iOS-capable linker. Device behavior, native compilation, and sideload installation need a macOS build and real-device validation. If a GitHub Actions build reports an Xcode issue, use the build log to adjust and rebuild.
