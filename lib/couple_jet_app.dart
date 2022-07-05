import 'package:couple_jet/ui/screens/onboard_screen/onboard_screen.dart';
import 'package:couple_jet/utils/themes.dart';
import 'package:flutter/material.dart';

class CoupleJetApp extends StatelessWidget {
  const CoupleJetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoupleJet',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const OnboardScreen(),
    );
  }
}
