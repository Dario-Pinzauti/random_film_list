class RLUser {
  final String id;
  final String? name;
  final String email;
  final String? imagePath;

  RLUser({required this.id, this.name, required this.email, this.imagePath});


  factory RLUser.fromJson(Map<String, dynamic> json) => RLUser(
    id: json["id"] ?? null,
    name: json["name"] ?? null,
    email: json["email"] ?? null,
    imagePath: json["image_path"] ?? null,
  );

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=id;
    data['name']=name;
    data['email']=email;
    data['image_path']=imagePath;
    return data;
  }


}