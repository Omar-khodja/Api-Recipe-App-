import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/navigator_screen.dart';


final kcolorSchemelight = ColorScheme.fromSeed(
  seedColor: const Color.fromRGBO(255, 245, 203, 1),
  primary: const Color.fromRGBO(255, 245, 203, 1),
  onPrimary: const Color(0xFF3B3B1F),
  secondary: const Color(0xFF9CAF88),
  tertiary: const Color(0xFFEFFFCB),
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
              titleLarge: TextStyle(color: kcolorSchemelight.onSurface),
              titleMedium: TextStyle(color: kcolorSchemelight.onSurface),
              titleSmall: TextStyle(color: kcolorSchemelight.onSurface),
            ),
          ).copyWith(
            appBarTheme: AppBarTheme(
              backgroundColor: kcolorSchemelight.secondary,
              foregroundColor: kcolorSchemelight.onSecondary,
            ),
            scaffoldBackgroundColor: kcolorSchemelight.surface,
            brightness: Brightness.light,

            iconTheme: IconThemeData(color: kcolorSchemelight.onInverseSurface),
          ),
   
      home: const NavigatorScreen(),
    );
  }
}
