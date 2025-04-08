import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'alarm.dart'; // Para acessar a classe Alarme

class SetAlarmPage extends StatefulWidget {
  const SetAlarmPage({super.key});

  @override
  State<SetAlarmPage> createState() => _SetAlarmPageState();
}

class _SetAlarmPageState extends State<SetAlarmPage> {
  int selectedHour = 6;
  int selectedMinute = 30;
  List<DateTime> datasSelecionadas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
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
                    onPressed: () {
                      final novoAlarme = Alarme(
                        hora: selectedHour,
                        minuto: selectedMinute,
                        datas: datasSelecionadas,
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.black,
              ),
              onPressed: () async {
                DateTime hoje = DateTime.now();
                DateTime dataLimiteInferior = DateTime(
                  hoje.year,
                  hoje.month,
                  hoje.day,
                );

                DateTime? novaData = await showDatePicker(
                  context: context,
                  initialDate: dataLimiteInferior,
                  firstDate: dataLimiteInferior,
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
