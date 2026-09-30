import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CounterFunctionsScreen extends StatefulWidget {
  const CounterFunctionsScreen({super.key});

  @override
  State<CounterFunctionsScreen> createState() =>
      _CounterFunctionsScreenState();
}

class _CounterFunctionsScreenState extends State<CounterFunctionsScreen> {
  int clickCounter = 0;

  Color get counterColor {
    if (clickCounter > 0) {
      return Colors.green;
    }

    if (clickCounter < 0) {
      return Colors.red;
    }

    return Colors.blue;
  }

  void increaseCounter() {
    setState(() {
      clickCounter++;
    });
  }

  void decreaseCounter() {
    setState(() {
      clickCounter--;
    });
  }

  void resetCounter() {
    setState(() {
      clickCounter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Counter Functions',
          style: GoogleFonts.nunito(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Reiniciar contador',
            onPressed: resetCounter,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$clickCounter',
              style: GoogleFonts.nunito(
                fontSize: 160,
                fontWeight: FontWeight.w300,
                color: counterColor,
              ),
            ),
            Text(
              'Click${clickCounter == 1 ? '' : 's'}',
              style: GoogleFonts.nunito(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: counterColor,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    FloatingActionButton(
      heroTag: 'reset',
      backgroundColor: Colors.pink.shade300,
      foregroundColor: Colors.white,
      onPressed: resetCounter,
      child: const Icon(Icons.refresh_rounded),
    ),
    const SizedBox(height: 10),
    FloatingActionButton(
      heroTag: 'increase',
      backgroundColor: Colors.pink.shade300,
      foregroundColor: Colors.white,
      onPressed: increaseCounter,
      child: const Text('+1'),
    ),
    const SizedBox(height: 10),
    FloatingActionButton(
      heroTag: 'decrease',
      backgroundColor: Colors.pink.shade300,
      foregroundColor: Colors.white,
      onPressed: decreaseCounter,
      child: const Text('-1'),
    ),
  ],
),
    );
  }
}
