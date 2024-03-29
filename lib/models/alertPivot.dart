import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vbs_alerte/models/alert.dart';
import 'package:vbs_alerte/models/employee.dart';
 
 

class AlertPivot {
  final Alert alert;
  final Employee employee;
  final int? employeeAlertId;

  AlertPivot({
    required this.alert,
    required this.employee,
     this.employeeAlertId,
  });

  factory AlertPivot.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return AlertPivot(
      alert: Alert.fromMap(data['alert']),
      employee: Employee.fromMap(data['employee']),
      employeeAlertId: data['employeeAlertId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alert': alert.toMap(),
      'employee': employee.toMap(),
      'employeeAlertId': employeeAlertId,
    };
  }
}
