import 'package:flutter/widgets.dart';

// Enum for identifying the owner of the message.
enum OwnerType { receiver, sender }

/// Converts a string to its corresponding OwnerType enum value.
OwnerType _of(String name) {
  return OwnerType.values.firstWhere(
        (e) => e.toString() == name,
    orElse: () => OwnerType.sender, // Default to 'sender' if not matched.
  );
}

class MessageModel {
  final int? id;

  /// GlobalKey to avoid refreshing issues when adding data.
  /// Consider using a more specific key type if applicable for better performance and specificity.
  final GlobalKey key;

  /// Identifies the message as being from the sender or receiver, to determine its display side.
  final OwnerType ownerType;

  /// The name of the message sender.
  final String? ownerName;

  /// URL for the avatar image.
  final String? avatar;

  /// The content of the message.
  final String content;

  /// Timestamp of message creation, in milliseconds since epoch.
  final int createdAt;

  /// Whether to display the creation time of the message.
  bool showCreatedTime = false;

  MessageModel({
    this.id,
    this.ownerName,
    required this.ownerType,
    this.avatar,
    required this.content,
    required this.createdAt,
  }) : key = GlobalKey();

  /// Factory constructor for creating a new MessageModel instance from a map (e.g., JSON).
  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    ownerType: _of(json['ownerType']),
    content: json['content'],
    createdAt: json['createdAt'],
    ownerName: json['ownerName'],
    avatar: json['avatar'],
    id: json['id'],
  );

  /// Converts the MessageModel instance to a map (e.g., for JSON serialization).
  /// Note: Enum types are not supported directly in JSON. They are stored as strings.
  Map<String, dynamic> toJson() => {
    'id': id,
    'ownerType': ownerType.toString(),
    'content': content,
    'createdAt': createdAt,
    'avatar': avatar,
    'ownerName': ownerName,
  };
}
