import 'dart:convert';
import 'package:cards/_auto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Cars {
  List<Auto> listaAuto = [];

  Future<void> inizializzaListaAuto() async {
    listaAuto = [];
    String fileJsonDaConvertire = await rootBundle.loadString("models/cars.json");
    final fileJson = json.decode(fileJsonDaConvertire);

    for (var category in fileJson['cars']) {
      for (var car in category['typeOf']) {
        listaAuto.add(
          Auto(
            category['category'],
            car['name'],
            car['characteristics'][0]['prezzo'],
            car['characteristics'][0]['cavalli'],
            car['characteristics'][0]['accelerazione'],
            car['characteristics'][0]['velocitaMax'],
            car['characteristics'][0]['consumoCombinato'],
            car['characteristics'][0]['path'],
          ),
        );
      }
    }
  }

  // Future<void> stampaListaAuto() async {
  //   await inizializzaListaAuto();
  //   // then(_)viene utilizzata per eseguire un'azione dopo che un'operazione asincrona è stata completata con successo.
  //   // Stampa degli oggetti Auto
  //   for (var auto in listaAuto) {
  //     // ignore: avoid_print
  //     print(auto.toString());
  //   }
  // }

  Widget visualizzaCars(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 80.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Cars",
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
                child: visualizzaTutteLeAuto(context),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget visualizzaTutteLeAuto(BuildContext context) {
    return FutureBuilder<void>(
      future: inizializzaListaAuto(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //La proprietà connectionState dell'oggetto snapshot indica lo stato corrente della Future associata al widget. Se è in waiting sta asncroa aspettando
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Scaffold(
            body: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: listaAuto.length,
              itemBuilder: (context, index) {
                final auto = listaAuto[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        //Creates a rounded-rectangular clip
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                        child: Image.asset(
                          auto.path,
                          height: 200.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              auto.name,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            _rigaInfo('Categoria', auto.category),
                            _rigaInfo('Prezzo', auto.prezzo),
                            _rigaInfo('Cavalli', auto.cavalli),
                            _rigaInfo('Accelerazione', auto.accelerazione),
                            _rigaInfo('Velocità Massima', auto.velocitaMax),
                            _rigaInfo('Consumo Combinato', auto.consumoCombinato),
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
