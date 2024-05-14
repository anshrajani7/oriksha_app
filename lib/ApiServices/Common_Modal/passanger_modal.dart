class Passenger {
  Passenger({
    this.id,
    this.email,
    this.password,
    this.name,
    this.mobile,
    this.image,
    this.service,
    this.longitude,
    this.latitude,
    this.pushToken,
    this.address,
  });

  String? id;
  String? email;
  String? password;
  String? mobile;
  String? name;
  String? image;
  String? service;
  double? latitude;
  double? longitude;
  String? pushToken;
  String? address;

  Passenger.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    email = json['email'] ?? '';
    password = json['password'] ?? '';
    mobile = json['mobile'] ?? '';
    name = json['name'] ?? '';
    image = json['image'] ?? '';
    service = json['service'] ?? '';
    longitude = json['longitude'] ?? '';
    latitude = json['latitude'] ?? '';
    pushToken = json['pushToken'] ?? '';
    address = json['address'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['mobile'] = mobile;
    data['name'] = name;
    data['image'] = image;
    data['service'] = service;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['pushToken'] = pushToken;
    data['address'] = address;
    return data;
  }
}
