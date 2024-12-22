import 'package:flutter/material.dart';
import 'dart:math'; // 
import 'package:math_expressions/math_expressions.dart'; 

void main() => runApp(const Hesap());

class Hesap extends StatelessWidget {
  const Hesap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hesap Makinesi',
      themeMode: ThemeMode.dark,  
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const Iskele(),
    );
  }
}

class Iskele extends StatelessWidget {
  const Iskele({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hesap Makinesi")),
      body: const Anaekran(),
    );
  }
}

class Anaekran extends StatefulWidget {
  const Anaekran({super.key});

  @override
  State<Anaekran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<Anaekran> {
  String _display = ""; 
  
  void _onButtonPressed(String value) {
    setState(() {
      if (value == "AC") {
        _display = ""; 
      } else if (value == "DEL") {
        if (_display.isNotEmpty) {
          _display = _display.substring(0, _display.length - 1); 
        }
      } else if (value == "=") {
        try {
          _display = _calculateResult(_display); 
        } catch (e) {
          _display = "HATA"; 
        }
      } else if (value == "π") {
        _display += pi.toStringAsFixed(5); 
      } else {
        _display += value; 
      }
    });
  }

  String _calculateResult(String input) {
    try {

      input = input.replaceAll("×", "*").replaceAll("÷", "/");


      Parser p = Parser();
      Expression exp = p.parse(input);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);

      return result.toStringAsFixed(2); 
    } catch (e) {
      return "HATA"; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Expanded(
          child: Container(
            color: Colors.black,
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              _display,
              style: const TextStyle(color: Colors.white, fontSize: 48),
            ),
          ),
        ),

        Expanded(
          flex: 2,
          child: GridView.count(
            crossAxisCount: 4, 
            children: [
              _buildButton("AC", Colors.red),
              _buildButton("DEL", Colors.orange),
              _buildButton("π", Colors.blue),
              _buildButton("÷", Colors.blue),
              _buildButton("7", Colors.grey),
              _buildButton("8", Colors.grey),
              _buildButton("9", Colors.grey),
              _buildButton("×", Colors.blue),
              _buildButton("4", Colors.grey),
              _buildButton("5", Colors.grey),
              _buildButton("6", Colors.grey),
              _buildButton("-", Colors.blue),
              _buildButton("1", Colors.grey),
              _buildButton("2", Colors.grey),
              _buildButton("3", Colors.grey),
              _buildButton("+", Colors.blue),
              _buildButton("0", Colors.grey),
              _buildButton(".", Colors.grey),
              _buildButton("√", Colors.blue),
              _buildButton("=", Colors.green),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String label, Color color) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, 
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
