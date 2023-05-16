// class ChatUser{
//
// }

class ChatUser {
  ChatUser({
    required this.image,
    required this.name,
    required this.about,
    required this.createdAt,
    required this.lastActive,
    required this.isOnline,
    required this.id,
    required this.pushToken,
    required this.email,
  }); //Constructor

  // field
  // late final String image;
  // late final String name;
  // late final String about;
  // late final String createdAt;
  // late final String lastActive;
  // late final bool isOnline;
  // late final String id;
  // late final String pushToken;
  // late final String email;
  //When we use final we cant update

  late  String image;
  late  String name;
  late  String about;
  late  String createdAt;
  late  String lastActive;
  late  bool isOnline;
  late  String id;
  late  String pushToken;
  late  String email;

  // Convert json to dart object
  ChatUser.fromJson(Map<String, dynamic> json){
    image = json['image']?? '';
    name = json['name']?? '';
    about = json['about']?? '';
    createdAt = json['created_at']?? '';
    lastActive = json['last_active']?? '';
    isOnline = json['is_online']?? '';
    id = json['id']?? '';
    pushToken = json['push_token']?? '';
    email = json['email']?? '';
  }

  // when we send the data to the server convert the dart object to the json
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['about'] = about;
    data['created_at'] = createdAt;
    data['last_active'] = lastActive;
    data['is_online'] = isOnline;
    data['id'] = id;
    data['push_token'] = pushToken;
    data['email'] = email;
    return data;
  }
}