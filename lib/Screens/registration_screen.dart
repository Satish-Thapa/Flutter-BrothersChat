import 'package:brothers_chat/constrants.dart';
import 'package:flutter/material.dart';
import 'package:brothers_chat/components/roundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
/*
-----------For using firebase---------
i. Create a project in fire base
ii. See user name from android.gradle
iii. download the jason file and paste it in android>app
iv.As the documentataion says add all the dependencies in yaml and gradle file (make sure to user minSdk version in android.gradle as 21
v. add firebase core dependencies on yaml fire
vi. aaru chiyeko add garney aani
vii. import the files and enjoy
---------------------------------------
---------first in main.dart---------
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //mainline
  runApp(BrothersChat());
}
-------------
For Registration of user
i. import fire_auth package
ii. Create a _auth variable which is FirebaseAuth.instance to store user
final _auth = FirebaseAuth.instanc
iii. use
final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
which creates a new user;
iv. if (newUser != null) {
                    //A user who is registred
    -- Go to chat screen
-----------------For chat Screen-------------------
i. Create a _auth variable which is FirebaseAuth.instance to store user
final _auth = FirebaseAuth.instance;
  late User loggedInUser;   //for storing login user (user is updated)
ii. Method for check if their is a current user which is signed in

void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {  //Check if we have a currently signed in
        loggedInUser = user;   //Login bhako user lai chai loggedInUser ma halney
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }
 iii. Trigger this method on initstate
 iv. Enable this feature in firebase and activating email sign in method
 --------make sure ur password is 6 character long------------
 ------------for login screen------------
 i.same as registration but use final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password); instead!!
 */

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                //poila 200 ma atcha bhane gar natra sano huncha screen aanusar
                child: Hero(
                  tag: 'flash',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password')),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register',
                color: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      //A user who is registred
                      //
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
