import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final/main.dart';
import 'package:trabalho_final/views/register.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    return MaterialApp(
      theme:
          ThemeData.from(colorScheme: ColorScheme.dark(primary: Colors.orange)),
      home: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(
                    Icons.local_gas_station_rounded,
                    size: 128,
                    color: Colors.orange,
                  ),
                  Text(
                    "Fuely",
                    style: TextStyle(fontSize: 32),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(hintText: "E-mail"),
                      validator: (value) {
                        if (RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                            .hasMatch(value!)) {
                          return null;
                        }
                        return "Invalid Email";
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(hintText: "Password"),
                      obscureText: true,
                      validator: (value) {
                        if (value!.length < 3) {
                          return "Password must be longer than 3 characters";
                        }

                        if (value.length > 32) {
                          return "Password must not be longer than 32 character";
                        }

                        return null;
                      },
                    ),
                  ),
                  Builder(builder: (context) {
                    FirebaseAuth.instance
                        .authStateChanges()
                        .listen((User? user) {
                      if (user != null && user.emailVerified && !user.isAnonymous) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => MainApp()));
                      }
                    });

                    return FilledButton(
                      onPressed: () async {
                        WidgetsFlutterBinding.ensureInitialized();

                        if (_formKey.currentState!.validate()) {
                          try {
                            final credential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailController.value.text,
                                    password: passwordController.value.text);

                              if(!credential.user!.emailVerified){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'User is not verified')));
                              }
                                    
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'No user found for that email.')));
                            } else if (e.code == 'wrong-password') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Wrong password provided for that user.')));
                            }
                          }
                        }
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Text("Login"),
                      ),
                    );
                  }),
                  Builder(
                    builder: (context) => TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterView()));
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Text("Not registered ? Register Here"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
