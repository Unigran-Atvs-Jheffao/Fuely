import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trabalho_final/models/vehicle.dart';
import 'package:trabalho_final/state.dart';

class AddRefuelView extends StatefulWidget {
  final Vehicle vehicle;
  final String? documentId;
  const AddRefuelView({super.key, required this.vehicle, this.documentId});

  @override
  State<AddRefuelView> createState() => _AddRefuelViewState();
}

class _AddRefuelViewState extends State<AddRefuelView> {
  var litersController = TextEditingController();
  var kmsController = TextEditingController();

  var db = FirebaseFirestore.instance;

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
                    controller: litersController,
                    decoration: InputDecoration(
                      hintText: "Liters Refueled",
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(10),
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
                    controller: kmsController,
                    decoration: InputDecoration(
                      hintText: "Current Kilometers",
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(20),
                    ],
                    keyboardType: TextInputType.numberWithOptions(),
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    widget.vehicle.refuelHistory.add(
                      RefuelHistoryItem(
                          date: Timestamp.now(),
                          kilometers:
                              int.parse(kmsController.value.text, radix: 10),
                          liters: int.parse(litersController.value.text,
                              radix: 10)),
                    );

                    db
                        .collection(COLLECTION_VEHICLES)
                        .doc(widget.documentId)
                        .update(widget.vehicle.toMap())
                        .then(
                      (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Created refuel for '${widget.vehicle.name}'",
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      },
                    );
                  },
                  child: Text("Add Refuel"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
