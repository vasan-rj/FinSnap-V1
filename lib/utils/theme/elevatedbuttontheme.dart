import 'package:flutter/material.dart';

class TElevatedButtonTheme{

  TElevatedButtonTheme._();

  static final darkElevatedButtomTheme=ElevatedButton.styleFrom(
    foregroundColor: Color.fromARGB(236, 242, 240, 242),
    backgroundColor:  Color.fromARGB(210, 5, 242, 155),
    side: const BorderSide(color:Color.fromARGB(103, 4, 217, 196)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
  );
}