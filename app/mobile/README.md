### System Requirements:

- **Operating System**: Windows (7 SP1 or later), macOS (10.12.0 or later),  Linux (64-bit) or Android Device
- **Disk Space**: 2.8 GB for Windows, 4.5 GB for macOS, and 2.8 GB for Linux
- **Tools**: Android Studio for APK on emulator, Xcode for iOS version on the simulator
#### Running APK on your Android Device:


- Allow Chrome to install unknown apps by going to **Settings** > **Apps** > **Menu** > **Special access** > **Install unknown apps**.
- Install a file manager (such as Cx File Explorer or File Manager) so that you can find the APK file after you download it to your phone.
- Download the APK file  from [here](https://github.com/bounswe/bounswe2023group8/releases/download/final-submission-g8/app-release.apk)  and open it to install it. Alternatively, transfer the APK Installer from your computer using USB.

#### Running App on Computer:

### Installation Instructions:

#### Flutter SDK Installation:

1. **Download Flutter**: Visit the [Flutter website](https://flutter.dev/) and download the latest stable release suitable for your operating system.
2. **Extract the Zip File**: Extract the downloaded file to a location on your computer.
3. **Add Flutter to PATH (Windows)**:
    - From the Start search bar, type 'env' and select 'Edit the system environment variables.'
    - Click 'Environment Variables...'
    - Under 'System Variables', select 'Path' and click 'Edit...'
    - Click 'New' and add the path to the 'bin' folder in the Flutter directory.
4. **Run `flutter doctor`**: Open a terminal or command prompt and run `flutter doctor` to verify the Flutter installation and to identify any missing dependencies.

### Running on Emulator/Simulator:

#### Emulator Setup (Android Studio):

1. **Download Android Studio**: Install Android Studio from the official website.
2. **Launch Android Studio** and navigate to `Tools > AVD Manager`.
3. **Create a Virtual Device**: Click on `+ Create Virtual Device`, select a device definition, and follow the prompts to create an Android emulator.
4. **Run the Emulator**: Start the emulator by clicking on the play button next to the created device in the AVD Manager.

#### iOS Simulator Setup:

1. **Install Xcode**: Download and install Xcode from the Mac App Store.
2. **Open Xcode**: Accept the license agreement and install any necessary components.
3. **Open the iOS Simulator**: Launch Xcode, then go to `Xcode > Open Developer Tool > Simulator`.
####  Set Up the Development Environment

Choose an IDE: Select an Integrated Development Environment (IDE) such as Visual Studio Code (VS Code), Android Studio, Xcode etc. Download and install the IDE of your choice.

Integrate with Flutter: If you're using VS Code, install the Flutter and Dart extensions to make your IDE Flutter-ready.

##### Clone the Project

Open a Terminal or Command Prompt.

Get the Clone URL: Get the clone URL for the project repository from a source like GitHub.

Navigate to a Desired Folder: Navigate to the directory where you want to store the project on your computer.

Clone the Project: Use the following command to clone the project:

git clone https://github.com/bounswe/bounswe2023group8.git

Step 4: Install Dependencies

Move to the Project Directory: Use the Terminal or Command Prompt to navigate to the project's root directory.

Install Dependencies: Run the following command to install the project's dependencies:

flutter pub get
### Usage:

- Once your simulator/emulator is ready: In the terminal, navigate to your Flutter project directory `/mobile` and execute `flutter run` to launch the app
- Once the application is installed on the emulator/device, interact with it as you would with any other mobile application.
- Use the emulator/simulator controls to simulate touch, gestures, and other interactions as needed for testing the application.

Remember, Flutter offers a rich set of documentation and resources that can further assist with troubleshooting.
