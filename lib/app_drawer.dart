import 'package:flutter/material.dart';
import 'package:notebuddy_application/settings.dart';
import 'package:notebuddy_application/chat.dart';
import 'package:notebuddy_application/device.dart';
import 'package:notebuddy_application/archive.dart';
import 'package:notebuddy_application/reminders.dart';
import 'package:notebuddy_application/trash.dart';
import 'main.dart';

class AppDrawer extends StatelessWidget {
  final String selectedItem;
  final Function(String) onItemSelected;

  const AppDrawer({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF121212),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Wrapping DrawerHeader with Theme to remove divider line
          Theme(
            data: Theme.of(context).copyWith(
              dividerTheme: const DividerThemeData(color: Colors.transparent),
            ),
            child: const DrawerHeader(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Color(0xFF121212), // Same color as background
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'NoteBuddy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _buildRoundedTile(
            title: 'Notes',
            icon: Icons.note_add_outlined,
            isSelected: selectedItem == 'Notes',
            onTap: () {
              _navigateTo(context, 'Notes', const MyApp());
            },
          ),
          _buildRoundedTile(
            title: 'Reminders',
            icon: Icons.notification_add_outlined,
            isSelected: selectedItem == 'Reminders',
            onTap: () {
              _navigateTo(context, 'Reminders', const MyReminder());
            },
          ),
          _buildRoundedTile(
            title: 'AI Chat',
            icon: Icons.bubble_chart_outlined,
            isSelected: selectedItem == 'AI Chat',
            onTap: () {
              _navigateTo(context, 'AI Chat', const MyChat());
            },
          ),
          _buildRoundedTile(
            title: 'Device',
            icon: Icons.speaker_outlined,
            isSelected: selectedItem == 'Device',
            onTap: () {
              _navigateTo(context, 'Device', const MyDevice());
            },
          ),
          _buildRoundedTile(
            title: 'Archive',
            icon: Icons.archive_outlined,
            isSelected: selectedItem == 'Archive',
            onTap: () {
              _navigateTo(context, 'Archive', const MyArchive());
            },
          ),
          _buildRoundedTile(
            title: 'Trash',
            icon: Icons.delete_outlined,
            isSelected: selectedItem == 'Trash',
            onTap: () {
              _navigateTo(context, 'Trash', const MyTrash());
            },
          ),
          _buildRoundedTile(
            title: 'Settings',
            icon: Icons.settings_outlined,
            isSelected: selectedItem == 'Settings',
            onTap: () {
              _navigateTo(context, 'Settings', MySettings(onThemeChanged: (theme) {
                // Handle theme change
              }));
            },
          ),
        ],
      ),
    );
  }

  // Function to handle navigation with smoother transition duration
  void _navigateTo(BuildContext context, String item, Widget destinationPage) {
    // Close the drawer immediately
    Navigator.pop(context);

    // Add a small delay to ensure the drawer closes before navigating
    Future.delayed(const Duration(milliseconds: 150), () {
      // Update the selected item and navigate to the new page
      onItemSelected(item);

      // Navigate with a smooth default transition (using PageRouteBuilder)
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              destinationPage,
          transitionDuration: const Duration(milliseconds: 500), // Slower transition pace
        ),
      );
    });
  }

  // Widget to build the rounded tiles
  Widget _buildRoundedTile({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white24 : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white70),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        onTap: onTap,
      ),
    );
  }
}
