import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode _focusNode = FocusNode(); // FocusNode to manage focus

  @override
  void initState() {
    super.initState();
    // Request focus as soon as the page is displayed
    Future.delayed(Duration(milliseconds: 100), () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose of the focus node when the widget is destroyed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Background color
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white70),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        backgroundColor: Colors.white10,  // Same color as background
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white70),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            focusNode: _focusNode, // Attach the FocusNode to the TextField
            style: const TextStyle(color: Colors.white70),
            decoration: const InputDecoration(
              hintText: 'Search your notes...',
              hintStyle: TextStyle(color: Colors.white38),
              border: InputBorder.none, // No border
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Just an example, adjust as necessary
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Search Result #$index', // Example search result
                      style: const TextStyle(color: Colors.white70),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
