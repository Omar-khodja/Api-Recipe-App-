import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:recipe_app/screen/home_page.dart';

final kcolorSchemedark = ColorScheme.fromSeed(
  seedColor: Colors.blueAccent,
  brightness: Brightness.dark,
);
final kcolorSchemelight = ColorScheme.fromSeed(
  seedColor: Colors.blueAccent,
  brightness: Brightness.light,
);
void setupLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint(
      '[${record.level.name}] '
      '${record.time.toIso8601String()} '
      '${record.loggerName}: '
      '${record.message}',
    );
  });
}

void main() {
  setupLogger();
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
      home: const HomePage(),
    );
  }
}
