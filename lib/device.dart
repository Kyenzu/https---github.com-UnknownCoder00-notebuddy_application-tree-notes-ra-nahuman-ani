import 'package:flutter/material.dart';
import 'app_drawer.dart';
import 'search.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'note_text_field.dart';

class MyDevice extends StatefulWidget {
  const MyDevice({super.key});

  @override
  State<MyDevice> createState() => _MyDevice();
}

class _MyDevice extends State<MyDevice> {
  bool isDialOpen = false; // Track the state of the SpeedDial toggle
  late String selectedItem; // The selected item passed from AppDrawer

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch the argument passed from the drawer to set the selected item
    final String? argument =
        ModalRoute.of(context)?.settings.arguments as String?;
    if (argument != null) {
      selectedItem = argument; // Update selected item
    } else {
      selectedItem = 'Device'; // Default value
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        selectedItem: selectedItem, // Pass the selectedItem to AppDrawer
        onItemSelected: (item) {
          setState(() {
            selectedItem = item; // Ensure selectedItem gets updated
          });
        },
      ),
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          selectedItem, // Dynamically update title based on the selected item
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white70),
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        actions: [
          IconButton(
            icon:
                const Icon(Icons.search, color: Colors.white70), // Search icon
            onPressed: () {
              // Handle search functionality here
              // For example, show a search bar, open a new page, or something else
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Device will appear here', // Placeholder for Reminders content
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white54,
        icon: isDialOpen ? Icons.close : Icons.add,
        activeIcon: Icons.close, // Icon when the dial is open
        spacing: 10,
        overlayColor: Colors.black,
        animationDuration: const Duration(milliseconds: 200),
        onOpen: () => setState(
            () => isDialOpen = true), // Set the state when SpeedDial opens
        onClose: () => setState(
            () => isDialOpen = false), // Set the state when SpeedDial closes
        children: [
          SpeedDialChild(
            backgroundColor: Colors.white24,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: const Icon(
              Icons.text_fields,
              color: Colors.white70,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NoteTextField()),
              );
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.white24,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: const Icon(
              Icons.image,
              color: Colors.white70,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NoteTextField()),
              );
            },
          ),
           SpeedDialChild(
            backgroundColor: Colors.white24,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: const Icon(
              Icons.brush,
              color: Colors.white70,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NoteTextField()),
              );
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.white24,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: const Icon(
              Icons.speaker_outlined,
              color: Colors.white70,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyDevice()),
              );
            },
          ),
        ],
      ),
    );
  }
}
