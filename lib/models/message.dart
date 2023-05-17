class Message {
  Message({
    required this.msg,
    required this.toId,
    required this.readTime,
    required this.type,
    required this.fromId,
    required this.sendTime,
  });
  late final String msg;
  late final String toId;
  late final String readTime;
  late final Type type;
  late final String fromId;
  late final String sendTime;

  Message.fromJson(Map<String, dynamic> json){
    msg = json['msg'].toString();
    toId = json['toId'].toString();
    readTime = json['readTime'].toString();
    type = json['type'].toString()==Type.image.name?Type.image:Type.text;
    fromId = json['fromId'].toString();
    sendTime = json['sendTime'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['msg'] = msg;
    data['toId'] = toId;
    data['readTime'] = readTime;
    data['type'] = type.name;
    data['fromId'] = fromId;
    data['sendTime'] = sendTime;
    return data;
  }
}
enum Type {text,image}
