import 'package:flutter/material.dart';
import 'alarm.dart';
import 'led.dart'; // Adicione esta linha

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplicação',
      theme: ThemeData(colorScheme: ColorScheme.light()),
      home: const SimpleHomePage(),
    );
  }
}

class SimpleHomePage extends StatelessWidget {
  const SimpleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página Inicial')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AlarmPage()),
                );
              },
              child: const Text('Alarme'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LedPage()),
                );
              },
              child: const Text('Leds'),
            ),
          ],
        ),
      ),
    );
  }
}
