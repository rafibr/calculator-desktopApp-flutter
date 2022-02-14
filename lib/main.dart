// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Calculator');
    setWindowMinSize(Size(600, 800));
    setWindowMaxSize(Size.infinite);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const CalculatorScreen(title: 'Calculator'),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String firstNumber = '';
  String secondNumber = '';
  String operation = '';
  String result = '';

  TextEditingController _controller = TextEditingController();
  void _onPressed(String value) {
    setState(() {
      if (_controller.text.length < 18) {
        _controller.text = _controller.text + value;
      } else {
        _controller.text = _controller.text.substring(1, _controller.text.length);
        _controller.text = _controller.text + value;
      }
      log(_controller.text);
    });
  }

  void _onClear() {
    setState(() {
      _controller.text = '';
      firstNumber = '';
      secondNumber = '';
      operation = '';
      result = '';
    });
  }

  void _onDelete() {
    setState(() {
      if (_controller.text.length > 0) {
        _controller.text = _controller.text.substring(0, _controller.text.length - 1);
      }
    });
  }

  void _onOperation(String value) {
    setState(() {
      if (firstNumber.isEmpty) {
        firstNumber = _controller.text;
        _controller.text = '';
        operation = value;
      } else {
        secondNumber = _controller.text;
        _controller.text = '';
        _calculate();
        operation = value;
      }
    });
  }

  void _onEqual() {
    setState(() {
      if (firstNumber.isEmpty) {
        firstNumber = _controller.text;
        _controller.text = '';
      } else {
        secondNumber = _controller.text;
        _controller.text = '';
        _calculate();
      }
    });
  }

  void _calculate() {
    double first = double.parse(firstNumber);
    double second = double.parse(secondNumber);
    double result = 0;

    switch (operation) {
      case '+':
        if (result != '') {
          result = result + second;
        } else {
          result = first + second;
        }
        break;
      case '-':
        if (result != '') {
          result = result - second;
        } else {
          result = first - second;
        }
        break;
      case '*':
        if (result != '') {
          result = result * second;
        } else {
          result = first * second;
        }
        break;
      case '/':
        if (result != '') {
          result = result / second;
        } else {
          result = first / second;
        }
        break;
    }
    setState(() {
      _controller.text = result.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
        color: Colors.blue,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: TextField(
                      enabled: false,
                      controller: _controller,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                        height: 2.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: () {
                            _onClear();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            'C',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            _onDelete();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            '<-',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onPressed('7');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            '7',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onPressed('8');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            '8',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onPressed('9');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            '9',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onOperation('+');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            '+',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onPressed('4');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            '4',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onPressed('5');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            '5',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onPressed('6');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            '6',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onOperation('-');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            '-',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onPressed('1');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            '1',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onPressed('2');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            '2',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onPressed('3');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            '3',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onOperation('*');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            '*',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onPressed('0');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            '0',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onPressed('.');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            '.',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onEqual();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            '=',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onOperation('/');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.5),
                          ),
                          child: Text(
                            '/',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
