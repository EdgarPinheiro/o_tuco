import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'alarm.dart'; // Presumo que aqui tenhas a tua classe Alarme

class SetAlarmPage extends StatefulWidget {
  final Alarme? alarmeExistente;

  const SetAlarmPage({super.key, this.alarmeExistente});

  @override
  State<SetAlarmPage> createState() => _SetAlarmPageState();
}

class _SetAlarmPageState extends State<SetAlarmPage> {
  int selectedHour = 6;
  int selectedMinute = 30;
  List<DateTime> datasSelecionadas = [];

  @override
  void initState() {
    super.initState();
    if (widget.alarmeExistente != null) {
      selectedHour = widget.alarmeExistente!.hora;
      selectedMinute = widget.alarmeExistente!.minuto;
      datasSelecionadas = List.from(widget.alarmeExistente!.datas);
    }
  }

  Future<void> enviarAlarmeParaESP(
    int hora,
    int minuto,
    int dia,
    int mes,
    int ano,
  ) async {
    final url = Uri.parse('http://192.168.4.1/alarme');

    final Map<String, String> payload = {
      'hora': hora.toString(),
      'minuto': minuto.toString(),
      'dia': dia.toString(),
      'mes': mes.toString(),
      'ano': ano.toString(),
    };

    try {
      final response = await http.post(url, body: payload);

      if (response.statusCode == 200) {
        print('Alarme enviado com sucesso!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Alarme enviado com sucesso!')),
        );
      } else {
        print('Erro ao enviar alarme: ${response.statusCode}');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao enviar alarme')));
      }
    } catch (e) {
      print('Erro: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao conectar ao ESP32')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.orange, fontSize: 16),
                    ),
                  ),
                  const Text(
                    'Adicionar alarme',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (datasSelecionadas.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Por favor selecione pelo menos uma data.',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      for (var data in datasSelecionadas) {
                        await enviarAlarmeParaESP(
                          selectedHour,
                          selectedMinute,
                          data.day,
                          data.month,
                          data.year,
                        );
                      }

                      final novoAlarme = Alarme(
                        hora: selectedHour,
                        minuto: selectedMinute,
                        datas: datasSelecionadas,
                        ativo: widget.alarmeExistente?.ativo ?? true,
                      );

                      Navigator.pop(context, novoAlarme);
                    },
                    child: const Text(
                      'Guardar',
                      style: TextStyle(color: Colors.orange, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Time picker
            SizedBox(
              height: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: CupertinoPicker(
                      backgroundColor: Colors.black,
                      itemExtent: 40,
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedHour,
                      ),
                      onSelectedItemChanged: (int value) {
                        setState(() => selectedHour = value);
                      },
                      children: List.generate(
                        24,
                        (index) => Center(
                          child: Text(
                            index.toString().padLeft(2, '0'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 100,
                    child: CupertinoPicker(
                      backgroundColor: Colors.black,
                      itemExtent: 40,
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedMinute,
                      ),
                      onSelectedItemChanged: (int value) {
                        setState(() => selectedMinute = value);
                      },
                      children: List.generate(
                        60,
                        (index) => Center(
                          child: Text(
                            index.toString().padLeft(2, '0'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Botão de selecionar datas
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.black,
              ),
              onPressed: () async {
                DateTime hoje = DateTime.now();
                DateTime? novaData = await showDatePicker(
                  context: context,
                  initialDate: hoje,
                  firstDate: hoje,
                  lastDate: DateTime(2100),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.dark().copyWith(
                        colorScheme: const ColorScheme.dark(
                          primary: Colors.orange,
                          onPrimary: Colors.black,
                          surface: Colors.grey,
                          onSurface: Colors.white,
                        ),
                        dialogTheme: const DialogTheme(
                          backgroundColor: Colors.black,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (novaData != null && !datasSelecionadas.contains(novaData)) {
                  setState(() => datasSelecionadas.add(novaData));
                }
              },
              child: const Text('Selecionar data'),
            ),

            const SizedBox(height: 20),

            // Chips de datas
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  datasSelecionadas.map((data) {
                    return Chip(
                      backgroundColor: Colors.orange,
                      label: Text(
                        '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}',
                        style: const TextStyle(color: Colors.black),
                      ),
                      deleteIcon: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.black,
                      ),
                      onDeleted: () {
                        setState(() => datasSelecionadas.remove(data));
                      },
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
