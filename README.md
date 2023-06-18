# University App – Developed By Haries Palaniappan

This repository contains a Flutter mobile application that allows users to browse and view details of various universities. The app provides a login functionality and utilizes Firebase for user authentication and data storage. The list of universities is fetched from an API and displayed in a list view with a search feature. Clicking on a university item will navigate to a new page that displays detailed information about the selected university.

## University App Demo Video

[![University App - Demo](demo_video/University_App_Demo_By_HP.mp4)](demo_video/University_App_Demo_By_HP.mp4)


## Features

- User authentication with Firebase
- Login page:
	- Test Account : 
		- Email Address : test@gmail.com
		- Password      : test@123
- Home page with a list of universities
- Search functionality to filter universities
- University details page to view detailed information

## Installation

To run the University App locally, make sure you have Flutter and Dart installed on your machine. Then, follow these steps:

1. Clone this repository to your local machine using:

   ```bash
   git clone https://github.com/haries-dev/University-App-Using-Flutter.git
   ```

2. Change into the project directory:

   ```bash
   cd University-App-Using-Flutter
   ```

3. Install the required dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:

   ```bash
   flutter run
   ```

   This will launch the app on the connected device or emulator.

## Configuration

Before running the app, you need to set up Firebase for authentication and storage. Follow these steps to configure Firebase:

1. Create a new project on the [Firebase console](https://console.firebase.google.com/).

2. Enable Firebase Authentication and choose your preferred authentication method (e.g., email and password).

3. Set up Firebase Realtime Database or Cloud Firestore for storing university data. You can refer to the [Firebase documentation](https://firebase.google.com/docs) for more details on setting up Firebase services.

4. Once Firebase is configured, update the Firebase configuration in the app. Locate the `lib/services/firebase_service.dart` file and replace the placeholders with your Firebase project configuration.

## APIs

The University App uses the following API to fetch the list of universities:

- **GET** - `http://universities.hipolabs.com/search?country=India`

The API returns a JSON response containing information about universities in India. The app retrieves this data and displays it in the list view.

## Contributing

Contributions to the University App are welcome! If you encounter any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request. 

When contributing, please follow the existing code style and commit message conventions.

## Acknowledgements

- Flutter: [https://flutter.dev](https://flutter.dev)
- Firebase: [https://firebase.google.com](https://firebase.google.com)
- University API: [http://universities.hipolabs.com](http://universities.hipolabs.com)
  
## Folder Structure

The University App repository follows the standard Flutter project structure:

- `lib/`: Contains the main Dart code for the app.
  - `main.dart`: Entry point of the application.
  - `models/`: Contains data models used in the app.
  - `pages/`: Contains the different pages/screens of the app.
  - `services/`: Contains the services responsible for API calls and Firebase integration.
  - `utils/`: Contains utility/helper classes used throughout the app.
- `assets/`: Contains static assets such as images and fonts used in the app.
- `test/`: Contains unit tests for the app.
- `pubspec.yaml`: Defines the dependencies and assets used in the app.

## Testing

The University App includes unit tests to ensure the correctness of the implemented functionalities. To run the tests, use the following command:

```bash
flutter test
```

The tests are located in the `test/` directory and cover various components and services of the app.

## Continuous Integration

This repository is set up with a continuous integration (CI) system to automatically run tests and perform checks on each commit. The CI pipeline ensures that the codebase remains healthy and functional. 

## Deployment

To deploy the University App to a mobile device, follow these steps:

1. Generate the release build of the app:

   ```bash
   flutter build apk --release
   ```

   This command will generate an APK file in the `build/app/outputs/apk/release/` directory.

2. Install the generated APK on your Android device.

   - Connect your Android device to your computer.
   - Enable USB debugging on your device.
   - Install the APK using the following command:

     ```bash
     flutter install
     ```

     This command will install the APK on the connected device.

For iOS deployment, you can follow the Flutter documentation to generate an IPA file and deploy it to your device.

## Support

If you have any questions, suggestions, or need help with the University App, please feel free to reach out by opening an issue in this repository. Your feedback is highly appreciated.

## Conclusion

The University App is a mobile application developed using Flutter and Firebase. It provides a seamless user experience with features like user authentication, a login page, a home page with a list of universities, a search feature, and a university details page. The app fetches university data from an API and utilizes Firebase for storage. Contributions to this project are welcome, and we hope you find this app useful and informative!

Thank you for using the University App!

