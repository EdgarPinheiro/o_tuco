import 'package:flutter/material.dart';
import 'setalarm.dart'; // <-- Importando a nova página

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Alarme',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Voltar para a página anterior
          },
          icon: const Icon(Icons.reply, color: Colors.orange),
          tooltip: 'Voltar',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SetAlarmPage()),
              );
            },
            icon: const Icon(Icons.add, color: Colors.orange),
          ),
        ],
      ),
      body: const Center(child: Text('Lista de alarmes aparecerá aqui')),
    );
  }
}
