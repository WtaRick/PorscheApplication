import 'dart:convert';
import 'package:cards/_utente.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: camel_case_types
class zonaAccesso {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  List<Utente> listaUtenti = [];
  Future<void> inizialistaUtenti() async {
    String fileJsonDaConvertire = await rootBundle.loadString("models/utenti.json");
    final fileJson = json.decode(fileJsonDaConvertire);

    for (var utente in fileJson['utenti']) {
      listaUtenti.add(
        Utente(
          utente['id'],
          utente['password'],
          utente['credito'],
        ),
      );
    }
  }

  Widget accedi() {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 80.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Accesso",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  shadows: [
                    Shadow(
                      offset: const Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.grey[900]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.grey[300],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                height: 1000,
                color: Colors.white,
                child: eseguiAccesso(),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget eseguiAccesso() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40), // Spazio iniziale
              Text(
                "Inserisci il tuo ID!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: idController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelText: 'Inserisci qui il tuo ID',
                  labelStyle: TextStyle(color: Colors.grey[800]),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Inserisci la tua password!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelText: 'Inserisci qui la tua password',
                  labelStyle: TextStyle(color: Colors.grey[800]),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (controlliAccedi(idController.text, passwordController.text) == true) {
                      if (controlloCredenziali(idController.text, passwordController.text) == true) {
                        //alertAccessoBuonFine(context);    //TODO
                      }
                    } else {
                      //alertAccessoFallito(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Conferma"),
                ),
              ),
              const SizedBox(height: 40), // Spazio finale
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  bool controlloCredenziali(String idPassato, String passwordPassata) {
    // ignore: dead_code
    for (var i = 0; i < listaUtenti.length; i++) {
      if (listaUtenti[i].id == idPassato && listaUtenti[i].password == passwordPassata) {
        return true; //ha passato i controlli
      } else {
        return false;
      }
    }
    return false; //non esiste l'utente o le credenziali sono sbagliate
  }
}

bool controlliAccedi(String idPassato, String passwordPassata) {
  if (idPassato.isNotEmpty && passwordPassata.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

alertAccessoBuonFine(BuildContext context) {
  AlertDialog alertAccessoRiuscito = const AlertDialog(
    title: Text("Accesso Riuscito!"),
    content: Text("Accesso andato a buon fine!"),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertAccessoRiuscito;
    },
  );
}

alertAccessoFallito(BuildContext context) {
  AlertDialog alertAccessoFallito = const AlertDialog(
    title: Text("Accesso Fallito!"),
    content: Text("Accesso NON andato a buon fine!"),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertAccessoFallito;
    },
  );
}
