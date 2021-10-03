class CustomerModel {
  late String id;
  late String username;
  late String address;
  late String phone;
  late String mohafza;
  late String fanniName;
  late String mandoobName;
  late String date;
  CustomerModel(this.id, this.username, this.address, this.phone, this.mohafza,
      this.fanniName, this.mandoobName);

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['customer_id'].toString();
    username = json['customer_name'].toString();
    address = json['address'].toString();
    phone = json['phone'].toString();
    mohafza = json['mohafza'].toString();
    fanniName = json['fanniNm'].toString();
    date = json['installdate'].toString();
    mandoobName = json['manNm'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.id;
    data['customer_name'] = this.username;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['mohafza'] = this.mohafza;
    data['fanniNm'] = this.fanniName;
    data['installdate'] = this.date;
    data['manNm'] = this.mandoobName;

    return data;
  }
}
