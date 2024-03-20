import 'package:flutter/material.dart';
import '../core/chat_controller.dart';
import '../models/message_model.dart';
import 'default_message_widget.dart';

/// A widget that displays a list of chat messages.
/// It uses a [ChatController] to manage chat state and interactions.
class ChatList extends StatefulWidget {
  /// Controller for chat-related actions and data.
  final ChatController chatController;

  /// Optional padding to be applied to the chat list.
  final EdgeInsetsGeometry? padding;

  /// Callback for when a chat bubble is tapped.
  final OnBubbleClick? onBubbleTap;

  /// Callback for when a chat bubble is long-pressed.
  final OnBubbleClick? onBubbleLongPress;

  const ChatList({
    Key? key,
    required this.chatController,
    this.padding,
    this.onBubbleTap,
    this.onBubbleLongPress,
  }) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    // Using Align with Alignment.topCenter to address alignment issues when there are few messages.
    return Align(
      alignment: Alignment.topCenter,
      child: _chatStreamBuilder,
    );
  }

  @override
  void initState() {
    super.initState();
    widget.chatController.widgetReady();
  }

  @override
  void dispose() {
    widget.chatController.dispose();
    super.dispose();
  }

  /// Builds the UI based on the chat message stream.
  Widget get _chatStreamBuilder => StreamBuilder<List<MessageModel>>(
    stream: widget.chatController.messageStreamController.stream,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.active) {
        return ListView.builder(
          shrinkWrap: true,
          reverse: true,
          padding: widget.padding,
          controller: widget.chatController.scrollController,
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            var model = snapshot.data![index];
            return DefaultMessageWidget(
              key: model.key,
              message: model,
              messageWidget: widget.chatController.messageWidgetBuilder,
              onBubbleTap: widget.onBubbleTap,
              onBubbleLongPress: widget.onBubbleLongPress,
            );
          },
        );
      } else {
        // Shows a loading spinner while waiting for messages.
        return const Center(child: CircularProgressIndicator());
      }
    },
  );
}
