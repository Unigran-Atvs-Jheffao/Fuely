import 'package:flutter/material.dart';
import 'package:trabalho_final/views/add_vehicle.dart';
import 'package:trabalho_final/views/my_vehicles.dart';

class AddVehicleTile extends StatelessWidget {
  final MyVehiclesViewState parentState;
  const AddVehicleTile({super.key, required this.parentState});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.add),
      title: Text("Adicionar Veiculo"),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddVehicle(),
          ),
        ).then((e) => {parentState.reload()}),
      },
    );
  }
}
