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
  String _operacao = '';
  String _resultado = '';

  void _selecionarOperacao(String op) {
    setState(() {
      _operacao = op;
    });
  }

  // Escolhe a conta conforme a operação
  double calcular(double a, double b, String op) {
    if (op == '+') {
      return a + b;
    } else if (op == '-') {
      return a - b;
    } else if (op == '×') {
      return a * b;
    } else {
      return a / b;
    }
  }

  void _executarCalculo() {
    // Troca vírgula por ponto e converte texto em número
    double n1 = double.tryParse(_num1.replaceAll(',', '.')) ?? 0.0;
    double n2 = double.tryParse(_num2.replaceAll(',', '.')) ?? 0.0;

    // Náo permite divisão por 0
    if (_operacao == '÷' && n2 == 0) {
      setState(() {
        _resultado = 'Não é possível dividir por zero';
      });
      return;
    }

    // Realiza o calculo com base nos dados obtidos
    double resultado = calcular(n1, n2, _operacao);

    setState(() {
      _resultado = '$n1 $_operacao $n2 = $resultado';
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
            ElevatedButton(
              onPressed: _executarCalculo,
              child: const Text('Calcular'),
            ),
            Text(_resultado),
          ],
        ),
      ),
    );
  }
}
