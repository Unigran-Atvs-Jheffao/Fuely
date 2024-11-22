import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var usr = FirebaseAuth.instance.currentUser!;

  
    return Center(
      child: Column(
        children: [
          Text(
            usr.displayName!,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Text(usr.email!),
        ],
      ),
    );
  }
}
