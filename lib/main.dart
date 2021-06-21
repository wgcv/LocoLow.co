import 'package:flutter/material.dart';
import 'package:loco_low_co/screens/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_map_location_picker/generated/l10n.dart'
    as location_picker;
import 'package:google_map_location_picker/generated/l10n.dart';

void main() => runApp(
      MaterialApp(
        home: MyApp(),
        theme: ThemeData(fontFamily: 'Circular'),
        localizationsDelegates: const [
          location_picker.S.delegate,
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[
          Locale('en', ''),
          Locale('ar', ''),
          Locale('pt', ''),
          Locale('tr', ''),
          Locale('es', ''),
          Locale('it', ''),
          Locale('ru', ''),
        ],
        debugShowCheckedModeBanner: false,
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
