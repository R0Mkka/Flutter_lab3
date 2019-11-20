import 'package:flutter/material.dart';
import 'package:lab3_2/database.dart';

import './models/user.dart';

class UserList extends StatelessWidget {
  final List<User> _userList;

  final Function _onUserDelete;

  UserList(this._userList, this._onUserDelete);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        alignment: Alignment(0.0, -0.8),
        width: double.infinity,
        height: 240,
        padding: EdgeInsets.all(10),
        child: (_userList == null || _userList.isEmpty)
            ? Text('List is empty')
            : ListView(
                children: _userList.map((User user) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Name: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(user.name),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'age: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(user.age.toString()),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'sex: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(user.sex ? 'male' : 'female'),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              await deleteUser(user.id);

                              _onUserDelete(user.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
