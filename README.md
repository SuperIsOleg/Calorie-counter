# 🍏 CalorieTracker — iOS Test Assignment

A simple offline calorie calculator for the current day. The user enters a food name and its calories, and the app stores the data locally and calculates the daily total.

## 🎯 Goal

Build a minimal prototype for tracking daily calories with local storage and basic validation logic.

## 🛠 Tech Stack

- iOS 18, Xcode 16, Swift 6  
- SwiftUI  
- SwiftData — local persistence  
- Architecture: MVVM  

## 📦 Core Features (MVP)

### ✔️ Adding a Food Entry
- Input field for food name and calorie value  
- Add button  
- String parsing → name + calories  

### ✔️ List of Added Items
- Display format: **title · kcal**  
- Swipe to delete  
- Swipe to edit  
- Delete confirmation via Alert  

### ✔️ Validation
- Alert shown when attempting to add an item with a duplicate name  

### ✔️ Daily Summary
- Total calories displayed as a large number on the main screen  

## ✨ Additional Enhancements (implemented)

- 📸 Ability to attach a photo from the gallery  
- 🎞 Smooth animations (progress bar, text transitions)  
- 💡 Clear MVVM structure  
- 💾 Reliable storage using SwiftData  
- 🧹 Well-structured error handling and user feedback  

## 🚀 How to Run

1. Open the project in **Xcode 16**
2. Run on an **iOS 18 simulator** or a real device
3. No external dependencies — fully offline
