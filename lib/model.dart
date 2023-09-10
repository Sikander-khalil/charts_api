class MyModel {
  int? count;
  String? name;
  String? gender;
  double? probability;

  MyModel({this.count, this.name, this.gender, this.probability});

  MyModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    name = json['name'];
    gender = json['gender'];
    probability = json['probability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['probability'] = this.probability;
    return data;
  }
}