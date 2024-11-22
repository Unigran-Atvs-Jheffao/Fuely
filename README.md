# Fuely: Refueling Management App 🚗⛽  

Welcome to **Fuely**, your streamlined solution for managing vehicle refueling and monitoring fuel efficiency! Whether you're tracking refueling details for a single car or multiple vehicles, Fuely simplifies the process and provides valuable insights into your fuel consumption.  

This app is built using **Dart** and the **Flutter framework**, leveraging **Firebase Authentication** and **Firestore** for a secure and seamless experience.  

---

## Features 🌟  

### Core Functionality  
- **Track Refueling Data per Vehicle**: Log refueling events for each vehicle, including details such as fuel quantity, cost, and date.  
- **Calculate Average Consumption Rate**: Automatically compute each vehicle's fuel efficiency to help you monitor and optimize fuel usage.  

### Supporting Features  
- **Secure Authentication**: Powered by Firebase Authentication, ensuring that your data is safely accessible only to you.  
- **Cloud Data Storage**: Store and sync refueling data in real-time with Firebase Firestore.  
- **Multi-Vehicle Support**: Manage refueling records for multiple vehicles in one convenient app.  
- **User-Friendly Interface**: Simple and intuitive design for hassle-free navigation and data entry.  

---  

## Tech Stack 💻  

- **Frontend**: Dart & Flutter  
  - Cross-platform compatibility for Android and iOS.  
  - Elegant and responsive UI design.  

- **Backend**: Firebase  
  - **Authentication**: Secure and hassle-free user login.  
  - **Firestore**: Reliable, cloud-based database for storing refueling data.  

---  

## Basic Development Setup 🛠️  

### Prerequisites  
1. **Flutter SDK**: Install Flutter by following the [official guide](https://flutter.dev/docs/get-started).  
2. **Firebase Project**:  
   - Set up a Firebase project in the Firebase console.  
   - Enable **Authentication** (Email/Password).  
   - Enable **Firestore** and set up rules as needed.  
   - Download the Firebase configuration files:  
     - `google-services.json` (for Android).  
     - `GoogleService-Info.plist` (for iOS).  
3. **Dart**: Ensure Dart is included with your Flutter installation.  

### Steps  
1. Clone the repository:  
   ```bash
   git clone https://github.com/yourusername/fuely.git
   ```  
2. Navigate to the project folder:  
   ```bash
   cd fuely
   ```  
3. Install dependencies:  
   ```bash
   flutter pub get
   ```  
4. Add Firebase configuration files:  
   - Place `google-services.json` in the `android/app` directory.  
   - Place `GoogleService-Info.plist` in the `ios/Runner` directory.  

5. Run the app:  
   ```bash
   flutter run
   ```  

---

## Contribution Guidelines 🤝  

We welcome contributions from the community! To contribute:  
1. Fork the repository.  
2. Create a new branch:  
   ```bash
   git checkout -b feature/your-feature-name
   ```  
3. Commit your changes:  
   ```bash
   git commit -m "Add your message here"
   ```  
4. Push your branch:  
   ```bash
   git push origin feature/your-feature-name
   ```  
5. Submit a pull request. 🎉  
