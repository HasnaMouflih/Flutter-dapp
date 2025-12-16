// lib/contract_linking.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'; // Import des paquets blockchain
import 'package:web3dart/web3dart.dart'; // Import des paquets blockchain
import 'package:web_socket_channel/io.dart'; 

// lib/contract_linking.dart

class ContractLinking extends ChangeNotifier {
  // CORRECTION : Utiliser localhost pour la connexion navigateur/web-server
  final String _rpcUrl = "http://localhost:7545"; // Pour HTTP
  final String _wsUrl = "ws://localhost:7545";    // Pour WebSocket (sans le slash final)
  
  // Reste du code...
  // CLÉ PRIVÉE DU COMPTE (0) DE GANACHE CLI :
  final String _privateKey = "0x777bd710e5137beb8acdecde3616f286220f6711d06deeac8b43830940c3a8f9"; // Votre clé privée
  
  late Web3Client _client;
  late String _abiCode;
  late EthereumAddress _contractAddress;
  late Credentials _credentials;

  late DeployedContract _contract;
  late ContractFunction _yourName;
  late ContractFunction _setName;
  
  String deployedName = "Loading...";
  bool isLoading = true;

  ContractLinking() {
    initialSetup();
  }

  Future<void> initialSetup() async {
    _client = Web3Client(_rpcUrl, Client());
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String artifactString = await rootBundle.loadString("src/artifacts/HelloWorld.json");
    var jsonAbi = jsonDecode(artifactString);
    
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress = EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]); 
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
      ContractAbi.fromJson(_abiCode, "HelloWorld"),
      _contractAddress,
    );

    _yourName = _contract.function("yourName"); 
    _setName = _contract.function("setName"); 

    await getName();
  }

  Future<void> getName() async {
    var currentName = await _client.call(
      contract: _contract,
      function: _yourName,
      params: [],
    );
    
    deployedName = currentName[0].toString();
    isLoading = false;
    notifyListeners();
  }

  Future<void> setName(String name) async {
    isLoading = true;
    notifyListeners();

    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _setName,
        parameters: [name],
        from: await _credentials.extractAddress(),
      ),
    );

    await Future.delayed(Duration(milliseconds: 500));
    await getName();
  }
}