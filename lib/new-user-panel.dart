import 'package:flutter/material.dart';

import './database.dart';
import './models/user.dart';

class NewUserPanel extends StatefulWidget {
  final Function _onUserAdd;

  NewUserPanel(this._onUserAdd);

  @override
  _NewUserPanelState createState() => _NewUserPanelState();
}

class _NewUserPanelState extends State<NewUserPanel> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  bool _radioGroupValue = true;

  void _onRadioValueChange(Object value) {
    setState(() => _radioGroupValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Text(
            'Add new user',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Name',
          ),
          controller: _nameController,
        ),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Age',
          ),
          controller: _ageController,
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Male'),
              Radio(
                value: true,
                groupValue: _radioGroupValue,
                onChanged: _onRadioValueChange,
              ),
              
              Text('Female'),
              Radio(
                value: false,
                groupValue: _radioGroupValue,
                onChanged: _onRadioValueChange,
              ),
            ],
          ),
        ),
        Container(
          width: 100,
          margin: EdgeInsets.symmetric(vertical: 20),
          child: RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Add'),
                Icon(Icons.add),
              ],
            ),
            onPressed: () {
              if (_nameController.text.length < 1
                  || int.tryParse(_ageController.text) == null) {
                return;
              }

              User user = User(
                id: DateTime.now().millisecondsSinceEpoch,
                name: _nameController.text,
                age: int.parse(_ageController.text),
                sex: _radioGroupValue,
              );

              widget._onUserAdd(user);

              insertUser(user);
            },
          ),
        ),
      ],
    );
  }
}
