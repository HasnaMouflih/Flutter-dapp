// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importe Provider
import 'contract_linking.dart'; // Importe la logique blockchain
import 'helloUI.dart'; // Importe l'interface utilisateur

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContractLinking>(
      create: (_) => ContractLinking(),
      child: MaterialApp(
        title: "Hello World Dapp",
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
        ),
        home: HelloUI(),
      ),
    );
  }
}