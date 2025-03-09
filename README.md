# adwise

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/to/state-management-sample).

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/to/resolution-aware-images).

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter apps](https://flutter.dev/to/internationalization).
## Project Structure

The `lib` directory contains the main code for the Flutter application. Below is a detailed description of each file and folder under the `lib` directory:

### lib/main.dart
This is the entry point of the Flutter application. It contains the `main` function which calls `runApp` to start the application.

### lib/src
This directory contains the main source code for the application, organized into various subdirectories.

#### lib/src/screens
This folder contains the different screens of the application. Each screen is represented by a separate Dart file.

#### lib/src/widgets
This folder contains reusable widgets that can be used across different screens of the application.

#### lib/src/models
This folder contains the data models used in the application. These models represent the structure of the data and are used to parse and generate JSON data.

#### lib/src/services
This folder contains the services used in the application. Services are responsible for handling business logic and communication with external APIs.

#### lib/src/utils
This folder contains utility functions and classes that provide common functionalities used throughout the application.

#### lib/src/localization
This folder contains the localization files for the application. These files are used to support multiple languages and provide localized messages.

#### lib/src/constants
This folder contains constant values used in the application, such as color schemes, text styles, and other configuration settings.

#### lib/src/providers
This folder contains the state management providers used in the application. These providers manage the state of the application and provide data to the widgets.

#### lib/src/routes
This folder contains the route definitions for the application. It defines the navigation paths and the corresponding screens.

By organizing the code in this manner, the project remains modular, maintainable, and scalable.
### lib/src/screens/home_screen.dart
This file represents the home screen of the application. It contains the UI and logic for the main screen that users see when they open the app.

### lib/src/widgets/custom_button.dart
This file contains a reusable custom button widget that can be used across different screens of the application.

### lib/src/models/user_model.dart
This file defines the `UserModel` class, which represents the structure of user data in the application.

### lib/src/services/api_service.dart
This file contains the `ApiService` class, which handles communication with external APIs and fetches data for the application.

### lib/src/utils/helpers.dart
This file contains helper functions that provide common functionalities used throughout the application.

### lib/src/localization/app_localizations.dart
This file contains the localization logic for the application, including methods to load and retrieve localized messages.

### lib/src/constants/app_constants.dart
This file defines constant values used in the application, such as color schemes, text styles, and other configuration settings.

### lib/src/providers/user_provider.dart
This file contains the `UserProvider` class, which manages the state of user data and provides it to the widgets.

### lib/src/routes/app_routes.dart
This file defines the route configurations for the application, mapping navigation paths to their corresponding screens.

