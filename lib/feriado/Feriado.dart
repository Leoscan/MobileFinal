class Feriado {
  var date;
  var localName;

  Feriado({this.date, this.localName});

  Feriado.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    localName = json['localName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['localName'] = this.localName;
    return data;
  }
}
