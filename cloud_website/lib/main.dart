import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'bloc_observer.dart';
import 'dio_helper.dart';
import 'screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Screen(),
      theme: ThemeData.dark(),
    );
  }
}


