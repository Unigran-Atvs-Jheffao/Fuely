import 'package:flutter/material.dart';

class VehicleTile extends StatelessWidget {
  const VehicleTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Text("10km/L"),
      leading: Icon(Icons.directions_car),
      title: Text("Corsa 2003/2004 1.0 Gasolina"),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item foda")));
      },
    );
  }
}