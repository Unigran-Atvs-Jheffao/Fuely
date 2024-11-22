import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final/models/vehicle.dart';
import 'package:trabalho_final/state.dart';
import 'package:trabalho_final/utils/date_utils.dart';
import 'package:trabalho_final/views/add_refuel.dart';
import 'package:trabalho_final/views/vehicle_info.dart';

class RefuelTile extends StatelessWidget {
  final VehicleInfoViewState? parentState;
  final Vehicle vehicle;
  final String? docId;
  final RefuelHistoryItem refuelHistoryItem;
  final int idx;

  const RefuelTile(
      {super.key,
      required this.refuelHistoryItem,
      required this.vehicle,
      this.docId,
      this.parentState,
      required this.idx});

  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;
    return ListTile(
      isThreeLine: true,
      leading: Icon(
        Icons.local_gas_station,
        size: 40,
        color: Colors.orange,
      ),
      title: Text(
          "Refueled ${refuelHistoryItem.liters}L with ${refuelHistoryItem.kilometers}km"),
      subtitle: Text(formatDate(refuelHistoryItem.date.toDate())),
      trailing: docId != null
          ? Wrap(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.edit),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddRefuelView(
                          vehicle: vehicle,
                          documentId: docId!,
                          item: refuelHistoryItem,
                          idx: idx,
                        ),
                      ),
                    ).then((e) {
                      parentState!.reload();
                    });
                  },
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.delete),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(
                              "Are you sure you want to remove the refuel for '${vehicle.name} ${vehicle.year}'?"),
                          title: Text("Delete ?"),
                          actions: [
                            FilledButton(
                              onPressed: () {
                                vehicle.refuelHistory.removeAt(idx);

                                db
                                    .collection(COLLECTION_VEHICLES)
                                    .doc(docId)
                                    .update(vehicle.toMap())
                                    .then(
                                  (e) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Deleted refuel for '${vehicle.name} ${vehicle.year}'")));
                                    parentState!.reload();
                                  },
                                );
                              },
                              child: Text("Yes"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("No"),
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            )
          : null,
    );
  }
}
