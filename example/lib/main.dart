import 'package:message_list/core/chat_controller.dart';
import 'package:message_list/models/message_model.dart';
import 'package:message_list/widget/chat_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatMessage Example',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ChatMessage Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;
  final List<MessageModel> _messageList = [
    MessageModel(
        ownerType: OwnerType.receiver,
        content: 'ChatGPT是由OpenAI研发的聊天机器人程序',
        createdAt: 1772058683000,
        id: 2,
        avatar: 'https://o.devio.org/images/o_as/avatar/tx2.jpeg',
        ownerName: 'ChatGPT'),
    MessageModel(
        ownerType: OwnerType.receiver,
        content: '介绍一下ChatGPT',
        createdAt: 1771058683000,
        id: 1,
        avatar: 'https://o.devio.org/images/o_as/avatar/tx18.jpeg',
        ownerName: 'Imooc')
  ];
  late ChatController chatController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
              child: ChatList(
                chatController: chatController,
                onBubbleLongPress: (MessageModel message, BuildContext ancestor) {
                  debugPrint('onBubbleLongPress:${message.content}');
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: _loadMore, child: const Text('loadMore')),
              ElevatedButton(onPressed: _send, child: const Text('Send'))
            ],
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    chatController = ChatController(
        initialMessageList: _messageList,
        // messageWidgetBuilder: _diyMessageWidget,
        scrollController: ScrollController(),
        timePellet: 60);
  }

  void _send() {
    chatController.addMessage(MessageModel(
        ownerType: OwnerType.sender,
        content: 'Hello ${count++}',
        createdAt: DateTime.now().millisecondsSinceEpoch,
        avatar: 'https://o.devio.org/images/o_as/avatar/tx2.jpeg',
        ownerName: 'Imooc'));
    Future.delayed(const Duration(milliseconds: 2000), () {
      chatController.addMessage(
        MessageModel(
            ownerType: OwnerType.receiver,
            content: 'Nice',
            createdAt: DateTime.now().millisecondsSinceEpoch,
            avatar: 'https://o.devio.org/images/o_as/avatar/tx2.jpeg',
            ownerName: 'ChatGPT'),
      );
    });
  }

  int _counter = 0;

  void _loadMore() {
    var tl = 1772058683000;
    tl = tl - ++_counter * 1000000;
    final List<MessageModel> messageList = [
      MessageModel(
          ownerType: OwnerType.sender,
          content: 'Hello ${_counter++}',
          createdAt: DateTime.now().millisecondsSinceEpoch,
          avatar: 'https://o.devio.org/images/o_as/avatar/tx2.jpeg',
          ownerName: 'Imooc'),
      MessageModel(
          ownerType: OwnerType.receiver,
          content: 'Nice',
          createdAt: DateTime.now().millisecondsSinceEpoch,
          avatar: 'https://o.devio.org/images/o_as/avatar/tx2.jpeg',
          ownerName: 'ChatGPT')
    ];
    chatController.loadMoreData(messageList);
  }

  Widget _diyMessageWidget(MessageModel message) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      decoration: BoxDecoration(
          color: message.ownerType == OwnerType.sender
              ? Colors.amberAccent
              : Colors.redAccent),
      child: Text('${message.ownerName}: ${message.content}'),
    );
  }
}
