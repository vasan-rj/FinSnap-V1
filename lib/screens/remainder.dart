import 'package:flutter/material.dart';

class remainderPage extends StatefulWidget {
  const remainderPage({super.key});

  @override
  State<remainderPage> createState() => _remainderPageState();
}

class _remainderPageState extends State<remainderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
                child: SizedBox(
                  child:Text('Custom Remainder', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
              ),
        backgroundColor: Colors.black87,
      ),
      body: Text(
        "Hi Hello"
      ),
    );
  }
}