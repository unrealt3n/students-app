class ModelStudent {
  final int? id;
  final String image;
  final String name;
  final int age;
  final int mark;
  final String schoolName;

  ModelStudent({
    this.id,
    required this.name,
    required this.image,
    required this.age,
    required this.mark,
    required this.schoolName,
  });

  static ModelStudent fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final age = map['age'] as int;
    final mark = map['mark'] as int;
    final image = map['image'] as String;
    final scholName = map['schoolName'] as String;

    return ModelStudent(
        id: id,
        name: name,
        age: age,
        mark: mark,
        image: image,
        schoolName: scholName);
  }
}
