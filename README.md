# OptiPrime-MacOS

A native, hardware-accelerated macOS wrapper for Amazon Prime Video, built to be dramatically more energy-efficient than the official client.

---

## The Problem

The official Prime Video macOS application, while functional, is built on a cross-platform foundation that leads to significant and unnecessary CPU usage, even when idle. On my Apple Silicon MacBook, I regularly observed the client consuming over **100-170% CPU**, causing high temperatures and rapid battery drain.

A diagnostic session using Xcode Instruments revealed the primary bottleneck: a rampant serialization loop involving `NSKeyedArchiver`, likely caused by an inefficient state management system.

**[INSERT YOUR XCODE INSTRUMENTS SCREENSHOT HERE]**
*(Caption: Xcode Instruments trace showing the NSKeyedArchiver bottleneck in the official app's main thread.)*

---

## The Solution: A Native WebKit Wrapper

This project solves the problem by wrapping the Prime Video web client in a minimal, native SwiftUI application using `WKWebView`, the same highly-optimized browser engine that powers Safari.

This approach offloads all heavy lifting—video decoding, rendering, and DRM—directly to Apple Silicon's dedicated media engines, bypassing the inefficient software loops of the official app.

### Key Features:

*   **Ultra-Lightweight:** Runs with a minimal CPU and memory footprint.
*   **Hardware Accelerated:** Leverages Apple's `VideoToolbox` for native H.264/HEVC decoding.
*   **Zero-CPU Backgrounding:** (Optional via `Coordinator`) When the app window is minimized or loses focus, it explicitly pauses video playback and suspends the WebKit process, dropping CPU usage to virtually 0%.

---

## The Results

The performance difference is night and day. While the official client idles at over 100% CPU, OptiPrime sits comfortably at **~2-5% CPU** during the same activity—a ~95-98% reduction in resource consumption.

**[INSERT YOUR SIDE-BY-SIDE DEMO VIDEO/GIF HERE]**
*(Caption: Side-by-side comparison in Activity Monitor. Left: Official Prime Video app. Right: OptiPrime.)*

This demonstrates how a native, system-aware architecture can provide a vastly superior user experience on macOS.

---

### Credits

*   **Code:** Written in Swift & SwiftUI.
*   **App Icon:** Generated using ChatGPT (DALL-E 3).
