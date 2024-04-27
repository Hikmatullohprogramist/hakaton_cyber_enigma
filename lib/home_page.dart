import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hakaton_cyber_enigma/bottom_screens/settings_page.dart';
import 'package:hakaton_cyber_enigma/bottom_screens/spam_page.dart';
import 'package:hakaton_cyber_enigma/bottom_screens/main_home_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _pages = [MainHomePage(), SpamPage(), SettingsPage()];

  int selectedIndex = 0;

  onTap(int index) {
    selectedIndex = index;
    setState(() {});
  }

  Widget appBarImg() {
    if (selectedIndex == 0) {
      return Image.asset("assets/title_logo.png");
    } else if (selectedIndex == 1) {
      return Image.asset("assets/title_spam.png");
    } else if (selectedIndex == 2) {
      return Image.asset("assets/title_settings.png");
    }
    // Provide a default return value
    return Text("TITLE");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF282828),
      bottomNavigationBar: Container(
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        decoration: const BoxDecoration(
            color: Color(0xFF333333),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 36,
                offset: Offset(0, 5),
                spreadRadius: 0,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () => onTap(0),
                icon: Icon(
                  Icons.home,
                  color: selectedIndex == 0 ? Colors.white : Colors.grey,
                  size: 40,
                )),
            IconButton(
                onPressed: () => onTap(1),
                icon: Icon(
                  Icons.error,
                  color: selectedIndex == 1 ? Colors.white : Colors.grey,
                  size: 40,
                )),
            IconButton(
                onPressed: () => onTap(2),
                icon: Icon(
                  Icons.settings,
                  size: 40,
                  color: selectedIndex == 2 ? Colors.white : Colors.grey,
                )),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: appBarImg(),
      ),
      body: _pages[selectedIndex],
    );
  }
}

//**
// */
class SwitchWidget extends StatefulWidget {
  SwitchWidget({Key? key}) : super(key: key);

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text("Spam xabarlar"),
        subtitle: const Text("Spam xabarlarni tekshirish"),
        trailing: Switch(
          value: _switchValue,
          onChanged: (newValue) {
            setState(() {
              _switchValue = newValue;
            });
          },
        ),
      ),
    );
  }
}
