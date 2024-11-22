
class RefuelHistoryItem {
  final DateTime date;
  final int kilometers;
  final int liters;

  const RefuelHistoryItem({required this.date, required this.kilometers, required this.liters});

  factory RefuelHistoryItem.fromMap(Map<String, dynamic> map){
    return RefuelHistoryItem(
      date: map["date"],
      kilometers: map["kilometers"],
      liters: map["liters"]
    );
  }

   Map<String,dynamic> toMap(){
    return {
      "date": date,
      "kilometers": kilometers,
      "liters": liters
    };
   }
}

class Vehicle {
  final String name;
  final String owner;
  final String model;
  final int year;
  final String licensePlate;
  final List<RefuelHistoryItem> refuelHistory;

  const Vehicle({required this.name, required this.model, required this.year, required this.licensePlate, required this.refuelHistory, required this.owner});

  factory Vehicle.fromMap(Map<String, dynamic> data){
    return Vehicle(
      name: data["name"],
      model: data["model"],
      licensePlate: data["license_plate"],
      year: data['year'],
      owner: data["owner"],
      refuelHistory: (data['refuel_history'] as List).map((e) => RefuelHistoryItem.fromMap(e)).toList()
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "name": name,
      "model": model,
      "license_plate": licensePlate,
      "year": year,
      "owner": owner,
      "refuel_history": refuelHistory.map((e) => e.toMap()).toList()
    };
  }
}