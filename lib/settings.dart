import 'package:flutter/material.dart';
import 'app_drawer.dart';

class MySettings extends StatefulWidget {
  final void Function(ThemeMode) onThemeChanged; // Callback to update theme mode

  const MySettings({required this.onThemeChanged, super.key});

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  late String selectedItem; // The selected item passed from AppDrawer
  late ThemeMode _themeMode; // To track the theme mode (light, dark, system)

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch the argument passed from the drawer to set the selected item
    final String? argument =
        ModalRoute.of(context)?.settings.arguments as String?;
    if (argument != null) {
      selectedItem = argument; // Update selected item
    } else {
      selectedItem = 'Settings'; // Default value
    }

    // Get current theme mode from system
    _themeMode = ThemeMode.system; // Default to system theme
  }

  // Function to update theme mode
  void _updateThemeMode(ThemeMode theme) {
    setState(() {
      _themeMode = theme;
    });
    widget.onThemeChanged(theme); // Notify parent to update theme
  }

  // Function to show theme selection dialog
  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF121212),
          title: const Text(
            'Select Theme Mode',
            style: TextStyle(color: Colors.white70),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text(
                  'Light Mode',
                  style: TextStyle(color: Colors.white70),
                ),
                onTap: () {
                  _updateThemeMode(ThemeMode.light);
                  Navigator.of(context).pop(); // Close dialog
                },
              ),
              ListTile(
                title: const Text(
                  'Dark Mode',
                  style: TextStyle(color: Colors.white70),
                ),
                onTap: () {
                  _updateThemeMode(ThemeMode.dark);
                  Navigator.of(context).pop(); // Close dialog
                },
              ),
              ListTile(
                title: const Text(
                  'System Default',
                  style: TextStyle(color: Colors.white70),
                ),
                onTap: () {
                  _updateThemeMode(ThemeMode.system);
                  Navigator.of(context).pop(); // Close dialog
                },
              ),
            ],
          ),
        );
      },
    );
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          selectedItem, // Dynamically update title based on the selected item
          style: const TextStyle(color: Colors.white70),
        ),
        iconTheme: const IconThemeData(color: Colors.white70),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Display',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _showThemeDialog, // Show dialog on tap
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Theme',
                    style: TextStyle(color: Colors.white70),
                  ),
                  // Display the selected theme on the right
                  Text(
                    _themeMode == ThemeMode.light
                        ? 'Light Mode'
                        : _themeMode == ThemeMode.dark
                            ? 'Dark Mode'
                            : 'System Default',
                    style: const TextStyle(color: Colors.white70),
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
