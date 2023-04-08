import 'package:flutter/material.dart';
import 'package:recipes_app/network/api/recipeRequest.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(title: 'Recipes'),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});
  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
              decoration: InputDecoration(
            suffixIcon:
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          )),
        ));
  }
}
