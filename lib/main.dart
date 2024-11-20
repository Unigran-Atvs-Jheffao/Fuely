import 'package:flutter/material.dart';
import 'package:trabalho_final/state.dart';
import 'package:trabalho_final/views/home.dart';
import 'package:trabalho_final/views/my_vehicles.dart';
import 'package:trabalho_final/views/profile.dart';
import 'package:trabalho_final/views/refuel_history.dart';

void main() {
  runApp(const MainApp());
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
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Fuely"),
      ),
      drawer: Drawer(
        child: Builder(
          builder: (context) => ListView(padding: EdgeInsets.zero, children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("A"),
                  Text("B"),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                setScreen(context, 0);
              },
            ),
            ListTile(
              leading: Icon(Icons.directions_car),
              title: const Text('Meus Veiculos'),
              onTap: () {
                setScreen(context, 1);
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: const Text('Histórico de Abastecimento'),
              onTap: () {
                setScreen(context, 2);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                setScreen(context, 3);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {},
            ),
          ]),
        ),
      ),
      body: [
        const HomeView(),
        const MyVehiclesView(),
        const RefuelHistoryView(),
        const ProfileView()
        ][screen],
    ));
  }
}
