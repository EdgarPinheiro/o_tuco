import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class LedPage extends StatefulWidget {
  const LedPage({super.key});

  @override
  State<LedPage> createState() => _LedPageState();
}

class _LedPageState extends State<LedPage> {
  Color currentColor = const Color.fromRGBO(255, 251, 0, 1);

  void updateColor(Color color) {
    setState(() {
      currentColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Controle de LEDs')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Color Picker
            ColorPicker(
              pickerColor: currentColor,
              onColorChanged: updateColor,
              enableAlpha: true,
              labelTypes: const [ColorLabelType.rgb, ColorLabelType.hex],
              pickerAreaHeightPercent: 0.6,
              displayThumbColor: true,
            ),

            const SizedBox(height: 20),
            Text(
              'RGB: (${currentColor.red}, ${currentColor.green}, ${currentColor.blue})',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'HEX: #${currentColor.value.toRadixString(16).padLeft(8, '0').substring(2)}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            // Visualização final
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, currentColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
