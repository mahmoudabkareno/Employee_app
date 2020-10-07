import 'package:campany/Model/Employee.dart';
import 'package:campany/UI/employee_Screen.dart';
import 'package:campany/Utils/DataBase_Helper.dart';
import 'package:flutter/material.dart';

class ListViewEmployee extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ListViewEmployeeState();
  }
}

class _ListViewEmployeeState extends State<ListViewEmployee> {
  List<Employee> item = new List();
  DataBaseHelper db = new DataBaseHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db.getAllEmployees().then((employees) {
      setState(() {
        employees.forEach((element) {
          item.add(Employee.fromMap(element));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: 'Company app',
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Employees'),
            backgroundColor: Colors.cyan,
          ),
          backgroundColor: Colors.cyanAccent,
          body: new Center(
            child: new ListView.builder(
                itemCount: item.length,
                padding: EdgeInsets.all(19.0),
                itemBuilder: (context, position) {
                  return new Column(
                    children: <Widget>[
                      Divider(
                        height: 5.0,
                      ),
                      ListTile(
                        title: Text(
                          '${item[position].name}',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.black),
                        ),
                        subtitle: Text(
                          '${item[position].city} / ${item[position].age}',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontStyle: FontStyle.italic),
                        ),
                        leading: new Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(7.0)),
                            CircleAvatar(
                              backgroundColor: Colors.amber,
                              child: Text(
                                '${item[position].id}',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              radius: 16.0,
                            ),
                            IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () => _deleteEmployee(
                                    context, item[position], position))
                          ],
                        ),
                        onTap: () =>
                            _navigateToEmployee(context, item[position]),
                      )
                    ],
                  );
                }),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            onPressed: () => _createNewEmploee(context),
          ),
        ));
  }

  _deleteEmployee(BuildContext context, Employee employee, int position) {
    db.deleteEmployee(employee.id).then((employees) {
      setState(() {
        item.removeAt(position);
      });
    });
  }

  void _navigateToEmployee(BuildContext context, Employee employee) async {
    String result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => EmpScreen(employee)));
    if (result == 'update') {
      db.getAllEmployees().then((employees) {
        setState(() {
          item.clear();
          employees.forEach((employee) {
            item.add(Employee.fromMap(employee));
          });
        });
      });
    }
  }

  void _createNewEmploee(BuildContext context) async {
    String result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EmpScreen(Employee('', '', '', '', ''))));
    if (result == 'Store') {
      db.getAllEmployees().then((employees) {
        setState(() {
          item.clear();
          employees.forEach((employee) {
            item.add(Employee.fromMap(employee));
          });
        });
      });
    }
  }
}
