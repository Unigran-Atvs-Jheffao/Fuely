import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final/components/refuel_tile.dart';
import 'package:trabalho_final/models/vehicle.dart';
import 'package:trabalho_final/state.dart';

class RefuelHistoryView extends StatefulWidget {
  const RefuelHistoryView({super.key});

  @override
  State<RefuelHistoryView> createState() => _RefuelHistoryViewState();
}

class _RefuelHistoryViewState extends State<RefuelHistoryView> {
  final db = FirebaseFirestore.instance;
  final usr = FirebaseAuth.instance;

  late Future<QuerySnapshot<Map<String, dynamic>>> data = db
      .collection(COLLECTION_VEHICLES)
      .where("owner", isEqualTo: usr.currentUser!.uid)
      .get();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Vehicle> finalData = snapshot.data!.docs
              .map((e) => Vehicle.fromMap(e.data()))
              .toList();

          return ListView(
            children: List.generate(
              finalData.length,
              (vehIdx) {
                return Column(
                  children: List.generate(
                    finalData[vehIdx].refuelHistory.length + 1,
                    (index) {
                      if (index == 0) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Text(
                                "${finalData[vehIdx].name} ${finalData[vehIdx].model} ${finalData[vehIdx].year}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.orange,
                              thickness: 2,
                            )
                          ],
                        );
                      } else {
                        return RefuelTile(
                          idx: index-1,
                          vehicle: finalData[vehIdx],
                          refuelHistoryItem:
                              finalData[vehIdx].refuelHistory.toList()[index - 1],
                        );
                      }
                    },
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
