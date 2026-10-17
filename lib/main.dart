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
  String _operation = '';
  String _result = '';
  final List<String> _history = [];

  void _selectOperation(String op) {
    setState(() {
      _operation = op;
    });
  }

  // Função de calculo
  double calculate(double a, double b, String op) {
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

  // Formata valores inteiros sem virgula
  String _format(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  // Execução do calculo com base nos dados inseridos
  void _executeCalculation() {
    double n1 = double.tryParse(_num1.replaceAll(',', '.')) ?? 0.0;
    double n2 = double.tryParse(_num2.replaceAll(',', '.')) ?? 0.0;

    // Validação anti divisão por 0
    if (_operation == '÷' && n2 == 0) {
      setState(() {
        _result = 'Cannot divide by zero';
      });
      return;
    }

    // Realiza nosso calculo com base nos parametros e passa o resultado formatado
    double result = calculate(n1, n2, _operation);
    String expression =
        '${_format(n1)} $_operation ${_format(n2)} = ${_format(result)}';

    // Define novos estados para as váriaveis que aparecem em tela
    setState(() {
      _result = expression;
      _history.insert(0, expression);
    });
  }

  void _clearHistory() {
    setState(() {
      _history.clear();
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calcular')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Primeiro número'),
              onChanged: (value) {
                setState(() {
                  _num1 = value;
                });
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Segundo número'),
              onChanged: (value) {
                setState(() {
                  _num2 = value;
                });
              },
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _selectOperation('+'),
                  child: const Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => _selectOperation('-'),
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => _selectOperation('×'),
                  child: const Text('×'),
                ),
                ElevatedButton(
                  onPressed: () => _selectOperation('÷'),
                  child: const Text('÷'),
                ),
              ],
            ),
            Text('Operação selecionada: $_operation'),
            ElevatedButton(
              onPressed: _executeCalculation,
              child: const Text('Calcular'),
            ),
            Text(_result),
            const Text('Histórico'),
            ElevatedButton(
              onPressed: _clearHistory,
              child: const Text('Limpar histórico'),
            ),
            ..._history.map((item) => Text(item)),
          ],
        ),
      ),
    );
  }
}
