// app_drawer.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black87,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(188, 51, 51, 51),
            ),
            child: Column(
              children: [
                Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Divider(),
              ],
            ),
            
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('New chat'),
            onTap: () {
              // Handle new chat action
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.delete),
          //   title: Text('Clear conversation'),
          //   onTap: () {
          //     // Handle clear conversation action
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.favorite),
          //   title: Text('Favorites'),
          //   onTap: () {
          //     // Handle favorites action
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              // Handle profile action
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Update & FAQ'),
            onTap: () {
              // Handle update & FAQ action
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.nightlight_round),
          //   title: Text('Dark mode'),
          //   onTap: () {
          //     // Handle dark mode action
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.upgrade),
            title: Text('Contact-Us'),
            onTap: () {
              // Handle upgrade action
            },
          ),
        ],
      ),
    );
  }
}
