import 'package:demo_provider/ui/features/app.dart';
import 'package:demo_provider/ui/features/home/provider/home_provider.dart';
import 'package:demo_provider/ui/features/person/provider/person_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PersonProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
    ],
    child: const App()
  ));
}



