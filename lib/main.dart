import 'package:flutter/material.dart';

// Função principal que inicia a aplicação Flutter
void main() {
  runApp(const MyApp()); // Executa a aplicação MyApp
}

// Classe principal da aplicação que estende StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove o banner de debug
      title: 'Aplicação Simples', // Define o título da aplicação
      theme: ThemeData(
        colorScheme:
            ColorScheme.dark(), // Define o tema escuro para a aplicação
      ),
      home: const SimpleHomePage(), // Define a página inicial da aplicação
    );
  }
}

// Classe que representa a página inicial da aplicação
class SimpleHomePage extends StatelessWidget {
  const SimpleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Página Inicial',
        ), // Define o título da barra superior
      ),
      body: Center(
        child: Row(
          mainAxisSize:
              MainAxisSize
                  .min, // Ajusta o tamanho da linha ao mínimo necessário
          mainAxisAlignment:
              MainAxisAlignment.center, // Centraliza os botões na tela
          children: [
            ElevatedButton(
              onPressed: () {}, // Ação do botão (atualmente vazia)
              child: const Text('jsdsjdvbsjdvbn'), // Texto exibido no botão
            ),
            const SizedBox(width: 20), // Espaçamento entre os botões
            ElevatedButton(
              onPressed: () {}, // Ação do botão (atualmente vazia)
              child: const Text('Led'), // Texto exibido no botão
            ),
          ],
        ),
      ),
    );
  }
}
