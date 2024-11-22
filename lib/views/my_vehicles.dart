import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final/components/add_vehicle_tile.dart';
import 'package:trabalho_final/components/vehicle_tile.dart';
import 'package:trabalho_final/models/vehicle.dart';
import 'package:trabalho_final/state.dart';
import 'package:trabalho_final/views/add_vehicle.dart';

class MyVehiclesView extends StatefulWidget {
  const MyVehiclesView({super.key});

  @override
  State<MyVehiclesView> createState() => MyVehiclesViewState();
}

class MyVehiclesViewState extends State<MyVehiclesView> {
  final db = FirebaseFirestore.instance;
  final usr = FirebaseAuth.instance;

  late Future<QuerySnapshot<Map<String, dynamic>>> _data = db
      .collection(COLLECTION_VEHICLES)
      .where("owner", isEqualTo: usr.currentUser!.uid)
      .limit(100)
      .get();

  void reload() {
    setState(() {
      _data = db
          .collection(COLLECTION_VEHICLES)
          .where("owner", isEqualTo: usr.currentUser!.uid)
          .limit(100)
          .get();
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    return FutureBuilder(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasData) {
          return ListView(
            children: [
              AddVehicleTile(
                parentState: this,
              )
            ],
          );
        }

        return ListView(
          children: List.generate(
            1 + snapshot.data!.size,
            (index) {
              if (index == 0) {
                return AddVehicleTile(parentState: this);
              } else {
                return VehicleTile(
                  vehicle: Vehicle.fromMap(
                    snapshot.data!.docs[index - 1].data(),
                  ),
                  documentId: snapshot.data!.docs[index - 1].id,
                  parentState: this,
                );
              }
            },
          ),
        );
      },
    );
  }
}
