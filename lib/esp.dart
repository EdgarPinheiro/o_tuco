import 'dart:convert';
import 'package:http/http.dart' as http;
import 'global.dart';

Future<void> enviarAlarmeParaESP() async {
  if (alarmeGlobal == null) return;

  final url = Uri.parse('http://192.168.4.1/alarme');

  // Supondo que vamos enviar o primeiro alarme da lista de datas
  final data = alarmeGlobal!.datas.first;

  final jsonBody = {
    "hora": alarmeGlobal!.hora,
    "minuto": alarmeGlobal!.minuto,
    "dia": data.day,
    "mes": data.month,
    "ano": data.year,
  };

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(jsonBody),
    );

    if (response.statusCode == 200) {
      print('Alarme enviado com sucesso!');
    } else {
      print('Erro ao enviar alarme: ${response.statusCode}');
    }
  } catch (e) {
    print('Erro na requisição: $e');
  }
}
