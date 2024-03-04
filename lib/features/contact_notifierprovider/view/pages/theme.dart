import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dark Mode Example',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.indigo,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.teal),
      ),
      themeMode: _themeMode,
      home: MyHomePage(toggleTheme: toggleTheme),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final VoidCallback toggleTheme;

  const MyHomePage({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Dark Mode Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'This is a headline',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 20.0),
            Text(
              'This is body text',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: toggleTheme,
              child: const Text('Toggle Dark Mode'),
            ),
          ],
        ),
      ),
    );
  }
}
