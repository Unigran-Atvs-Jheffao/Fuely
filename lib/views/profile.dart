import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final/utils/date_utils.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var usr = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          makeInfo(
              name: "Username",
              field: usr.displayName,
              func: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    TextEditingController controller = TextEditingController();
                    return AlertDialog(
                      title: Text("Set Username"),
                      content: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          Text("Please provide your new username"),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Username",
                            ),
                            controller: controller,
                          )
                        ],
                      ),
                      actions: [
                        FilledButton(
                          onPressed: () {
                            FirebaseAuth.instance.currentUser!
                                .updateDisplayName(controller.value.text);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Username updated'),
                              ),
                            );
                          },
                          child: Text("Change username"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        )
                      ],
                    );
                  },
                );
              }),
          makeInfo(name: "E-mail", field: usr.email),
          makeEditable(
            name: "Password",
            widget: FilledButton(
              onPressed: () {
                FirebaseAuth.instance
                    .sendPasswordResetEmail(email: usr.email!);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Password change email sent'),
                  ),
                );
              },
              child: Text("Change"),
            ),
          ),
          makeInfo(
              name: "Account created",
              field: formatDate(usr.metadata.creationTime!)),
          makeInfo(
              name: "Last login",
              field: formatDate(usr.metadata.lastSignInTime!)),
        ],
      ),
    );
  }
}

Widget makeInfo({required name, required field, func}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 16),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                field,
                style: TextStyle(fontSize: 16),
              ),
            ),
            if (func != null)
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: func,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.edit),
                ),
              ),
          ],
        )
      ],
    ),
  );
}

Widget makeEditable({required name, required widget}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 16),
        ),
        Row(
          children: [
            Padding(padding: EdgeInsets.all(8), child: widget),
          ],
        )
      ],
    ),
  );
}
