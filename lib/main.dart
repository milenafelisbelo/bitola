import 'package:flutter/material.dart';

void main() {
  runApp(const BitolaCalculatorApp());
}

class BitolaCalculatorApp extends StatelessWidget {
  const BitolaCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Bitola',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BitolaCalculatorPage(),
    );
  }
}

class BitolaCalculatorPage extends StatefulWidget {
  const BitolaCalculatorPage({super.key});

  @override
  _BitolaCalculatorPageState createState() => _BitolaCalculatorPageState();
}

class _BitolaCalculatorPageState extends State<BitolaCalculatorPage> {
  final TextEditingController _distanciaController = TextEditingController();
  final TextEditingController _correnteController = TextEditingController();
  double _bitola110 = 0.0;
  double _bitola220 = 0.0;

  void _calcularBitola() {
    final distancia = double.tryParse(_distanciaController.text) ?? 0.0;
    final corrente = double.tryParse(_correnteController.text) ?? 0.0;

    setState(() {
      _bitola110 = (2 * corrente * distancia) / 294.64;
      _bitola220 = (2 * corrente * distancia) / 510.4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Bitola (mm²)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Elétrica residencial cabos de cobre:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text('Distância em metros:'),
            TextField(
              controller: _distanciaController,
              decoration: const InputDecoration(
                hintText: 'Digite a distância',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            const Text('Corrente:'),
            TextField(
              controller: _correnteController,
              decoration: const InputDecoration(
                hintText: 'Digite a corrente em amperes',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _calcularBitola,
                child: const Text('Calcular'),
              ),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'A bitola recomendada para Tensão 127V',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700]),
                    ),
                    Text(
                      'é: ${_bitola110.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'A bitola recomendada para Tensão 220V',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700]),
                    ),
                    Text(
                      'é: ${_bitola220.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _distanciaController.dispose();
    _correnteController.dispose();
    super.dispose();
  }
}