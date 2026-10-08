# OptiPrime-MacOS

A native, hardware-accelerated macOS wrapper for Amazon Prime Video, built to be dramatically more energy-efficient than the official client.

---

## The Problem

The official Prime Video macOS application, while functional, is built on a cross-platform foundation that leads to significant and unnecessary CPU usage, even when idle. On my Apple Silicon MacBook, I regularly observed the client consuming over **100-170% CPU**, causing high temperatures and rapid battery drain.

A diagnostic session using Xcode Instruments revealed the primary bottleneck: a rampant serialisation loop involving `NSKeyedArchiver`, likely caused by an inefficient state management system.

<img width="1470" height="956" alt="Screenshot 2026-10-08 at 14 52 16" src="https://github.com/user-attachments/assets/f0a718dd-4a7e-4500-9dc6-8eb8613dcb7d" />

*Xcode Instruments trace showing the NSKeyedArchiver bottleneck in the official app's main thread.*

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

<img width="1470" height="956" alt="The Mentalist" src="https://github.com/user-attachments/assets/3fdbcb15-cfd8-4ce8-a7d7-441b0ac3ed9c" />

*Side-by-side comparison. Bottom Left: Official Prime Video app. Top Left: OptiPrime. Right: Activity Monitor*

This demonstrates how a native, system-aware architecture can provide a vastly superior user experience on macOS.

https://github.com/user-attachments/assets/5d4283c9-5dd6-417f-bb3b-642582f12b9b

As seen in the above demo, upon window minimisation, OmniPrime eventually frees up CPU usage, PrimeVideo on the other hand continues using CPU threads.

---

### Credits

* **Systems Analysis & Software Engineering:** Siddhi Jain (Nanyang Technological University, Singapore)
* **AI Pairing Partner:** Gemini Enterprise (for real-time system architecture design, profiling analysis, and Swift/WebKit optimization)
* **App Icon Artwork:** Generated via ChatGPT (DALL-E 3)

<img width="261" height="279" alt="optiprime_logo" src="https://github.com/user-attachments/assets/6536d937-1255-4d1b-89f7-bdf6d08c8841" />
