class EntryModel {
  final int? id;
  final String name;
  final String description;

  EntryModel({this.id, required this.name, required this.description});

  factory EntryModel.fromMap(Map<String, dynamic> json) => EntryModel(
    id: json['id'],
    name: json['name'],
    description: json['description'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
