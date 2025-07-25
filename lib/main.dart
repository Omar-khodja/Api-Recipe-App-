import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:recipe_app/screen/home_page.dart';

final kcolorScheme = ColorScheme.fromSeed(
  seedColor:  Colors.green,
  brightness: Brightness.dark,
);
void setupLogger() {
  Logger.root.level = Level.ALL; // Log everything (use Level.INFO for release)
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
      home: const HomePage(),
    );
  }
}

