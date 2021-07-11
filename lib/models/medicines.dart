class Medicines {
  String name;
  String image;
  String quantity;
  String time;
  String value;

  Medicines({this.name, this.image, this.quantity, this.time, this.value});

  Medicines.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    quantity = json['quantity'];
    time = json['time'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    data['time'] = this.time;
    data['value'] = this.value;
    return data;
  }
}
