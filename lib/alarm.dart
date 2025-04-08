import 'package:flutter/material.dart';
import 'setalarm.dart';

class Alarme {
  int hora;
  int minuto;
  List<DateTime> datas;
  bool ativo;

  Alarme({
    required this.hora,
    required this.minuto,
    required this.datas,
    this.ativo = true, // valor padrão para evitar null
  });
}

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  List<Alarme> alarmes = [];

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
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.reply, color: Colors.orange),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final resultado = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SetAlarmPage()),
              );

              if (resultado != null && resultado is Alarme) {
                setState(() {
                  alarmes.add(
                    Alarme(
                      hora: resultado.hora,
                      minuto: resultado.minuto,
                      datas: resultado.datas,
                      ativo: resultado.ativo, // garante bool válido
                    ),
                  );
                });
              }
            },
            icon: const Icon(Icons.add, color: Colors.orange),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body:
          alarmes.isEmpty
              ? const Center(
                child: Text(
                  'Nenhum alarme adicionado',
                  style: TextStyle(color: Colors.white),
                ),
              )
              : ListView.builder(
                itemCount: alarmes.length,
                itemBuilder: (context, index) {
                  final alarme = alarmes[index];
                  final hora = alarme.hora.toString().padLeft(2, '0');
                  final minuto = alarme.minuto.toString().padLeft(2, '0');

                  return Card(
                    color: Colors.grey[900],
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    child: ListTile(
                      title: Text(
                        '$hora:$minuto',
                        style: TextStyle(
                          fontSize: 24,
                          color: alarme.ativo ? Colors.white : Colors.grey,
                          // Removido o riscado aqui
                        ),
                      ),

                      subtitle: Text(
                        alarme.datas
                            .map(
                              (d) =>
                                  '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}',
                            )
                            .join(', '),
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.orange),
                            tooltip: 'Editar',
                            onPressed: () {
                              // lógica de edição aqui (ainda não implementada)
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            tooltip: 'Eliminar',
                            onPressed: () {
                              _mostrarDialogoDeConfirmacao(index);
                            },
                          ),
                          Switch(
                            value: alarme.ativo,
                            onChanged: (bool value) {
                              setState(() {
                                alarme.ativo = value;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }

  void _mostrarDialogoDeConfirmacao(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            'Confirmar eliminação',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Tem certeza que deseja eliminar este alarme?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  alarmes.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
