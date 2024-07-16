import 'package:hive/hive.dart';

part 'chat_message_model.g.dart';

@HiveType(typeId: 0)
class ChatMessageModel extends HiveObject {
  @HiveField(0)
  String sender;

  @HiveField(1)
  String message;

  @HiveField(2)
  String datetime;

  ChatMessageModel({
    required this.sender,
    required this.message,
    required this.datetime,
  });
}
