import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/screen/navigator_screen.dart';

final kcolorSchemedark = ColorScheme.fromSeed(
  seedColor: Colors.blueAccent,
  brightness: Brightness.dark,
);
final kcolorSchemelight = ColorScheme.fromSeed(
  seedColor: Colors.blueAccent,
  brightness: Brightness.light,
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
      theme:
          ThemeData.from(
            colorScheme: kcolorSchemelight,
            
            textTheme: GoogleFonts.ralewayTextTheme().copyWith(
              titleLarge: TextStyle(color: kcolorSchemelight.onInverseSurface),
              titleMedium: TextStyle(color: kcolorSchemelight.onSurface),
              
              
            ),
          ).copyWith(
            appBarTheme: AppBarTheme(color: kcolorSchemelight.primary),
            scaffoldBackgroundColor: kcolorSchemelight.surface,
            brightness: Brightness.light,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: kcolorSchemelight.primary,
              selectedItemColor: Colors.greenAccent,
            ),
            iconTheme: IconThemeData(
              color: kcolorSchemelight.onInverseSurface,
          ),
          

          ),
      darkTheme:
          ThemeData.from(
            colorScheme: kcolorSchemedark,
            textTheme: GoogleFonts.montserratTextTheme().copyWith(
              titleLarge: TextStyle(color: kcolorSchemedark.onSurface),
              titleMedium: TextStyle(color: kcolorSchemedark.onSurface),
              titleSmall: TextStyle(color: kcolorSchemedark.onSurface),
            ),
          ).copyWith(
            appBarTheme: AppBarTheme(color: kcolorSchemedark.primaryContainer),
            brightness: Brightness.light,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: kcolorSchemedark.primaryContainer,
              selectedItemColor: Colors.green,
            ),
          ),
      themeMode: ThemeMode.system,
      home: const NavigatorScreen(),
    );
  }
}
