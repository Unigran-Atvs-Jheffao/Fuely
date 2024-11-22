import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final/models/vehicle.dart';
import 'package:trabalho_final/state.dart';
import 'package:trabalho_final/utils/date_utils.dart';
import 'package:trabalho_final/views/add_vehicle.dart';
import 'package:trabalho_final/views/my_vehicles.dart';
import 'package:trabalho_final/views/vehicle_info.dart';

class RefuelTile extends StatelessWidget {
  final RefuelHistoryItem refuelHistoryItem;
  
  const RefuelTile(
      {super.key,
      required this.refuelHistoryItem});

  @override
  Widget build(BuildContext context) {

    return ListTile(
      onTap: () {
        
      },
      isThreeLine: true,
      leading: Icon(
        Icons.local_gas_station,
        size: 40,
        color: Colors.orange,
      ),
      title: Text("Refueled ${refuelHistoryItem.liters}L with ${refuelHistoryItem.kilometers}km"),
      subtitle: Text(formatDate(refuelHistoryItem.date.toDate())),
    );
  }
}
