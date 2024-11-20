import 'package:flutter/material.dart';
import 'package:trabalho_final/views/add_vehicle.dart';

class MyVehiclesView extends StatelessWidget {
  const MyVehiclesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          leading: const Icon(Icons.add),
          title: const Text("Adicionar Veiculo"),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddVehicle()));
          },
        ),
      ],
    );
  }
}