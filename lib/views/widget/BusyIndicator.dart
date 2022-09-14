import 'package:flutter/material.dart';

class BusyIndicator extends StatelessWidget {
  const BusyIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
    );
  }
}
