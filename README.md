# ChatMessage Flutter Package

This Flutter package is designed to help developers quickly build chat interfaces, offering a complete set of chat functionality components including message display, time formatting, and custom message bubbles.

[English](README.md) | [中文](README_CN.md)

## Features

- **Message List Display**: Use the `ChatList` component to display a list of chat messages.
- **Time Display Formatting**: `WechatDateFormat` offers a WeChat-style time display.
- **Custom Message Components**: Customize the style of message bubbles for both senders and receivers.
- **Message Controller**: `ChatController` is responsible for adding messages, loading more, and other logic.
- **Dynamic Message Loading**: Supports dynamically adding new messages or loading more messages into the chat interface.

## Installation

Add this line to your Flutter project's `pubspec.yaml` file under dependencies:

```yaml
dependencies:
  message_list: ^latest_version
```

Then run `flutter pub get` to install the package.

## Quick Start

First, you need to import the necessary packages into your Flutter project:

```dart
import 'package:message_list/core/chat_controller.dart';
import 'package:message_list/models/message_model.dart';
import 'package:message_list/widget/chat_list.dart';
import 'package:flutter/material.dart';
```

### Create a Message Model

You can create a message by using the `MessageModel`. An example is shown below:

```dart
MessageModel(
    ownerType: OwnerType.receiver,
    content: 'Hello, this is a message.',
    createdAt: DateTime.now().millisecondsSinceEpoch,
    avatar: 'URL_TO_AVATAR',
    ownerName: 'Sender Name')
```

### Using `ChatController` and `ChatList`

`ChatController` is used to manage chat messages and states, while `ChatList` is the component for displaying chat messages. Example code is as follows:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatController = ChatController(
      initialMessageList: [], // Initial message list
      scrollController: ScrollController(),
      timePellet: 60,
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('ChatMessage Example')),
        body: ChatList(chatController: chatController),
      ),
    );
  }
}
```

### Adding and Loading Messages

You can dynamically add or load more messages by using the `addMessage` and `loadMoreData` methods of `ChatController`. Example code is as follows:

```dart
chatController.addMessage(MessageModel(
    ownerType: OwnerType.sender,
    content: 'New message',
    createdAt: DateTime.now().millisecondsSinceEpoch,
    avatar: 'URL_TO_AVATAR',
    ownerName: 'Sender Name'));
```

## Customizing Message Bubbles

You can customize the appearance of each message by implementing `MessageWidgetBuilder` and then passing it to `ChatController`.

## Example Application

Below is a simple chat application example that demonstrates how to use the `message_list` package to build a chat interface.

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The root of your application.
    return MaterialApp(
      title: 'ChatMessage Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'ChatMessage Example'),
    );
  }
}
```

In `MyHomePage`, you can create a `ChatController` and use it with `ChatList` to display chat messages, providing functionality for sending messages and loading more messages.

## Conclusion

The `message_list` package provides a simple yet powerful set of tools for Flutter chat applications, allowing developers to easily integrate chat functionality into their apps. With customizable message components and controllers, developers can build unique and rich chat experiences.

We hope this README helps you get started with using the `message_list` package to build your chat application. If you have any questions or suggestions, please do not hesitate to contact the package maintainer on pub.dev.