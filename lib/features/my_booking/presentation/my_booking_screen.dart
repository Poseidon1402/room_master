import 'package:flutter/material.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mes Réservations',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),
    );
  }
}