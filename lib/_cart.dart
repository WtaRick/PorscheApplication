import 'package:cards/_zonaAccesso.dart';
import 'package:flutter/material.dart';
import '_var_globali.dart' as globals;

class Cart {
  var za = zonaAccesso();

  Widget visualizzaCart() {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 80.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Cart",
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
                child: visualizzaTuttiGliAcquisti(),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget visualizzaTuttiGliAcquisti() {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: globals.listaAcquistati.length,
        itemBuilder: (context, index) {
          final itemAcquistato = globals.listaAcquistati[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                // ClipRRect(
                //   //Creates a rounded-rectangular clip
                //   borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                //   child: Image.asset(
                //     itemAcquistato.path,
                //     height: 200.0, //se ne sbatte
                //     width: double.infinity,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemAcquistato.name,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      _rigaInfo('Nome:', itemAcquistato.name),
                      _rigaInfo('Prezzo', itemAcquistato.prezzo),
                      _rigaInfo('Colore', itemAcquistato.colore),
                      _rigaInfo('Tempi di Consegna', itemAcquistato.consegna),
                      //_rigaInfo('Velocità Massima', itemAcquistato.path),
                    ],
                  ),
                ),

                if (globals.listaAcquistati.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => za.accedi()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.black87, padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ), // Colore del testo
                      elevation: 5,
                    ),
                    child: const Text(
                      'Conferma Acquisto',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                const Text("\n"),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _rigaInfo(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
