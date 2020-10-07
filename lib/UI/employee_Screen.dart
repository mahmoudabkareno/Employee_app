import 'package:campany/Model/Employee.dart';
import 'package:campany/Utils/DataBase_Helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmpScreen extends StatefulWidget {
  final Employee employee;
  EmpScreen(this.employee);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new EmpScreenState();
  }
}

class EmpScreenState extends State<EmpScreen> {
  DataBaseHelper db = new DataBaseHelper();
  TextEditingController _ageController;
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  TextEditingController _departmrmentController;
  TextEditingController _cityController;
  @override
  void initState() {
    // TODO: implement initState
    _ageController = new TextEditingController(text: widget.employee.age);
     _nameController = new TextEditingController(text: widget.employee.name);
     _descriptionController = new TextEditingController(text: widget.employee.description);
     _departmrmentController = new TextEditingController(text: widget.employee.department);
     _cityController = new TextEditingController(text: widget.employee.city);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
        title: new Text('Employees'),
    backgroundColor: Colors.cyan,
    ),
    backgroundColor: Colors.cyanAccent,
    body: new Container(
      margin: EdgeInsets.all(17.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new TextField(
            controller: _nameController,
            decoration: InputDecoration(
                hintText: 'name'
            ),
          ),
          Padding(padding: EdgeInsets.all(7.0)),
          new TextField(
            controller: _ageController,
            decoration: InputDecoration(
              hintText: 'age'
            ),
          ),
          Padding(padding: EdgeInsets.all(7.0)),
          new TextField(
            controller: _cityController,
            decoration: InputDecoration(
                hintText: 'City'
            ),
          ),
          Padding(padding: EdgeInsets.all(7.0)),
          new TextField(
            controller: _departmrmentController,
            decoration: InputDecoration(
                hintText: 'Department'
            ),
          ),
          Padding(padding: EdgeInsets.all(7.0)),
          new TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
                hintText: 'description'
            ),
          ),
          Padding(padding: EdgeInsets.all(7.0)),
          RaisedButton(
              child: (widget.employee.id != null) ? Text('Update') : Text('Store'),
              color: Colors.lightGreen,
              onPressed: (){
                if(widget.employee.id != null){
                  db.updateEmployee(Employee.fromMap({
                    'id' : widget.employee.id,
                    'name' : _nameController.text,
                    'age' : _ageController.text,
                    'department' : _departmrmentController.text,
                    'city' : _cityController.text,
                    'description' : _descriptionController.text,
                  })).then((value){
                    Navigator.pop(context , 'update');
                  });
                }else{
                  db.saveEmployee(Employee(_nameController.text,
                      _ageController.text,
                      _departmrmentController.text,
                      _cityController.text,
                      _descriptionController.text)).then((value){
                        Navigator.pop(context , 'save');
                  });
                }
              })
        ],
      ),
    ),
    );
  }
}
