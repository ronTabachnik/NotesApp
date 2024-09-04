# Note App

## App Overview

The Note App is an iOS application developed as part of a task for an iOS Developer position. The app allows users to create, view, edit, and manage personal notes. Users can register or log in to their accounts, view a list of users fetched from an API, and save notes with titles, content, and optional images. Additionally, the app includes a map feature that allows users to see the location where notes were created.

## Core Features

### User Authentication
- **Login/Register:** Users can log in or register using their email and password.
- **Input Validation:** The app validates user input, such as ensuring that the password fields match during registration.
- **Error Handling:** If login or registration fails, the app displays appropriate error messages.

### User Management
- **User List:** Displays a list of users fetched from an API with their profile images, names, and email addresses.
- **User Details:** Users can view detailed information about each user, including their full name, email, and gender.

### Note Management
- **Create/Edit Notes:** Users can create new notes or edit existing ones. Notes can include a title, content, and an optional icon image.
- **Note Details:** Users can view the details of each note, including the title, content, and associated icon.
- **Delete Notes:** Users can delete notes, with a confirmation dialog to prevent accidental deletions.

### Map Integration
- **Note Location:** Notes can be associated with the user's current location, which is displayed on the map.
- **Location Refresh:** The app allows users to refresh their location if it's not available.

## Technologies Used

- **SwiftUI:** The app is built entirely using SwiftUI, Apple's modern UI framework for building iOS applications.
- **Combine:** Used for managing state and binding data throughout the app.
- **Kingfisher:** An open-source Swift library for downloading and caching images, used for displaying user avatars and note icons.
- **CoreLocation:** The app uses CoreLocation to get the user's current location and associate it with notes.

## App Structure

### 1. `AuthScreen`
The `AuthScreen` struct manages the login and registration process. It includes the following features:
- **State Variables:**
  - `email`, `password`, `rePassword`: To capture user input.
  - `isLogin`: To toggle between login and registration modes.
  - `warning`, `error`, `message`, `loading`: To handle and display validation warnings and error messages.
- **Validation:** The `validationMessage` computed property checks if the user input is valid. If not, it provides appropriate messages.
- **Authenticate Function:** The `authenticate()` function handles the authentication process using the `DataManager` class.

### 2. `UsersListView`
The `UsersListView` struct displays a list of users fetched from an API. It includes:
- **LazyVStack:** To efficiently display the list of users.
- **NavigationLink:** To navigate to the `DetailUserView` for each user.
- **Error Handling:** If the user data fails to load, the app provides a retry option.

### 3. `NoteScreen`
The `NoteScreen` struct manages the list of notes and includes:
- **List View:** Displays all saved notes, each with a title, content snippet, date, and optional icon.
- **Note Details:** Navigation to `NoteDetailView` when a note is selected.
- **Location Handling:** Ensures that the user's location is available before creating a new note.

### 4. `NoteDetailView`
The `NoteDetailView` struct provides detailed information about a specific note, including:
- **Note Content:** Displays the note's title, content, and optional icon.
- **Edit Mode:** Allows users to edit the note using the `EditNoteView`.

### 5. `EditNoteView`
The `EditNoteView` struct allows users to create or edit notes, featuring:
- **TextFields and TextEditor:** To capture the note's title and content.
- **Picker:** To select an icon for the note from predefined options.
- **Save and Update:** The user can either save a new note or update an existing one.
- **Delete Confirmation:** A confirmation dialog appears when the user opts to delete a note.

### 6. `DetailUserView`
The `DetailUserView` struct provides a detailed view of a user's information, including:
- **Profile Image:** Displayed using Kingfisher for optimized loading.
- **User Information:** Shows the user's name, email, and gender in a clean, centered layout.

## Data Management

### 1. `DataManager` Class
- **User Authentication:** Handles login and registration logic, communicating with the backend.
- **User Data Fetching:** Fetches and caches user data from an API.
- **Note Management:** Responsible for creating, updating, deleting, and retrieving notes.

### 2. `LocationManager` Class
- **Location Tracking:** Tracks and updates the user's current location, which is associated with notes.
- **Error Handling:** Provides a method to refresh location and handles cases where location data is unavailable.

## User Interface Design

- **SwiftUI Components:** The app uses SwiftUI components such as `NavigationView`, `Form`, `TextField`, `SecureField`, and `Button` to create a responsive and modern UI.
- **Theming:** The app uses a consistent color scheme and typography, ensuring a unified and user-friendly experience.

