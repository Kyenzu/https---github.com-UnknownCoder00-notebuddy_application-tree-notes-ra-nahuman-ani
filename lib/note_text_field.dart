import 'package:flutter/material.dart';

class NoteTextField extends StatefulWidget {
  const NoteTextField({super.key});

  @override
  State<NoteTextField> createState() => _NoteTextField();
}

class _NoteTextField extends State<NoteTextField> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white70,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              style: TextStyle(
                fontSize: 24,
                color: Colors.white70,
              ),
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                  color: Colors.white70,
                ),
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: TextField(
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
                decoration: InputDecoration(
                  hintText: 'Note',
                  hintStyle: TextStyle(
                    color: Colors.white70,
                  ),
                  border: InputBorder.none,
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF121212),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_box_outlined,
                color: Colors.white70,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.color_lens_outlined,
                color: Colors.white70,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.text_format,
                color: Colors.white70,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.attach_file_outlined,
                color: Colors.white70,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
