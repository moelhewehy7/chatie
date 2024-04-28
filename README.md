# Chatie App
Chatie is a messaging app that allows users to chat with different people, send pictures and emojis, and see when their messages have been read. The app supports both dark and light modes for user preference.

## Screenshots

<img src="https://github.com/moelhewehy7/booksage/assets/130074772/4be60df6-85cb-470b-9f4b-aac5133a8f21" alt="Image 1" height="300" width="150">
<img src="https://github.com/moelhewehy7/booksage/assets/130074772/99dbefbf-525c-41ed-a7b7-005b5b1ce140" alt="Image 2" height="300" width="150">
<img src="https://github.com/moelhewehy7/booksage/assets/130074772/75b28cd4-3ad4-4a80-8382-f9038aef8377" alt="Image 3" height="300" width="150">
<img src="https://github.com/moelhewehy7/booksage/assets/130074772/bafb348e-27b6-4abb-b8c8-2b3fffa69b2a" alt="Image 4" height="300" width="150">
<img src="https://github.com/moelhewehy7/booksage/assets/130074772/b6230c0c-8e1b-40a5-81fd-d46764722d8c" alt="Image 5" height="300" width="150">
<img src="https://github.com/moelhewehy7/booksage/assets/130074772/8e645a44-4bc2-40d2-932a-ac7df5ecd6fc" alt="Image 6" height="300" width="150">
<img src="https://github.com/moelhewehy7/booksage/assets/130074772/aa2ad575-fba0-47ff-a1d1-638635340a7e" alt="Image 7" height="300" width="150">
<img src="https://github.com/moelhewehy7/booksage/assets/130074772/8fd007b8-dacc-4711-918c-05b80cad437b" alt="Image 8" height="300" width="150">


## Installation

1. Clone the repository 
2. Run `flutter pub get` to install dependencies
3. Run the app on a device or emulator using `flutter run` .


## Features
Chat with different people
Send pictures and emojis
Message status indicators (e.g., "done" when message is read)
Dark and light modes
Screenshots
Include screenshots of the app here to showcase its design and features.

## Usage
Chats: View and chat with different people.
Groups: Manage and chat in group conversations.
Contacts: Access and manage your contacts.
Settings: Customize app settings, including theme preference.

## Work in Progress

This project is still under development. I am actively working on it and making improvements. 

### Completed Features
- Chats Screen: Finished implementing the chats screen, where users can chat with different people.

### Upcoming Features
- Groups Screen: Implementing the groups screen to manage and chat in group conversations.
- Contacts Screen: Implementing the contacts screen to access and manage contacts.
- Settings Screen: Implementing the settings screen to customize app settings, including theme preference.

## Implementation Details
State Management: Utilizes the Cubit package for state management.
Message Stream: Uses StreamBuilder to display messages in real-time.

## Firebase Integration

This project integrates with Firebase for backend services. Firebase is used for:
- Authentication: User authentication using Firebase Authentication.
- Realtime Database: Storing and retrieving chat messages and other app data in real-time.
- Storage: Storing and retrieving images and other files using Firebase Storage.
