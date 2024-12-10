# Firebase Data Connect Quickstart

## Introduction

This quickstart is a movie review app to demonstrate the use of Firebase Data Connect with a Cloud SQL database. For more information about Firebase Data Connect visit [the docs](https://firebase.google.com/docs/data-connect/).


## Getting Started

Follow these steps to get up and running with Firebase Data Connect. For more detailed instructions, check out the [official documentation](https://firebase.google.com/docs/data-connect/quickstart).

### 1. Connect to your Firebase project

1. If you haven't already, create a Firebase project.
    1. In the [Firebase console](https://console.firebase.google.com), click
        **Add project**, then follow the on-screen instructions.
2. Enable Email/Password Sign-in method [here](https://console.firebase.google.com/project/_/authentication/providers).

### 2. Cloning the repository

1. Clone this repository to your local machine:
   ```sh
   git clone https://github.com/firebase/quickstart-flutter.git
   ```
2. Configure flutterfire
This will automatically download and set up firebase for your project:
```sh
flutterfire configure -y -a com.example.dataconnect
```


### 3. Open in Visual Studio Code (VS Code)

1. Click on the Firebase Data Connect icon on the VS Code sidebar to load the Extension.
   a. Sign in with your Google Account if you haven't already.
2. Click on "Connect a Firebase project" and choose the project where you have set up Data Connect.
3. Click on "Start Emulators" - this should generate the Kotlin SDK for you and start the emulators.

### 4. Populate the database
In VS Code, open the `quickstart-flutter/dataconnect/dataconnect/moviedata_insert.gql` file and click the
 `Run (local)` button at the top of the file.

If you’d like to confirm that the data was correctly inserted,
open `quickstart-flutter/dataconnect/movie-connector/queries.gql` and run the `ListMovies` query.

### 5. Running the app

Press the Run button in VS Code to run the sample app on your device.
