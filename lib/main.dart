import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:recipe_app/screen/home_page.dart';

final kcolorScheme = ColorScheme.fromSeed(
  seedColor:  Colors.blueGrey,
  brightness: Brightness.dark,
);
void main() {
   Logger.root.level = Level.ALL; // Show all logs
  Logger.root.onRecord.listen((record) {
    Logger(
      '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}',
    );
  });
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

