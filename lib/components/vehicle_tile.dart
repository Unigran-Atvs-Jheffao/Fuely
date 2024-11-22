import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final/models/vehicle.dart';
import 'package:trabalho_final/state.dart';
import 'package:trabalho_final/views/add_vehicle.dart';
import 'package:trabalho_final/views/my_vehicles.dart';
import 'package:trabalho_final/views/vehicle_info.dart';

class VehicleTile extends StatelessWidget {
  final Vehicle vehicle;
  final String documentId;
  final MyVehiclesViewState parentState;
  const VehicleTile(
      {super.key,
      required this.vehicle,
      required this.documentId,
      required this.parentState});

  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;

    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VehicleInfoView(docId: documentId),
          ),
        );
      },
      isThreeLine: true,
      leading: Icon(
        Icons.directions_car,
        size: 40,
        color: Colors.orange,
      ),
      title: Text("${vehicle.name}"),
      subtitle: Text("${vehicle.model} ${vehicle.year}"),
      trailing: Wrap(
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
                  builder: (context) => AddVehicle(
                    toEdit: vehicle,
                    documentId: documentId,
                  ),
                ),
              ).then((e) => {parentState.reload()});
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
                        "Are you sure you want to remove the vehicle '${vehicle.name} ${vehicle.year}'?"),
                    title: Text("Delete ?"),
                    actions: [
                      FilledButton(
                        onPressed: () {
                          db
                              .collection(COLLECTION_VEHICLES)
                              .doc(documentId)
                              .delete()
                              .then(
                            (e) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Deleted vehicle '${vehicle.name} ${vehicle.year}'")));
                              parentState.reload();
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
      ),
    );
  }
}
