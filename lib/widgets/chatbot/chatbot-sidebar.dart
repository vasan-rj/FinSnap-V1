// app_drawer.dart

import 'package:flutter/material.dart';
import 'package:finsnap/screens/chatbot.dart';

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
                Row(
                  children: [
                    SizedBox(width: 8),
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.settings,
                      size: 25,
                      color: Colors.white,
                    ),
                  ],
                ),
                // SizedBox(height: 16),
                // Text(
                //   'Settings',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 24,
                //   ),
                // ),
                Divider(),
              ],
            ),
          ),
          
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Update & FAQ'),
            onTap: () {
             Navigator.pushNamed(context,'/updates-faq');

            },
          ),
         
          ListTile(
            leading: Icon(Icons.upgrade),
            title: Text('Contact-Us'),
            onTap: () {
                Navigator.pushNamed(context,'/contact-us');
            },
          ),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
           signout();

            },
          ),



        ],
      ),
    );
  }
}
