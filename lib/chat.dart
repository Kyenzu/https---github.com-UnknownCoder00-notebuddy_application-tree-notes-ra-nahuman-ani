import 'package:flutter/material.dart';
import 'app_drawer.dart';
import 'search.dart';

class MyChat extends StatefulWidget {
  const MyChat({super.key});

  @override
  State<MyChat> createState() => _MyChat();
}

class _MyChat extends State<MyChat> {
  late String selectedItem;
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  final FocusNode _focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String? argument = ModalRoute.of(context)?.settings.arguments as String?;
    selectedItem = argument ?? 'AI Chat';
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(_controller.text);
        _controller.clear();
      });
    }
  }

  void _hideKeyboard() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        selectedItem: selectedItem,
        onItemSelected: (item) {
          setState(() {
            selectedItem = item;
          });
        },
      ),
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          selectedItem,
          style: const TextStyle(color: Colors.white70, fontSize: 20),
        ),
        iconTheme: const IconThemeData(color: Colors.white70),
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white70),
            onPressed: () {
              _hideKeyboard();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
        ],
      ),
      onDrawerChanged: (isOpened) {
        if (isOpened) {
          _hideKeyboard();
        }
      },
      body: GestureDetector(
        onTap: _hideKeyboard,
        child: Column(
          children: [
            Expanded(
              child: _messages.isEmpty
                  ? Center(
                      child: Text(
                        'How can I help you?',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      reverse: true,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final reversedIndex = _messages.length - 1 - index;
                        return _ChatBubble(message: _messages[reversedIndex]);
                      },
                    ),
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 16.0),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      style: const TextStyle(color: Colors.white70),
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: const TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: const Color(0xFF333333),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.white70),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: const Color(0xFF333333),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
