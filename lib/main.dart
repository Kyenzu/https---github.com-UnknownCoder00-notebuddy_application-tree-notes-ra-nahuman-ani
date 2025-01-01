import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:notebuddy_application/device.dart';
import 'note_text_field.dart';
import 'app_drawer.dart';
import 'settings.dart'; // Import your settings screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system; // Default to system theme

  // Update the theme mode
  void _updateThemeMode(ThemeMode theme) {
    setState(() {
      _themeMode = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode, // Ensure the themeMode is updated here
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF121212),
        scaffoldBackgroundColor: const Color(0xFF121212),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white70)),
      ),
      home: HomeScreen(
        onThemeModeChanged: _updateThemeMode, // Pass the callback
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final void Function(ThemeMode) onThemeModeChanged; // Callback to update theme

  const HomeScreen({required this.onThemeModeChanged, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDialOpen = false;
  String selectedItem = 'Notes'; // Track selected item
  final FocusNode _searchFocusNode = FocusNode(); // FocusNode for the search field

  final List<String> notes = [
    "Buy groceries!",
    "Finish Flutter project.",
    "Add more features to the app.",
    "Happy new year.",
    "Go to gym at 6 PM.",
   '''Lyrics
Wala nang dating pagtingin
Sawa na ba saking lambing
Wala ka namang dahilan
Bakit bigla na lang nang iwan
Di na alam ang gagawin
Upang ika'y magbalik sa'kin
Ginawa ko naman ang lahat
Bakit bigla na lang naghanap
Hindi magbabago
Pagmamahal sa iyo
Sana'y pakinggan mo
Ang awit ng pusong ito
Tulad ng mundong hindi
Tumitigil sa pag-ikot
Pag ibig di mapapagod
Tulad ng ilog na hindi
Tumitigil sa pag agos
Pag ibig di matatapos
Alaala'y bumabalik
Mga panahong nasasabik
Sukdulang mukha mo ay
Laging nasa panaginip
Bakit biglang pinagpalit
Pagsasamaha'y tila nawaglit
Ang dating walang hanggan
Nagkaroon ng katapusan
Hindi magbabago
Pagmamahal sa iyo
Sana'y pakinggan mo
Ang awit ng pusong ito
Tulad ng mundong hindi
Tumitigil sa pag-ikot
Pag ibig di mapapagod
Tulad ng ilog na hindi
Tumitigil sa pag agos
Pag ibig di matatapos
Tulad ng mundong hindi
Tumitigil sa pag-ikot
Pag ibig di mapapagod
Tulad ng ilog na hindi
Tumitigil sa pag agos
Pag ibig di matatapos
Tumitigil (pag ibig di matatapos)
Tumitigil
Pag-ibig di matatapos''',
    'Prepare for presentation',
    'Clean the house',
    'Read a book',
    'Work on personal blog',
    'Plan weekend trip',
    'Exercise for 30 minutes',
  ]; // Placeholder for notes

  @override
  void dispose() {
    // Clean up the focus node when the widget is disposed
    _searchFocusNode.dispose();
    super.dispose();
  }

  void updateSelectedItem(String item) {
    setState(() {
      selectedItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: _buildSearchBar(context),
      ),
      body: Center(
        child: notes.isEmpty
            ? const Text(
                'No notes available',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16.0),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(color: Colors.white70, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      notes[index],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: _buildSpeedDial(context),
      drawer: AppDrawer(
        selectedItem: selectedItem,
        onItemSelected: (item) {
          if (item == 'Settings') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MySettings(
                  onThemeChanged: widget.onThemeModeChanged,
                ),
              ),
            );
          } else {
            updateSelectedItem(item);
          }
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white70),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(_searchFocusNode);
              },
              child: TextField(
                focusNode: _searchFocusNode,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: const InputDecoration(
                  hintText: 'Search your notes',
                  hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Handle profile action
            },
            child: const CircleAvatar(
              backgroundImage:
                  AssetImage('assets/profile_picture.jpg'), // Replace with your asset
              radius: 15,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildSpeedDial(BuildContext context) {
    return SpeedDial(
      foregroundColor: Colors.black87,
      backgroundColor: Colors.white70,
      icon: isDialOpen ? Icons.close : Icons.add,
      activeIcon: Icons.close,
      spacing: 10,
      overlayColor: Colors.black,
      animationDuration: const Duration(milliseconds: 200),
      onOpen: () => setState(() => isDialOpen = true),
      onClose: () => setState(() => isDialOpen = false),
      children: [
        SpeedDialChild(
          backgroundColor: Colors.white24,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: const Icon(Icons.text_fields, color: Colors.white70),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NoteTextField()),
          ),
        ),
        SpeedDialChild(
          backgroundColor: Colors.white24,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: const Icon(Icons.image, color: Colors.white70),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NoteTextField()),
          ),
        ),
        SpeedDialChild(
          backgroundColor: Colors.white24,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: const Icon(Icons.brush, color: Colors.white70),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NoteTextField()),
          ),
        ),
        SpeedDialChild(
          backgroundColor: Colors.white24,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: const Icon(Icons.speaker_outlined, color: Colors.white70),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyDevice()),
          ),
        ),
      ],
    );
  }
}
