class UserModel {
  late int id;
  late String username;
  late String gmail;
  late String password;
  late String type;
  UserModel(
    this.id,
    this.username,
    this.gmail,
    this.password,
    this.type,
  );

  UserModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    username = json['name'].toString();
    gmail = json['gmail'].toString();
    password = json['pass'].toString();
    type = json['type'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['gmail'] = this.gmail;
    data['pass'] = this.password;
    data['type'] = this.type;

    return data;
  }
}
