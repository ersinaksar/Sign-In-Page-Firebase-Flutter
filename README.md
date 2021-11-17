# Sign-In-Page-Firebase-Flutter
One page sign in page. Using firebase and flutter. Controlling input data and write to firebase.

One screen which will display two input fields (First name & Last name) and one button. 
When you press the button, check if the inputs in the fields are latin characters ONLY (lowercase and uppercase). If yes, save the data in a Firebase database. 
If the inputs include non-valid characters (such as numbers or special characters), warn the user.

1. .apk file => Done
2. source code => Done
	The application has one single sign in page.
	As a design parttern MVC used for flexibility
	Added extra:
		services
		usermodel
		fake_authentication services 
		..etc.
	for develop the application in the future easily 
3. Firebase details
	cloud_firestore: ^0.12.9+4
	The input which are correct form saved in firebase Firestore Database.
	In firebase Firestore Database created 
		collection "users" 
		document "user"
			name:"yourname"
			surname:"yoursurname"
3. Details about Flutter version SDK etc.
	From pubspec.yaml file you can find details.
	version: 1.0.0+1

	environment:
	  sdk: ">=2.7.0 <3.0.0"

	dependencies:
	  flutter:
	    sdk: flutter
	  cupertino_icons: ^1.0.2
	  get_it: ^1.0.3+2
	  provider: ^5.0.0
	  cloud_firestore: ^0.12.9+4
	  firebase_auth: 0.14.0+5
