class User {
  late String? phone;
  late String? name;

  User({this.phone, this.name});

  User.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['name'] = name;
    return data;
  }
}