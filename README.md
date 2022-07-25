# Square1 Cities APP

- Square1 cities app is a one Page iOS Application which is built using UIKit and Xibs.
- Architecture Used is MVVM.
- Made use of Localizable to store Strings.
- The Map made use of Apple's MapKit.
- The Local Storage I made use of Realm which was installed through Swift Package Manager(SPM)
- To Test the App you connect with your Physical Device.

# Steps to get the app running.

- clone the Project to your local environment. using "git clone https://github.com/Thommzy/CitiesApp.git"
- then navigate to the Square1Cities directory in CitiesApp Folder.
- Then open Square1Cities.xcodeproj file. 
- You can open this using "open Square1Cities.xcodeproj" in your terminal.
- after opening you wait for some minutes, Realm Package Dependency will install automatically.
- if you encounter any issue with spm.
- Click the Project -> File -> Package -> Reset Package Caches.
- Or
- Click the Project -> File -> Package -> Resolve Package Versions.
- Then Clean Build
- Build and Run the app on your Physical Device.

Features of the App.
 
- Load multiple pages of cities with an infinite scroll approach.
- Filter results by city name using a search field.
- Toggle between the list and a map view.
