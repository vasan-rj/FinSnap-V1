import 'package:flutter/material.dart';
// import 'package:finsnap/utils/theme/elevatedbuttontheme.dart';
// TexTheme
class TTextTheme
{
  TTextTheme._();
  static  TextTheme darktextTheme= const TextTheme(
    headlineLarge: TextStyle(fontSize: 32.0,fontWeight: FontWeight.bold,color: Color.fromARGB(209, 242, 242, 242))

    // useMaterial3: true,
    // brightness: Brightness.light,
    // primaryColor: ,
    // scaffoldBackgroundColor: Color.fromARGB(210, 5, 242, 155),
    // textTheme: TTextTheme.

  );

}

// App theme......

class TAppTheme{
  TAppTheme._();
   
  static  ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(210, 5, 242, 155),
    scaffoldBackgroundColor: const Color.fromARGB(72, 0, 1, 13),
    textTheme: TTextTheme.darktextTheme,
   
    // elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtomTheme,
    // #00010D
  );
  
  static  ThemeData lighTheme = ThemeData();

}