
import 'package:flutter/material.dart';

class BuildSearchbar extends StatefulWidget {
  const BuildSearchbar({super.key});

  @override
  State<BuildSearchbar> createState() => _BuildSearchbarState();
}

class _BuildSearchbarState extends State<BuildSearchbar> {
  @override
  Widget build(BuildContext context) {
    return _buildSearchBar();
    //  return TextField(
    //   decoration: InputDecoration(
    //     hintText: 'Search ATMs, Payments, Fines',
    //     hintStyle: TextStyle(color: Colors.white54),
    //     prefixIcon: Icon(Icons.search, color: Colors.white54),
    //     filled: true,
    //     fillColor: Color(0xFF1F1F1F),
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(10),
    //       borderSide: BorderSide.none,
    //     ),
    //     contentPadding: EdgeInsets.symmetric(horizontal: 20),
    //   ),
    //   style: TextStyle(color: Colors.white),
    // );
  }
}


Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search ATMs, Payments, Fines',
        hintStyle: TextStyle(color: Colors.white54),
        prefixIcon: Icon(Icons.search, color: Colors.white54),
        filled: true,
        fillColor: Color(0xFF1F1F1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
      ),
      style: TextStyle(color: Colors.white),
    );
  }


  