import 'package:flutter/material.dart';

class FuelyDrawer extends StatelessWidget {
  final String user;
  final String email;
  const FuelyDrawer({super.key, required this.user, required this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user),
                Text(email),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_car),
            title: const Text('Meus Veiculos'),
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: const Text('Histórico de Abastecimento'),
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
