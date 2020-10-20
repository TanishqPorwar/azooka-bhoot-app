class Fluorophores {
  String name;
  int em;
  int ex;
  double quantum_yield;
  String safety;
  int stoke_shift;
  String application;

  Fluorophores(
      {this.name,
      this.em,
      this.ex,
      this.quantum_yield,
      this.safety,
      this.stoke_shift,
      this.application});

  Fluorophores.fromMap(Map<String, dynamic> map) {
    this.name = map["name"];
    this.em = map["EM"];
    this.ex = map["EX"];
    this.quantum_yield = map["Quantum yield"];
    this.safety = map["Safety"];
    this.stoke_shift = map["Stoke’s shift(nm)"];
    this.application = map["application"];
  }
}
