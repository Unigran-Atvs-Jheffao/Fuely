import 'package:flutter/material.dart';
import 'package:trabalho_final/components/vehicle_tile.dart';
import 'package:trabalho_final/views/add_vehicle.dart';

class MyVehiclesView extends StatelessWidget {
  const MyVehiclesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        10,
        (index) {
          if (index == 0) {
            return ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              leading: const Icon(Icons.add),
              title: const Text("Adicionar Veiculo"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddVehicle()));
              },
            );
          } else {
             return  const VehicleTile();
          }
        },
      ),
    );
  }
}
