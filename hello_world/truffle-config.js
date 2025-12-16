module.exports = {
  // ... (supprimez les autres lignes non pertinentes si elles existent)

  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545, // Vérifiez ce port avec votre Ganache !
      network_id: "*", // Match any network id
    },
  },
  
  // Chemin de sortie pour les artefacts (pour que Flutter puisse le lire)
  contracts_build_directory: "./src/artifacts/",

  compilers: {
    solc: {
      version: "0.8.0", // Doit correspondre à la version dans HelloWorld.sol
      settings: {
        optimizer: {
          enabled: false,
          runs: 200,
        },
      },
    },
  },
};