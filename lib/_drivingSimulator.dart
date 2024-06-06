// ignore: file_names
import 'package:flutter/material.dart';
import 'dart:math';

class Simulator {
  Widget visualizzaSimulator() {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 80.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Driving Simulator",
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
            delegate: SliverChildListDelegate(
              [
                // Testo fornito
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: "Piloti sul divano\n",
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(text: "Realtà e mondo virtuale si fondono tra loro. Per il simulatore di corse Forza Motorsport 7 gli sviluppatori del gioco hanno collaborato a stretto contatto con gli ingegneri di Weissach. La stella del gioco è la 911 più potente di tutti i tempi\n\n"),
                        TextSpan(text: "È questo suono pungente e straordinario della Porsche 911 GT2 RS che quasi fa saltare i giocatori sul divano. Un suono che fa capire che qui non solo si sorpassa e si corre, qui le auto vengono portate al limite. Per giorni gli sviluppatori del gioco sono stati ospitati nel Centro Ricerca e Sviluppo Porsche a Weissach. Ad essere precisi hanno teso le orecchie su come il potente motore boxer biturbo a sei cilindri prenda lo slancio, su come mostri il suo piglio e su come poi non molli più. Il risultato della cooperazione tra Microsoft e Porsche è che il fascino di Casa Porsche lo si può vivere nei salotti di tutto il mondo con una fedeltà di dettagli mai così elevata.\n\n"),
                        TextSpan(text: "Come per il suono, i programmatori hanno posto grande attenzione a tutti gli altri dettagli, come ad esempio la grafica, che ha un realismo quasi fotografico, le caratteristiche di guida, che, grazie ai dati tecnici esaustivi forniti dal reparto Sviluppo Porsche, vengono riprodotte sui rispettivi modelli virtuali alla perfezione. I circuiti, le luci, le condizioni meteo, tutto fa sì che il giocatore abbia la sensazione di trovarsi a Dubai o di guidare al Nürburgring con la pioggia.\n\n"),
                        TextSpan(text: "Mai come oggi è stato possibile incorporare così tante vetture e così tanti circuiti in una versione di Forza Motorsport. Mai come oggi una Porsche 911 ha erogato una potenza tanto brutale come la 911 GT2 RS con i suoi 700 CV. Per la prima volta la 911 al top è stata mostrata dal vivo alla fiera dei videogiochi Electronic Entertainment Expo – E3 a Los Angeles, insieme alla sua gemella digitale, anche se solo per pochi minuti.\n\n"),
                        TextSpan(text: "Forza Motorsport 7 offre la possibilità di giocare con 700 auto. Le Porsche sono ben 29 e invitano ad ingaggiare accesi duelli. Ad esempio, una sfida tra le supersportive 918 Spyder e Carrera GT. Una corsa di montagna con auto storiche tra una 550 A Spyder e una 356 A Speedster. Oppure, per i giocatori più incalliti, una 24 Ore con la 919 Hybrid, l’auto che ha vinto per ben tre volte il campionato LMP1.\n\n"),
                      ],
                    ),
                  ),
                ),
                // Zona per le immagini ruotabili 3D
                SizedBox(
                  height: 300, // Imposta l'altezza desiderata per l'area
                  child: GameRotate(
                    front: Image.asset('../images/Simulator/fm1.png'),
                    back: Image.asset('../images/Simulator/fm2.png'),
                  ),
                ),
                // Altri widget qui
                const SizedBox(
                  height: 100,
                  child: Center(child: Text("")),
                ),
                const Column(
                  children: [
                    Text("Produttore: Microsoft\n"),
                    Text("Sviluppatore: Turn 10 Studios\n"),
                    Text("Piattaforme: Xbox One, Windows 10\n"),
                    Text("Disponibilità: a partire dal 3 ottobre\n"),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GameRotate extends StatefulWidget {
  const GameRotate({super.key, required this.front, required this.back});
  final Widget front;
  final Widget back;

  @override
  // ignore: library_private_types_in_public_api
  _GameRotateState createState() => _GameRotateState();
}

class _GameRotateState extends State<GameRotate> {
  bool isFront = true;
  double dragMouse = 0;

  @override
  Widget build(BuildContext context) {
    final angle = dragMouse / 180 * pi; // Angolo di rotazione
    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateY(angle);

    return GestureDetector(
      // Serve per prendere i "gesti" del mouse il drag nel nostro caso
      onHorizontalDragUpdate: (details) => setState(() {
        dragMouse -= details.delta.dx;
        dragMouse %= 360;

        settaImmagine();
      }),
      child: Transform(
        transform: transform,
        alignment: Alignment.center,
        child: isFront
            ? widget.front
            : Transform(
                transform: Matrix4.identity()..rotateX(pi),
                alignment: Alignment.center,
                child: widget.back,
              ),
      ),
    );
  }

  void settaImmagine() {
    // Controllo per quando si gira
    if (dragMouse <= 90 || dragMouse >= 270) {
      isFront = true;
    } else {
      isFront = false;
    }
  }
}
