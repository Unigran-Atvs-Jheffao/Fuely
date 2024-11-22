import 'package:flutter/material.dart';
import 'package:trabalho_final/models/vehicle.dart';
import 'package:trabalho_final/views/add_refuel.dart';
import 'package:trabalho_final/views/vehicle_info.dart';

class AddRefuelTile extends StatelessWidget {
  final VehicleInfoViewState parentState;
  final Vehicle vehicle;
  final String docId;
  const AddRefuelTile(
      {super.key,
      required this.parentState,
      required this.vehicle,
      required this.docId});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.add),
      title: Text("Add Refuel"),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddRefuelView(
              vehicle: vehicle,
              documentId: docId,
            ),
          ),
        ).then(
          (value) {
            parentState.reload();
          },
        )
      },
    );
  }
}
