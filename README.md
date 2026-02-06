

# Evently

**Evently** is a modern, responsive Flutter application for managing events. It allows users to create, edit, delete, favorite, and search for events with ease. The app integrates **Firebase Authentication** and **Firestore** for user management and event storage, and supports **localization**, theming, onboarding, and smooth UI/UX interactions.

---

## 📌 Features

### **Event Management**

* Add new events with:

  * Title
  * Description
  * Date & Time
  * Image selection
* Edit existing events.
* Delete events.

### **Favorites**

* Mark/unmark events as favorite.
* View favorite events at the top of the list.
* Search favorite events in real-time.

### **Onboarding**

* Guided onboarding screens for first-time users.
* Smooth page indicators using `smooth_page_indicator`.

### **Localization & Theming**

* Multi-language support: **English & Arabic**.
* Dark mode & light mode support.
* Users can switch language and theme in the **Profile/Settings screen**.
* Text and UI automatically adjust to the selected language and theme.

### **Firebase Integration**

* User authentication with Firebase Auth.
* Sign in with Google.
* Store events and user data in Firestore.

### **User Experience**

* Responsive design with `flutter_screenutil`.
* Swipeable list items with `flutter_slidable`.
* Custom splash screen and app icons.
* Search functionality for events.
* Smooth animations and transitions.

### **Extras**

* Persistent user preferences with `shared_preferences` for language and theme.
* Fully tested and structured for scalability.
* Clean and organized UI components.

---

## 📁 Project Structure

* **features/** – Main app features like home, favorites, onboarding, profile, and event management.
* **models/** – Event model and data structure.
* **providers/** – State management using `Provider`.
* **assets/** – Images, translations, and other static resources.
* **core/utiles/** – Reusable styles, colors, and helper widgets.

---

## 📦 Dependencies

Some key packages used in this project:

* `provider` – State management
* `firebase_core`, `firebase_auth`, `cloud_firestore` – Firebase integration
* `easy_localization` – Multi-language support
* `flutter_screenutil` – Responsive UI
* `smooth_page_indicator` – Page indicators
* `flutter_slidable` – Swipeable list items
* `shared_preferences` – Persistent storage
* `go_router` – Navigation routing
     xxxxxxxxxxxxxxxxxxx

---
## 🎨 Screenshots



