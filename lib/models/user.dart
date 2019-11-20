class User {
  final int id;
  final String name;
  final int age;
  final bool sex;

  User({ this.id, this.name, this.age, this.sex });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'sex': sex,
    };
  }
}