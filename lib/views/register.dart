import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final/views/login.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
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
                    controller: usernameController,
                    decoration: InputDecoration(hintText: "Username"),
                    validator: (value) {
                      return null;
                    },
                  ),
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
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    decoration:
                        InputDecoration(hintText: "Retype your password"),
                    obscureText: true,
                    validator: (value) {
                      if (value!.length < 3) {
                        return "Password must be longer than 3 characters";
                      }

                      if (value.length > 32) {
                        return "Password must not be longer than 32 character";
                      }

                      if (passwordController.value.text != value) {
                        return "Both passwords should match";
                      }

                      return null;
                    },
                  ),
                ),
                Builder(
                  builder: (context) => FilledButton(
                    onPressed: () async {
                      WidgetsFlutterBinding.ensureInitialized();
                      if (_formKey.currentState!.validate()) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailController.value.text,
                                  password: passwordController.value.text);

                          credential.user?.updateDisplayName(
                              usernameController.value.text);

                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();
                            
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'The password provided is too weak.')));
                          } else if (e.code == 'email-already-in-use') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'The account already exists for that email.')));
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Text("Register"),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) => TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginView()));
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Text("Already Registered ? Log-in"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
