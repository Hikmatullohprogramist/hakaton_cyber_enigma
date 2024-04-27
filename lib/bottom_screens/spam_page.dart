import 'package:flutter/material.dart';

class SpamPage extends StatefulWidget {
  const SpamPage({super.key});

  @override
  State<SpamPage> createState() => _SpamPageState();
}

class _SpamPageState extends State<SpamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF282828),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemBuilder: (ctx, index) => Container(
            child: Card(
              color: const Color(0xFF3B3B3B),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: const ListTile(
                  title: Text(
                    "+998 94 *** ** 45",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "Prezident 1 000 000 so’mdan",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.error,
                    size: 40,
                    color: Colors.white,
                  ),
                  trailing: Text(
                    "11:09",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
