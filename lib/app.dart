import 'package:flutter/material.dart';
import 'package:module12_extra_class2/product_list_screen.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: ProductListScreen(),
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      themeMode: ThemeMode.system,
    );
  }
}

ThemeData _lightTheme(){
  return ThemeData(
    brightness: Brightness.light,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(double.maxFinite),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.pinkAccent
          )
      ),

      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pinkAccent)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pinkAccent)
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)
          )
      )
  );
}

ThemeData _darkTheme(){
  return ThemeData(
    brightness: Brightness.dark,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(double.maxFinite),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.pinkAccent
          )
      ),

      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pinkAccent)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pinkAccent)
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)
          )
      )
  );
}