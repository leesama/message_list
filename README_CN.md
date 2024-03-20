# ChatMessage Flutter Package

这个Flutter包是为了帮助开发者快速构建聊天界面而设计的，提供了一套完整的聊天功能组件，包括消息显示、时间格式化以及自定义消息泡泡等功能。

[中文](README_CN.md) | [English](README.md) 

    
## 特性

- **消息列表显示**：通过`ChatList`组件，可以展示聊天消息列表。
- **时间显示格式化**：`WechatDateFormat`提供了微信风格的时间显示。
- **自定义消息组件**：可以自定义消息泡泡的样式，包括发送者和接收者的不同样式。
- **消息控制器**：`ChatController`负责消息的添加、加载更多等逻辑处理。
- **动态消息加载**：支持动态地向聊天界面添加新消息或加载更多消息。

## 安装

将此行添加到你的Flutter项目的`pubspec.yaml`文件中的依赖项：

```yaml
dependencies:
  message_list: ^最新版本
```

然后运行`flutter pub get`来安装包。

## 快速开始

首先，你需要在你的Flutter项目中导入必要的包：

```dart
import 'package:message_list/core/chat_controller.dart';
import 'package:message_list/models/message_model.dart';
import 'package:message_list/widget/chat_list.dart';
import 'package:flutter/material.dart';
```

### 创建消息模型

可以通过`MessageModel`来创建消息。示例如下：

```dart
MessageModel(
    ownerType: OwnerType.receiver,
    content: 'Hello, this is a message.',
    createdAt: DateTime.now().millisecondsSinceEpoch,
    avatar: 'URL_TO_AVATAR',
    ownerName: 'Sender Name')
```

### 使用`ChatController`和`ChatList`

`ChatController`用于管理聊天消息和状态，而`ChatList`则是显示聊天消息的组件。示例代码如下：

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatController = ChatController(
      initialMessageList: [], // 初始消息列表
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

### 添加和加载消息

你可以使用`ChatController`的`addMessage`和`loadMoreData`方法来动态添加或加载更多消息。示例代码如下：

```dart
chatController.addMessage(MessageModel(
    ownerType: OwnerType.sender,
    content: 'New message',
    createdAt: DateTime.now().millisecondsSinceEpoch,
    avatar: 'URL_TO_AVATAR',
    ownerName: 'Sender Name'));
```

## 自定义消息泡泡

你可以通过实现`MessageWidgetBuilder`来自定义每个消息的显示方式，然后将其传递给`ChatController`。

## 示例应用

以下是一个简单的聊天应用示例，演示了如何使用`message_list`包来构建一个聊天界面。

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 应用程序的根。
    return MaterialApp(
      title: 'ChatMessage Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'ChatMessage Example'),
    );
  }
}
```

在`MyHomePage`中，你可以创建一个`ChatController`并将其与`ChatList`一起使用，来展示聊天消息，并提供发送消息和加载更多消息的功能。

## 结论

`message_list`包为Flutter聊天应用提供了一套简单而强大的工具，让开发者可以轻松地集成聊天功能到他们的应用中。通过自定义消息组件和控制器，开发者可以构建出独特而丰富的聊天体验。

希望这个README能够帮助你快速开始使用`message_list`包来构建你的聊天应用。如果你有任何问题或建议，请不要

犹豫在pub.dev上联系包的维护者。