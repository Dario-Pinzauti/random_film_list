class SharedList {
  String? id;
  final List<String> usersId;
  final int filmNumber;


  SharedList({ this.id, required this.usersId, required this.filmNumber});


  factory SharedList.fromJson(Map<String, dynamic> json){
    var list = (json["users_id"] as List).map((e) => e.toString()).toList();
    list.sort();
    return SharedList(
      id: list.join(),
      usersId: (json["users_id"] as List).map((e) => e.toString()).toList(),
      filmNumber: json["film_number"] ?? null,
    );
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users_id']=usersId;
    data['film_number']=filmNumber;
    return data;
  }



}