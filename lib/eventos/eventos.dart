class Eventos {
  var id;
  var model;
  var data;

  Eventos({this.id, this.model, this.data});

  Eventos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    model = json['model'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model'] = this.model;
    data['data'] = this.data.toString();
    return data;
  }
}
