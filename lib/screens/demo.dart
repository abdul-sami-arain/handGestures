import 'package:flutter/material.dart';
import 'package:handgesture/provider/provider.dart';
import 'package:handgesture/utils/underlinedLabel.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AdminData extends StatelessWidget {
   AdminData({super.key});
List<GridColumn> columns = [
  GridColumn(
    columnName: 'Serial No', 
    label: Text("Serial No")
  
  ),
  GridColumn(
    columnName: 'Name', 
    label: Text("name")
  
  ),
  GridColumn(
    columnName: 'Profile', 
    label: Text("Profile")
  
  ),
];

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    return Scaffold(
      body:
        DataTable(
      columns: [
        DataColumn(
        label: Text("Serial No"),
     ),
     DataColumn(
        label: Text("Name"),
       ),
        DataColumn(
        label: Text("Profile"),
       ),
      ],
      rows:provider.emp.map(
        (e) => DataRow(cells: [
           DataCell(
                      Text(e.Serial.toString()),
                    ),
                    DataCell(
                      Text(e.name.toString()),
                    ),
                    DataCell(
                      UnderlineLabels(label: e.profile, color: Colors.blue, size: 10, weight: FontWeight.bold, align: TextAlign.justify),
                    ),
        ])
        ).toList()
    )
    );
  }
}
class Employee {
  /// Creates the employee class with required details.
  Employee(this.Serial, this.name, this.profile);

  /// Id of an employee.
  final int Serial;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String profile;


}

