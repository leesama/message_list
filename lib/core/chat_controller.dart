import 'dart:async';

import 'package:flutter/widgets.dart';

import '../models/message_model.dart';
import '../widget/default_message_widget.dart';

class ChatController implements IChatController {
  final List<MessageModel> initialMessageList;
  final ScrollController scrollController;
  final MessageWidgetBuilder? messageWidgetBuilder;
  final int timePellet;
  List<int> pelletShow = [];

  StreamController<List<MessageModel>> messageStreamController =
      StreamController.broadcast();

  ChatController({
    required this.initialMessageList,
    required this.scrollController,
    required this.timePellet,
    this.messageWidgetBuilder,
  }) {
    _processInitialMessages();
  }

  void dispose() {
    messageStreamController.close();
    scrollController.dispose();
  }

  void widgetReady() {
    _emitMessageList();
    scrollToLastMessage();
  }

  @override
  void addMessage(MessageModel message) {
    if (messageStreamController.isClosed) return;
    _updateMessageTimeVisibility(message);
    initialMessageList.insert(0, message);
    _emitMessageList();
    scrollToLastMessage();
  }

  @override
  void loadMoreData(List<MessageModel> messageList) {
    List<MessageModel> reversedList = List.from(messageList.reversed);
    _clearTimeStamps();
    reversedList.forEach(_updateMessageTimeVisibility);
    initialMessageList.insertAll(0, reversedList);
    _emitMessageList();
  }

  void scrollToLastMessage() {
    if (!scrollController.hasClients) return;
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void _updateMessageTimeVisibility(MessageModel message) {
    var pellet = (message.createdAt / (timePellet * 1000)).truncate();
    message.showCreatedTime = !pelletShow.contains(pellet);
    if (message.showCreatedTime) pelletShow.add(pellet);
  }

  void _processInitialMessages() {
    initialMessageList.reversed.forEach(_updateMessageTimeVisibility);
  }

  void _clearTimeStamps() {
    pelletShow.clear();
  }

  void _emitMessageList() {
    if (!messageStreamController.isClosed) {
      messageStreamController.sink.add(initialMessageList);
    }
  }
}

abstract class IChatController {
  void addMessage(MessageModel message);
  void loadMoreData(List<MessageModel> messageList);
}
