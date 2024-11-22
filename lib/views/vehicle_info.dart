import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final/components/add_refuel_tile.dart';
import 'package:trabalho_final/components/refuel_tile.dart';
import 'package:trabalho_final/models/vehicle.dart';
import 'package:trabalho_final/state.dart';

class VehicleInfoView extends StatefulWidget {
  final String docId;
  const VehicleInfoView({super.key, required this.docId});

  @override
  State<VehicleInfoView> createState() => VehicleInfoViewState();
}

class VehicleInfoViewState extends State<VehicleInfoView> {
  final db = FirebaseFirestore.instance;
  final usr = FirebaseAuth.instance;

  late Future<DocumentSnapshot<Map<String, dynamic>>> data =
      db.collection(COLLECTION_VEHICLES).doc(widget.docId).get();
  void reload() {
    setState(() {
      data = db.collection(COLLECTION_VEHICLES).doc(widget.docId).get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Vehicle vehicle = Vehicle.fromMap(snapshot.data!.data()!);
          return Scaffold(
            appBar: AppBar(
              title: Text("${vehicle.name} ${vehicle.model} ${vehicle.year}"),
            ),
            body: Column(
              children: [
                makeInfo("Name", vehicle.name),
                makeInfo("Model", vehicle.model),
                makeInfo("Year", "${vehicle.year}"),
                makeInfo("License Plate", vehicle.licensePlate),
                if (vehicle.refuelHistory.length >= 2)
                  Card(
                    margin: EdgeInsets.all(16),
                    elevation: 4,
                    color: Colors.orange,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Average Consumption",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "${calculateAvg(vehicle.refuelHistory.reversed.toList())} Km/L",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                Divider(
                  thickness: 2,
                  color: Colors.orange,
                ),
                Expanded(
                  child: ListView(
                    children: List.generate(
                      vehicle.refuelHistory.length + 1,
                      (index) {
                        if (index == 0) {
                          return AddRefuelTile(
                            parentState: this,
                            vehicle: vehicle,
                            docId: widget.docId,
                          );
                        } else {
                          return RefuelTile(
                              refuelHistoryItem: vehicle.refuelHistory.reversed
                                  .elementAt(index - 1));
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Widget makeInfo(name, field) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 16),
        ),
        Text(
          field,
          style: TextStyle(fontSize: 16),
        )
      ],
    ),
  );
}

double calculateAvg(List<RefuelHistoryItem> list) {
  return (list[0].kilometers - list[1].kilometers) / list[0].liters;
}
