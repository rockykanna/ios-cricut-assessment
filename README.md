# ios-cricut-assessment
Cricut Assessment

## Project Overview
This is an iOS application developed as part of the Cricut assessment. The app demonstrates modern SwiftUI practices, MVVM architecture, and networking to fetch and display palette data.

## Features
- Home screen displaying a grid of palette items
- Detail view for each palette item
- MVVM architecture
- Networking layer for data fetching
- Unit and UI tests

## Requirements
- Xcode 15 or later
- iOS 16.0 or later
- Swift 5.8 or later

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/rockykanna/ios-cricut-assessment.git
   ```
2. Open `CricutAssessment.xcodeproj` in Xcode.
3. Select a simulator or device and build/run the project.

## Project Structure
- `Application/` – App entry point and configuration
- `Core/` – Core utilities and network manager
- `Feature/Home/` – Home feature (Model, View, ViewModel)
- `Service/` – Services for data fetching
- `CricutAssessmentTests/` – Unit tests
- `CricutAssessmentUITests/` – UI tests

## Testing
- To run all tests, select the `Product > Test` menu in Xcode or press `Cmd+U`.

## License
This project is for assessment purposes only.

_Last updated: November 20, 2025_
