import 'package:flutter/material.dart';

import './new-user-panel.dart';
import './user-list.dart';

import './database.dart';
import './models/user.dart';

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  List<User> _users;

  void _onUserAdd(User newUser) {
    if (_users == null) {
      _users = [];
    }
    
    setState(() => _users.add(newUser));
  }

  void _onUserDelete(int userId) {
    setState(() => _users.removeWhere((User user) => user.id == userId));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getUserList(),
        builder: (context, snapshot) {
          _users = snapshot.data;

          return Column(
            children: <Widget>[
              NewUserPanel(_onUserAdd),
              UserList(_users, _onUserDelete),
            ],
          );
        },
      ),
    );
  }
}
