


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

---
## 🎨 Screenshots

_<!-- Row 1: Onboarding Dark & Light --> <img src="https://github.com/user-attachments/assets/13a2e548-0778-45ca-a14e-77f06212daeb" width="150" /> <img src="https://github.com/user-attachments/assets/73ef0f69-0a72-47ac-ad87-397694d8b7cf" width="150" /> <img src="https://github.com/user-attachments/assets/278c9d94-b57d-4964-bd49-b431f43186c1" width="150" /> <img src="https://github.com/user-attachments/assets/69d107fb-dda1-4b41-badd-35227ba6b6dc" width="150" /> <img src="https://github.com/user-attachments/assets/3d92cfa5-4c55-4ef3-9b21-12a130924cb4" width="150" /> <img src="https://github.com/user-attachments/assets/119f05c5-b39e-44cf-a8eb-69936b2d45c7" width="150" /> <!-- Row 2: Auth Screens Light --> <img src="https://github.com/user-attachments/assets/2dca45de-2e2d-441c-87dd-a5499e984f47" width="150" /> <img src="https://github.com/user-attachments/assets/12da3976-c59c-41c2-8669-12b260c021bf" width="150" /> <img src="https://github.com/user-attachments/assets/e0836e73-f2e1-4e6e-8678-215c4ddab969" width="150" /> <!-- Row 3: Profile & Favorites --> <img src="https://github.com/user-attachments/assets/537c9199-4d90-4acb-b4a6-1d39d5bc2e80" width="150" /> <img src="https://github.com/user-attachments/assets/bec5ad4d-c4bb-49b3-ba05-4ce3cf14b374" width="150" /> <img src="https://github.com/user-attachments/assets/33984c7b-2c22-4bf8-8bc3-46ae4835a8da" width="150" /> <img src="https://github.com/user-attachments/assets/3fc0a533-5158-4e2f-a6f1-a1fe33076c0e" width="150" /> <!-- Row 4: Event Screens Dark --> <img src="https://github.com/user-attachments/assets/337684f7-1567-434d-9426-28c5a54c261e" width="150" /> <img src="https://github.com/user-attachments/assets/441669ec-3786-4fd7-a023-cfce56e4ba31" width="150" /> <img src="https://github.com/user-attachments/assets/3ab64055-580c-42ef-ac77-d8ea2167b15b" width="150" /> <img src="https://github.com/user-attachments/assets/80af2560-e27b-4716-9efc-5e10a7d6c942" width="150" /> <img src="https://github.com/user-attachments/assets/48c274f1-6f50-4352-baf6-aa28911dc542" width="150" /> <img src="https://github.com/user-attachments/assets/30278b95-b4f8-4370-aff1-2cb4870180d6" width="150" /> <img src="https://github.com/user-attachments/assets/aa3fd79c-dd36-4552-94b6-dfcfde661aef" width="150" /> <!-- Row 5: Event Screens Light --> <img src="https://github.com/user-attachments/assets/f90801a0-2acb-435b-9908-576b676d28f0" width="150" /> <img src="https://github.com/user-attachments/assets/76473637-a89d-4284-b689-bafb557d5c17" width="150" /> <img src="https://github.com/user-attachments/assets/33662eb8-d1a3-4c15-be98-7db70fa6ec9f" width="150" /> <img src="https://github.com/user-attachments/assets/c923a431-ed42-405a-a865-1781b63045e8" width="150" /> <img src="https://github.com/user-attachments/assets/c20c7750-a2cc-4eb4-9308-c950cbffc20c" width="150" /> <img src="https://github.com/user-attachments/assets/ccf2ccf4-ae94-4f96-9992-c8ddd4f51136" width="150" /> <img src="https://github.com/user-attachments/assets/3422ec75-77d4-4e64-a059-6f33c26f9868" width="150" /> <!-- Row 6: Add/Edit/Filter --> <img src="https://github.com/user-attachments/assets/67330a11-390d-4812-b086-e8d3b6738206" width="150" /> <img src="https://github.com/user-attachments/assets/9d328018-219f-4db3-9f99-e1860d406f3d" width="150" /> <img src="https://github.com/user-attachments/assets/e2b513d1-c1be-428e-92ac-b6aac55014bf" width="150" /> <img src="https://github.com/user-attachments/assets/15504500-58b9-48d6-9095-9fd1bd902752" width="150" /> <img src="https://github.com/user-attachments/assets/ce385f56-6472-4439-8b5e-b41f6a9bf737" width="150" /> <img src="https://github.com/user-attachments/assets/3422ec75-77d4-4e64-a059-6f33c26f9868" width="150" /> <!-- Row 7: Swipe Actions & Categories --> <img src="https://github.com/user-attachments/assets/b29a1b11-1fd9-4ff8-a794-903fecc2955d" width="150" /> <img src="https://github.com/user-attachments/assets/b45eddcf-5b82-4b55-9ac9-6ea3f729f8c7" width="150" /> <img src="https://github.com/user-attachments/assets/e9718006-b501-4a31-a574-a95bbca4560c" width="150" /> <img src="https://github.com/user-attachments/assets/ce385f56-6472-4439-8b5e-b41f6a9bf737" width="150" />
---

## 🎨 Screenshots

*(Add screenshots here to showcase onboarding, dark/light theme, profile settings, and main event screens.)*
<img width="1080" height="2280" alt="useer profile screen dark" src="https://github.com/user-attachments/assets/537c9199-4d90-4acb-b4a6-1d39d5bc2e80" />
<img width="1080" height="2280" alt="event updated successfuly" src="https://github.com/user-attachments/assets/441669ec-3786-4fd7-a023-cfce56e4ba31" />
<img width="1080" height="2280" alt="event detail screen dark" src="https://github.com/user-attachments/assets/337684f7-1567-434d-9426-28c5a54c261e" />
<img width="1080" height="2280" alt="home tab screen dark " src="https://github.com/user-attachments/assets/3ab64055-580c-42ef-ac77-d8ea2167b15b" />
<img width="1080" height="2280" alt="home tab screen dark" src="https://github.com/user-attachments/assets/80af2560-e27b-4716-9efc-5e10a7d6c942" />
<img width="1080" height="2280" alt="choose time dark" src="https://github.com/user-attachments/assets/48c274f1-6f50-4352-baf6-aa28911dc542" />
<img width="1080" height="2280" alt="choose date dark" src="https://github.com/user-attachments/assets/30278b95-b4f8-4370-aff1-2cb4870180d6" />
<img width="1080" height="2280" alt="add event screen dark" src="https://github.com/user-attachments/assets/aa3fd79c-dd36-4552-94b6-dfcfde661aef" />
<img width="1080" height="2280" alt="Screenshot_20260206_020936" src="https://github.com/user-attachments/assets/8ed7d006-789f-45e5-8148-fb3cee2ca998" />
<img width="1080" height="2280" alt="user profile light" src="https://github.com/user-attachments/assets/bec5ad4d-c4bb-49b3-ba05-4ce3cf14b374" />
<img width="1080" height="2280" alt="user can search also here by itle or descriptio or category" src="https://github.com/user-attachments/assets/15504500-58b9-48d6-9095-9fd1bd902752" />
<img width="1080" height="2280" alt="favourite screen light" src="https://github.com/user-attachments/assets/33984c7b-2c22-4bf8-8bc3-46ae4835a8da" />
<img width="1080" height="2280" alt="update event screen light" src="https://github.com/user-attachments/assets/67330a11-390d-4812-b086-e8d3b6738206" /><img width="1080" height="2280" alt="onbardone" src="https://github.com/user-attachments/assets/13a2e548-0778-45ca-a14e-77f06212daeb" />
<img width="1080" height="2280" alt="onboarddark1" src="https://github.com/user-attachments/assets/73ef0f69-0a72-47ac-ad87-397694d8b7cf" />
<img width="1080" height="2280" alt="onboard4" src="https://github.com/user-attachments/assets/278c9d94-b57d-4964-bd49-b431f43186c1" />
<img width="1080" height="2280" alt="onboard3" src="https://github.com/user-attachments/assets/69d107fb-dda1-4b41-badd-35227ba6b6dc" />
<img width="1080" height="2280" alt="onboard2" src="https://github.com/user-attachments/assets/3d92cfa5-4c55-4ef3-9b21-12a130924cb4" />
<img width="1080" height="2280" alt="Screenshot_20260206_015719" src="https://github.com/user-attachments/assets/119f05c5-b39e-44cf-a8eb-69936b2d45c7" />
<img width="1080" height="2280" alt="restpassword" src="https://github.com/user-attachments/assets/12da3976-c59c-41c2-8669-12b260c021bf" />
<img width="1080" height="2280" alt="registerlight" src="https://github.com/user-attachments/assets/e0836e73-f2e1-4e6e-8678-215c4ddab969" />
<img width="1080" height="2280" alt="loginlight" src="https://github.com/user-attachments/assets/2dca45de-2e2d-441c-87dd-a5499e984f47" />
<img width="1080" height="2280" alt="category with no evnet yet dark" src="https://github.com/user-attachments/assets/e9718006-b501-4a31-a574-a95bbca4560c" />
<img width="1080" height="2280" alt="user delete when he swip dark" src="https://github.com/user-attachments/assets/b29a1b11-1fd9-4ff8-a794-903fecc2955d" />
<img width="1080" height="2280" alt="user edit when he swip dark" src="https://github.com/user-attachments/assets/b45eddcf-5b82-4b55-9ac9-6ea3f729f8c7" />
<img width="1080" height="2280" alt="fav screen dark" src="https://github.com/user-attachments/assets/3fc0a533-5158-4e2f-a6f1-a1fe33076c0e" />

<img width="1080" height="2280" alt="user when he clik on the evet it self to show event detail screen light" src="https://github.com/user-attachments/assets/f90801a0-2acb-435b-9908-576b676d28f0" />
<img width="1080" height="2280" alt="user can swip right to update event" src="https://github.com/user-attachments/assets/76473637-a89d-4284-b689-bafb557d5c17" />
<img width="1080" height="2280" alt="user can swip left o delett event" src="https://github.com/user-attachments/assets/33662eb8-d1a3-4c15-be98-7db70fa6ec9f" />
<img width="1080" height="2280" alt="filter by category selection light" src="https://github.com/user-attachments/assets/c923a431-ed42-405a-a865-1781b63045e8" />
<img width="1080" height="2280" alt="userchoose timelight" src="https://github.com/user-attachments/assets/c20c7750-a2cc-4eb4-9308-c950cbffc20c" />
<img width="1080" height="2280" alt="userchoose data light" src="https://github.com/user-attachments/assets/ccf2ccf4-ae94-4f96-9992-c8ddd4f51136" />
<img width="1080" height="2280" alt="category with no event yet" src="https://github.com/user-attachments/assets/ce385f56-6472-4439-8b5e-b41f6a9bf737" />
<img width="1080" height="2280" alt="addeveventlight" src="https://github.com/user-attachments/assets/3422ec75-77d4-4e64-a059-6f33c26f9868" />
<img width="1080" height="2280" alt="Screenshot_20260206_020533" src="https://github.com/user-attachments/assets/9d328018-219f-4db3-9f99-e1860d406f3d" />
<img width="1080" height="2280" alt="Screenshot_20260206_014730" src="https://github.com/user-attachments/assets/e2b513d1-c1be-428e-92ac-b6aac55014bf" />
  
