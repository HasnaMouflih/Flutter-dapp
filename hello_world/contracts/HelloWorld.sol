// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

contract HelloWorld {
    // Variable d'état publique. Le nom par défaut sera "Unknown".
    string public yourName; 

    // 1. Constructeur : Exécuté lors du déploiement
    constructor() {
        yourName = "Unknown";
    }

    // 2. Fonction pour modifier la variable (via une transaction)
    function setName(string memory nm) public {
        yourName = nm; 
    }
}