// lib/helloUI.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contract_linking.dart'; // N'importe que la classe ContractLinking

class HelloUI extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Hello World DApp")),
      body: Center(
        child: contractLink.isLoading
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Hello ${contractLink.deployedName}!",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Enter your name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_nameController.text.isNotEmpty) {
                          contractLink.setName(_nameController.text);
                        }
                      },
                      child: Text("Set Name on Blockchain"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}