import 'package:cards/_cars.dart';
import 'package:cards/_drivingSimulator.dart';
import 'package:cards/_shop.dart';
import 'package:flutter/material.dart';
import '_home.dart';
import '_cart.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Porsche Hub",
      home: gestione(),
    );
  }
}

// ignore: camel_case_types
class gestione extends StatefulWidget {
  const gestione({super.key});

  @override
  State<gestione> createState() => gestioneState();
}

// ignore: camel_case_types
class gestioneState extends State<gestione> {
  int indiceBarra = 0;
  Home home = Home();
  Cars cars = Cars();
  Shop shop = Shop();
  Simulator simulator = Simulator();
  Cart cart = Cart();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.blueGrey[300],
            label: "home",
            icon: const Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blueGrey[300],
            label: "cars",
            icon: const Icon(Icons.directions_car),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blueGrey[300],
            label: "shop",
            icon: const Icon(Icons.store),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blueGrey[300],
            label: "driving simulator",
            icon: const Icon(Icons.monitor),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blueGrey[300],
            label: "cart",
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
        currentIndex: indiceBarra,
        onTap: (int index) {
          setState(() {
            indiceBarra = index;
          });
        },
      ),
      body: gestionePagine(context),
    );
  }

  Widget gestionePagine(BuildContext context) {
    if (indiceBarra == 0) {
      //HOME
      return home.visualizzaHome();
    } else if (indiceBarra == 1) {
      //VISUALIZZA AUTO
      return cars.visualizzaCars(context);
    } else if (indiceBarra == 2) {
      //SIMULATORE
      return shop.visualizzaShop(context);
    } else if (indiceBarra == 3) {
      //SHOP
      return simulator.visualizzaSimulator();
    } else if (indiceBarra == 4) {
      return cart.visualizzaCart();
    } else {
      return const Text("Ricarica la Pagina");
    }
  }
}
