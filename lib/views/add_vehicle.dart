import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trabalho_final/models/vehicle.dart';
import 'package:trabalho_final/state.dart';


class AddVehicle extends StatefulWidget {
  final Vehicle? toEdit;
  final String? documentId;
  const AddVehicle({super.key, this.toEdit, this.documentId});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  var nameController = TextEditingController();
  var modelController = TextEditingController();
  var yearController = TextEditingController();
  var plateController = TextEditingController();

  var db = FirebaseFirestore.instance;
  var usr = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    if (widget.toEdit != null) {
      nameController = TextEditingController(text: widget.toEdit!.name);
      modelController = TextEditingController(text: widget.toEdit!.model);
      yearController = TextEditingController(text: "${widget.toEdit!.year}");
      plateController =
          TextEditingController(text: widget.toEdit!.licensePlate);
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fuely"),
      ),
      body: Center(
        child: Form(
          child: Padding(
            key: _formKey,
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Name",
                    ),
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: modelController,
                    decoration: InputDecoration(
                      hintText: "Model",
                    ),
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: yearController,
                    decoration: InputDecoration(
                      hintText: "Year",
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(4),
                    ],
                    keyboardType: TextInputType.numberWithOptions(),
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: plateController,
                    decoration: InputDecoration(
                      hintText: "License Plate",
                    ),
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    var vehicle = Vehicle(
                        name: nameController.value.text,
                        model: modelController.value.text,
                        year: int.parse(yearController.value.text, radix: 10),
                        licensePlate: plateController.value.text,
                        refuelHistory: List.empty(),
                        owner: usr.uid);
                    if (widget.toEdit != null) {
                      db
                          .collection(COLLECTION_VEHICLES)
                          .doc(widget.documentId)
                          .update(vehicle.toMap())
                          .then(
                        (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Vehicle '${nameController.value.text}' was updated!")));
                          Navigator.pop(context);
                        },
                      );
                    } else {
                      db
                          .collection(COLLECTION_VEHICLES)
                          .add(vehicle.toMap())
                          .then(
                        (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Vehicle '${nameController.value.text}' was added!")));
                          Navigator.pop(context);
                        },
                      );
                    }
                  },
                  child: Text(widget.toEdit != null ? "Edit" : "Add"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
