class TanbeahatModel {
  late String Cust_ID;
  late String Custname;
  late String Date;
  late String Cash;
  late String Qest_ID;
  late String Qest_Val;
  late String State;
  late String Mokadima;
  late String QestNumber;
  late String InvTot;

  TanbeahatModel({
    required this.Cust_ID,
    required this.Custname,
    required this.Date,
    required this.Cash,
    required this.Qest_ID,
    required this.Qest_Val,
    required this.State,
    required this.Mokadima,
    required this.QestNumber,
    required this.InvTot,
  });
  TanbeahatModel.fromJson(Map<String, dynamic> json) {
    Date = json['DateOfDue'].toString();
    Custname = json['Custnm'].toString();
    Cust_ID = json['CustID'].toString();
    Qest_ID = json['ID'].toString();
    Qest_Val = json['Cash'].toString();
    Cash = json['Paid'].toString();
    State = json['AlarmState'].toString();
    Mokadima = json['Mokadima'].toString();
    QestNumber = json['QestID'].toString();
    InvTot = json['InvTot'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DateOfDue'] = this.Date;
    data['Custnm'] = this.Custname;
    data['ID'] = this.Qest_ID;
    data['CustID'] = this.Cust_ID;
    data['Cash'] = this.Qest_Val;
    data['Paid'] = this.Cash;
    data['AlarmState'] = this.State;
    return data;
  }
}
