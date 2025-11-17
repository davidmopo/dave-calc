import 'package:flutter/material.dart';

// This line removes the private-type lint warning (standard practice in Flutter)
//// ignore_for_file: library_private_types_in_public_api

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dave Calculator',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";

  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "×" ||
          buttonText == "÷") {
        num1 = double.parse(output);
        operand = buttonText;
        _output = "0";
      } else if (buttonText == ".") {
        if (_output.contains(".")) {
          return;
        } else {
          _output = _output + buttonText;
        }
      } else if (buttonText == "=") {
        num2 = double.parse(output);

        if (operand == "+") {
          _output = (num1 + num2).toString();
        }
        if (operand == "-") {
          _output = (num1 - num2).toString();
        }
        if (operand == "×") {
          _output = (num1 * num2).toString();
        }
        if (operand == "÷") {
          _output = num2 != 0 ? (num1 / num2).toString() : "Error";
        }

        num1 = 0.0;
        num2 = 0.0;
        operand = "";
      } else {
        _output = _output == "0" ? buttonText : _output + buttonText;
      }

      // Clean up unnecessary zeros and decimals
      if (_output != "Error") {
        double value = double.parse(_output);
        if (value == value.truncate()) {
          output = value.toInt().toString();
        } else {
          output = value.toString();
        }
      } else {
        output = _output;
      }
    });
  }

  Widget buildButton(
    String buttonText, {
    Color? buttonColor,
    Color? textColor,
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor ?? Colors.grey[800],
            foregroundColor: textColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(24),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Dave Calculator"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // Display Area
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(
                output,
                style: const TextStyle(
                  fontSize: 72,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),

          // Buttons Area
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      buildButton("C", buttonColor: Colors.redAccent, flex: 2),
                      buildButton("÷", buttonColor: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("7"),
                      buildButton("8"),
                      buildButton("9"),
                      buildButton("×", buttonColor: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("4"),
                      buildButton("5"),
                      buildButton("6"),
                      buildButton("-", buttonColor: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("1"),
                      buildButton("2"),
                      buildButton("3"),
                      buildButton("+", buttonColor: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("0", flex: 2),
                      buildButton("."),
                      buildButton("=", buttonColor: Colors.green, flex: 2),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
