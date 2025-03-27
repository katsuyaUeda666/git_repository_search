import 'package:flutter/material.dart';
import 'package:git_repository_search/pages/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Search',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: homePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
