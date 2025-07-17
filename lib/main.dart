import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/screen/homePage.dart';

final kcolorScheme = ColorScheme.fromSeed(
  seedColor: Colors.orange,
  brightness: Brightness.dark,
);
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.from(
        colorScheme: kcolorScheme,
        textTheme: GoogleFonts.montserratTextTheme().copyWith(
          titleLarge: TextStyle(color: kcolorScheme.onSurface),
          titleMedium: TextStyle(color: kcolorScheme.onSurface),
          titleSmall: TextStyle(color: kcolorScheme.onSurface),
        ),
      ).copyWith(
        appBarTheme: AppBarTheme(color: kcolorScheme.primaryContainer)
        
      ),
      home: const Homepage(),
    );
  }
}

