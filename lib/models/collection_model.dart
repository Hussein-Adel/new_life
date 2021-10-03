class CollectionModel {
  late String Cust_ID;
  late String Custname;
  late String Date;
  late String Cash;
  late String Qest_ID;
  late String Notes;
  late String Qest_Val;
  late String Fanni_Name;
  late String Fanni_ID;
  late String Confirmed;
  late String Add_To_Salary;
  late String Takm;
  late String Shamaa_Ola;
  late String Other_Sianat;
  late String Make_siana;
  late String Siana_val;
  late String Paid_For_siana;

  CollectionModel({
    required this.Cust_ID,
    required this.Custname,
    required this.Date,
    required this.Cash,
    required this.Qest_ID,
    required this.Notes,
    required this.Qest_Val,
    required this.Fanni_Name,
    required this.Fanni_ID,
    required this.Confirmed,
    required this.Add_To_Salary,
    required this.Takm,
    required this.Shamaa_Ola,
    required this.Other_Sianat,
    required this.Make_siana,
    required this.Siana_val,
    required this.Paid_For_siana,
  });

  CollectionModel.fromJson(Map<String, dynamic> json) {
    Date = json['Move_Date']['date'].toString();
    Custname = json['User_Logged'].toString();
    Qest_ID = json['Qest_ID'].toString();
    Cust_ID = json['Cust_Code'].toString();
    Qest_Val = json['Qest_Val'].toString();
    Cash = json['Paid'].toString();
    Notes = json['Notes'].toString();
    Fanni_Name = json['Fanni_Name'].toString();
    Fanni_ID = json['Fanni_ID'].toString();
    Confirmed = json['Confirmed'].toString();
    Add_To_Salary = json['add_To_Salary'].toString();
    Takm = json['takm'].toString();
    Shamaa_Ola = json['shamaa_Ola'].toString();
    Other_Sianat = json['other_Sianat'].toString();
    Make_siana = json['make_siana'].toString();
    Siana_val = json['siana_val'].toString();
    Paid_For_siana = json['paid_For_siana'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Move_Date']['date'] = this.Date;
    data['User_Logged'] = this.Custname;
    data['Qest_ID'] = this.Qest_ID;
    data['Cust_Code'] = this.Cust_ID;
    data['Qest_Val'] = this.Qest_Val;
    data['Paid'] = this.Cash;
    data['Notes'] = this.Notes;
    data['Fanni_Name'] = this.Fanni_Name;
    data['Fanni_ID'] = this.Fanni_Name;
    data['Confirmed'] = this.Confirmed;
    return data;
  }
}
