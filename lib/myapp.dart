import 'package:flutter/material.dart';
import 'package:flutter_app/myhomepgae.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'David Lino',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'David Eduardo Lino'),
    );
  }
}