import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '_var_globali.dart' as globals;

class ShopItem {
  //a differenza di cars mi serve creare una classe con degli attributi perchè li utilizzo nel carrello
  final String name;
  final String prezzo;
  final String colore;
  final String consegna;
  final String path;

  ShopItem(this.name, this.prezzo, this.colore, this.consegna, this.path);
}

class Shop {
  List<ShopItem> listaShop = [];
  Future<void> inizializzaListaShop() async {
    listaShop = [];
    String fileJsonDaConvertire = await rootBundle.loadString("models/shop.json");
    final fileJson = json.decode(fileJsonDaConvertire);

    for (var item in fileJson['shop']) {
      listaShop.add(
        ShopItem(
          item['name'],
          item['prezzo'],
          item['colore'],
          item['consegna'],
          item['path'],
        ),
      );
    }
  }

  Widget visualizzaShop(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            //serve per i custom scroll
            expandedHeight: 80.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Shop",
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
                child: visualizzaTuttiGliItems(context),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget visualizzaTuttiGliItems(BuildContext context) {
    return FutureBuilder<void>(
      future: inizializzaListaShop(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Scaffold(
            body: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: listaShop.length,
              itemBuilder: (context, index) {
                final item = listaShop[index]; //item corrente
                return Card(
                  //La Card è un widget di Flutter che viene utilizzato per visualizzare contenuti e azioni su un singolo argomento
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                        child: Image.asset(
                          item.path,
                          height: 200.0,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            _rigaInfo('Prezzo', item.prezzo),
                            _rigaInfo('Colore', item.colore),
                            _rigaInfo('Consegna', item.consegna),
                            const SizedBox(height: 10.0), // Spazio aggiunto tra le informazioni e il pulsante
                            ElevatedButton(
                              onPressed: () {
                                globals.listaAcquistati.add(item);
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Colors.black87, // Colore del testo del bottone
                                elevation: 3, // Elevazione del bottone
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10), // Forma del bordo del bottone
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Padding interno del bottone
                                shadowColor: Colors.grey, // Colore dell'ombra del bottone
                              ),
                              child: const Text(
                                'Acquista',
                                style: TextStyle(fontSize: 16), // Stile del testo del bottone
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
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
          '$label:',
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
