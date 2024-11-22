import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final/firebase_options.dart';
import 'package:trabalho_final/state.dart';
import 'package:trabalho_final/views/home.dart';
import 'package:trabalho_final/views/login.dart';
import 'package:trabalho_final/views/my_vehicles.dart';
import 'package:trabalho_final/views/profile.dart';
import 'package:trabalho_final/views/refuel_history.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LoginView());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  void setScreen(BuildContext context, int scr) {
    setState(() {
      if (screen != scr) {
        Navigator.pop(context);
      }
      screen = scr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text([
          "My Vehicles",
          "Refuel History",
          "Profile"
        ][screen]),
      ),
      drawer: Drawer(
        child: Builder(
          builder: (context) => ListView(padding: EdgeInsets.zero, children: [
             DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.orange
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(FirebaseAuth.instance.currentUser!.displayName ?? "User"),
                  Text(FirebaseAuth.instance.currentUser!.email!),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.directions_car),
              title: const Text('My Vehicles'),
              onTap: () {
                setScreen(context, 0);
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: const Text('Refuel History'),
              onTap: () {
                setScreen(context, 1);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                setScreen(context, 2);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginView()));
              },
            ),
          ]),
        ),
      ),
      body: [
        const MyVehiclesView(),
        const RefuelHistoryView(),
        const ProfileView()
        ][screen],
    );
  }
}
