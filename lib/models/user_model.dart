class UserModel {
  static const collectionName = 'users';
  String id;
  String emil;
  String name;
  int createdAt;

  UserModel({
    this.id = '',
    required this.emil,
    required this.name,
    required this.createdAt,
  });

  UserModel.fromJson(Map<String, dynamic> json)
    : this(
        id: json["id"],
        emil: json["emil"],
        name: json["name"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() {
    return {"id": id, "emil": emil, "name": name, "createdAt": createdAt};
  }
}
