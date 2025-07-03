import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatIA',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: ChatScreen(),
    );
  }
}

class ChatMessage {
  final String text;
  final DateTime timestamp;
  final bool isMe;

  ChatMessage({
    required this.text,
    required this.timestamp,
    required this.isMe,
  });
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.insert(
        0,
        ChatMessage(text: text, timestamp: DateTime.now(), isMe: true),
      );
    });

    _controller.clear();

    // Simula una respuesta del "otro usuario"
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            text: 'Respuesta automática a: $text',
            timestamp: DateTime.now(),
            isMe: false,
          ),
        );
      });
    });
  }

  Widget _buildMessage(ChatMessage message) {
    final time = DateFormat.Hm().format(message.timestamp);

    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: message.isMe ? Colors.teal[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: message.isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(message.text, style: TextStyle(fontSize: 16)),
            SizedBox(height: 4),
            Text(time, style: TextStyle(fontSize: 10, color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                onSubmitted: _sendMessage,
                decoration: InputDecoration(
                  hintText: 'Escribe un mensaje...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.send, color: Colors.teal),
              onPressed: () => _sendMessage(_controller.text),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat Personalizado')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) => _buildMessage(_messages[index]),
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }
}
