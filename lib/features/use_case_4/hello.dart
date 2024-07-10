import 'package:flutter/material.dart';

bool makeItTrue = false;

class Hello extends StatelessWidget {
  const Hello({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingActionButton(onPressed: () {
        makeItTrue = true;
      }),
    );
  }
}
