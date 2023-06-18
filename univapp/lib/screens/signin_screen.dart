import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_signin/reusable_widgets/reusable_widget.dart';
import 'package:firebase_signin/screens/home_screen.dart';
import 'package:firebase_signin/screens/reset_password.dart';
import 'package:firebase_signin/screens/signup_screen.dart';
import 'package:firebase_signin/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool _rememberMe = false; // Define _rememberMe variable

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late SharedPreferences _prefs; // SharedPreferences variable

  @override
  void initState() {
    super.initState();
    _loadRememberMe(); // Load Remember Me preference on initialization
  }

  void _loadRememberMe() async {
    _prefs = await SharedPreferences.getInstance();
    bool rememberMe = _prefs.getBool('rememberMe') ?? false;
    setState(() {
      _rememberMe = rememberMe;
      if (_rememberMe) {
        _emailTextController.text = _prefs.getString('email') ?? '';
        _passwordTextController.text = _prefs.getString('password') ?? '';
      }
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _signInWithEmailAndPassword() {
    if (_formKey.currentState!.validate()) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim(),
      )
          .then((value) {
        if (_rememberMe) {
          _saveRememberMe(); // Save Remember Me preference on successful sign-in
        } else {
          _clearRememberMe(); // Clear Remember Me preference
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }).catchError((error) {
        _showErrorDialog('Invalid email or password. Please try again.');
      });
    }
  }

  void _saveRememberMe() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('rememberMe', _rememberMe);
    if (_rememberMe) {
      _prefs.setString('email', _emailTextController.text.trim());
      _prefs.setString('password', _passwordTextController.text.trim());
    }
  }

  void _clearRememberMe() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.remove('rememberMe');
    _prefs.remove('email');
    _prefs.remove('password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [hexStringToColor("9546C4"), hexStringToColor("5E61F4")],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.1,
              20,
              0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "assets/images/logo.png",
                    width: 175,
                    height: 170,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Erode University App',
                          style: TextStyle(
                            fontSize: 39,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' - Developed By Haries Palaniappan',
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  reusableTextField(
                    "Enter Email Address",
                    Icons.person_outline,
                    false,
                    _emailTextController,
                    (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email address.';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  reusableTextField(
                    "Enter Password",
                    Icons.lock_outline,
                    true,
                    _passwordTextController,
                    (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password.';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long.';
                      }
                      return null;
                    },
                  ),
                  CheckboxListTile(
                    title: Text("Remember me"),
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(height: 5),
                  forgetPassword(context),
                  firebaseUIButton(
                      context, "Sign In", _signInWithEmailAndPassword),
                  signUpOption(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResetPassword()),
        ),
      ),
    );
  }
}
