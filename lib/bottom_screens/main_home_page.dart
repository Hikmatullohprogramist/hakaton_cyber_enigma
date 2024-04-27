// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:telephony/telephony.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  bool isStartAnimation = false;
  String _message = "";
  String _messageType = "";
  final telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void onMessage(SmsMessage message) async {
    String smsBody = message.body ?? "Error reading message body.";
    sendRequest(smsBody);
    setState(() {
      _message = message.body ?? "Error reading message body.";
    });
  }

  onBackgroundMessage(SmsMessage message) async {
    String smsBody = message.body ?? "Error reading message body.";
    debugPrint("Background message: ${message.body}");
  }

  sendRequest(String msgBody) async {
    String apiUrl = "https://api.cyberenigma.uz/analiz?msg=$msgBody";

    try {
      var response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print(responseData);

        if (responseData['status'] == 'spam') {
          _messageType = "Spam xabar";
          showNotification(
            "Spam xabar",
            "Bu xabarda spam aniqlandi: $msgBody",
          );
        } else {
          _messageType = "Oddiy xabar";
          print("Message is not spam");
        }
      } else {
        print("Failed to send SMS to API: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error sending SMS to API: $e");
    }
  }

  void showNotification(String title, String body) async {
    var androidDetails = const AndroidNotificationDetails(
      'channel_id',
      'Channel Name',
      priority: Priority.high,
      importance: Importance.high,
      ticker: 'ticker',
    );
    var platformChannelSpecifics = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'New Payload',
    );
  }

  Future<void> initPlatformState() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (initializationSettings) {});

    // Request phone and SMS permissions
    final bool? result = await telephony.requestPhoneAndSmsPermissions;

    if (result != null && result) {
      // Listen for incoming SMS messages
      telephony.listenIncomingSms(
        onNewMessage: onMessage,
        onBackgroundMessage: onBackgroundMessage,
        listenInBackground: true,
      );
    }

    // Handle background notification interaction
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'background_notification_channel',
      'Background Notification Channel',
      importance: Importance.high,
      playSound: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Set up the callback for handling background notifications
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: (payload) async {
      debugPrint("Background notification selected: $payload");
    });

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              isStartAnimation = !isStartAnimation;
              if (isStartAnimation) {}
              setState(() {});
            },
            child: Stack(
              children: [
                Lottie.asset(
                  animate: isStartAnimation,
                  "assets/animation.json",
                ),
                Image.asset("assets/logo_remove_bg.png")
              ],
            ),
          ),
          Text(
            "CyberEnigma is ${isStartAnimation ? "started" : "stopped"}",
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
