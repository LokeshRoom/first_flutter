import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/src/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String title;

  const LoginPage({Key? key, required this.title}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  Icon icon = Icon(Icons.visibility);

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      icon = _obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility);
    });
  }

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    usernameController.addListener(_printUsername);
    passwordController.addListener(_printPassword);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _printUsername() {
    print('Username: ${usernameController.text}');
  }

  void _printPassword() {
    print('Username: ${passwordController.text}');
  }

  _signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Sign in Successful");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  _forgotPassword() async {
    usernameController.clear();
    passwordController.clear();
  }

  void signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                controller: usernameController,
                autofocus: true,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(),
                  labelText: 'Username',
                ),
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: this.icon,
                    onPressed: () => _toggle(),
                  )),
              obscureText: _obscureText,
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Button(
                      buttonText: 'Forgot Password?',
                      onPressed: () async {
                        await _forgotPassword();
                      }),
                  Button(
                    onPressed: () async {
                      await _signIn(usernameController.text, passwordController.text);
                    },
                    buttonText: 'Sign In',
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome Home'),
          ],
        ),
      ),
    );
  }
}
