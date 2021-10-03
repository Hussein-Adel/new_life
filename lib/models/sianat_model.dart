class SianatModel {
  late String Date;
  late String Fanni_Name;
  late String Cust_ID;
  late String Custname;
  late int Takm;
  late int Shamaa_Ola;
  late String Other_Siana;
  late String Cost;
  late String Paid_Cash;
  late String Notes;

  SianatModel({
    required this.Date,
    required this.Fanni_Name,
    required this.Cust_ID,
    required this.Custname,
    required this.Takm,
    required this.Shamaa_Ola,
    required this.Other_Siana,
    required this.Cost,
    required this.Paid_Cash,
    required this.Notes,
  });
  //Move_date,Fanni_Nm,Cust_ID,Cust_Nm,Takm,Shamaa_Ola,Other_Siana,Cost,Paid_Cash,Notes

  SianatModel.fromJson(Map<String, dynamic> json) {
    Date = json['Move_date']['date'].toString();
    Fanni_Name = json['Fanni_Nm'].toString();
    Cust_ID = json['Cust_ID'].toString();
    Custname = json['Cust_Nm'].toString();
    Takm = int.parse(json['Takm'].toString());
    Shamaa_Ola = int.parse(json['Shamaa_Ola'].toString());
    Other_Siana = json['Other_Siana'].toString();
    Cost = json['Cost'].toString();
    Paid_Cash = json['Paid_Cash'].toString();
    Notes = json['Notes'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Move_date']['date'] = this.Date;
    data['Fanni_Nm'] = this.Fanni_Name;
    data['Cust_ID'] = this.Cust_ID;
    data['Cust_Nm'] = this.Custname;
    data['Takm'] = this.Takm;
    data['Shamaa_Ola'] = this.Shamaa_Ola;
    data['Other_Siana'] = this.Other_Siana;
    data['Cost'] = this.Cost;
    data['Paid_Cash'] = this.Paid_Cash;
    data['Notes'] = this.Notes;
    data['Fanni_Name'] = this.Fanni_Name;
    return data;
  }
}
