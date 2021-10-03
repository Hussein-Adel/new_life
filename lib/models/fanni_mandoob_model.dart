class FanniMandoobModel {
  late int id;
  late String username;

  FanniMandoobModel(
    this.id,
    this.username,
  );

  FanniMandoobModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    username = json['name'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.username;
    return data;
  }
}
