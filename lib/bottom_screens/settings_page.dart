import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isTrue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF282828),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              color: const Color(0xFF3B3B3B),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: ListTile(
                  title: const Text(
                    "Notification",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: const Icon(
                    Icons.notifications,
                    size: 40,
                    color: Colors.white,
                  ),
                  trailing: Switch(
                    value: isTrue,
                    onChanged: (bool a) {
                      isTrue = a;

                      print(isTrue);
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Card(
              color: const Color(0xFF3B3B3B),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: const ListTile(
                  title: Text(
                    "Language",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.translate,
                    size: 40,
                    color: Colors.white,
                  ),
                  trailing:
                      Text("English", style: TextStyle(color: Colors.grey)),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Card(
              color: const Color(0xFF3B3B3B),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: const ListTile(
                  title: Text(
                    "About",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.info,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
