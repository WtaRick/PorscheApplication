//OGGETTO AUTO
class Prodotto {
  String name;
  String prezzo;
  String colore;
  String consegna;
  String path;

  Prodotto(this.name, this.prezzo, this.colore, this.consegna, this.path);

  @override
  String toString() {
    return '''
    Name: $name
    Prezzo: $prezzo
    Accelerazione: $colore
    VelocitaMax: $path
    ''';
  }
}
