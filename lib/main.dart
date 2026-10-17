import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _num1 = '';
  String _num2 = '';
  String _operacao = '+';

  void _selecionarOperacao(String op) {
    setState(() {
      _operacao = op;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Primeiro número'),
              onChanged: (valor) {
                setState(() {
                  _num1 = valor;
                });
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Segundo número'),
              onChanged: (valor) {
                setState(() {
                  _num2 = valor;
                });
              },
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _selecionarOperacao('+'),
                  child: const Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => _selecionarOperacao('-'),
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => _selecionarOperacao('×'),
                  child: const Text('×'),
                ),
                ElevatedButton(
                  onPressed: () => _selecionarOperacao('÷'),
                  child: const Text('÷'),
                ),
              ],
            ),
            Text('Operação selecionada: $_operacao'),
            Text('Você digitou: $_num1 $_operacao $_num2'),
          ],
        ),
      ),
    );
  }
}
