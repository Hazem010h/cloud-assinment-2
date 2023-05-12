class Person {
  String? id;
  String? name;
  String? email;
  String? gender;
  String? age;

  Person({this.id, this.name, this.email, this.gender, this.age});

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    age = json['age'];
  }

}