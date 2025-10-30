import 'package:flutter/material.dart';
import 'features/exercises/screens/exercises_container.dart';
import 'core/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Справочник упражнений',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const ExercisesContainer(),
    );
  }
}
