//OGGETTO AUTO
class Auto {
  String category;
  String name;
  String prezzo;
  String cavalli;
  String accelerazione;
  String velocitaMax;
  String consumoCombinato;
  String path;

  Auto(
    this.category,
    this.name,
    this.prezzo,
    this.cavalli,
    this.accelerazione,
    this.velocitaMax,
    this.consumoCombinato,
    this.path,
  );

  @override
  String toString() {
    return '''
    Category: $category
    Name: $name
    Prezzo: $prezzo
    Cavalli: $cavalli
    Accelerazione: $accelerazione
    VelocitaMax: $velocitaMax
    ConsumoCombinato: $consumoCombinato
    ''';
  }
}
