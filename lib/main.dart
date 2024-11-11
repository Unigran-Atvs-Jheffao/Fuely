import 'package:flutter/material.dart';
import 'package:trabalho_final/components/fuely-drawer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: FuelyDrawer(user: "Hakimen", email: "hakimen@hakimen.com",),
        appBar: AppBar(
          title: const Text('AppBar without hamburger button'),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){}, child: Icon(Icons.add),),
      ),
    );
  }
}
