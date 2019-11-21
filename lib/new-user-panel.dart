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

  void _onClear() {
    setState(() {
      _nameController.text = '';
      _ageController.text = '';
      _radioGroupValue = true;
    });
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
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Name',
          ),
          controller: _nameController,
        ),
        TextFormField(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                  if (_nameController.text.length < 1 ||
                      int.tryParse(_ageController.text) == null) {
                    _nameController.

                    return;
                  }

                  User user = User(
                    id: DateTime.now().millisecondsSinceEpoch,
                    name: _nameController.text,
                    age: int.parse(_ageController.text),
                    sex: _radioGroupValue,
                  );

                  widget._onUserAdd(user);

                  _onClear();

                  insertUser(user);
                },
              ),
            ),
            Container(
              width: 100,
              margin: EdgeInsets.only(
                left: 10,
              ),
              child: RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Clear'),
                    Icon(Icons.clear),
                  ],
                ),
                onPressed: () => _onClear,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
