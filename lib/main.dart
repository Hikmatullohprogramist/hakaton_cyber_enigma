// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hakaton_cyber_enigma/splash.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;

@pragma("vm:entry-point")
callbackDispatcher() async {
  Workmanager().executeTask((taskName, inputData) async {
    Telephony telephony = Telephony.instance;

    final bool? result = await telephony.requestSmsPermissions;

    if (result != null && result) {
      // Listen for incoming SMS messages
      telephony.listenIncomingSms(
        onNewMessage: onMessage,
        listenInBackground: true,
        onBackgroundMessage: onBackgroundMessage,
      );
    }

    return Future.value(true);
  });
  // Request phone and SMS permissions
}

onMessage(SmsMessage message) async {
  String smsBody = message.body ?? "Error reading message body.";
  await sendRequest(smsBody);
}

@pragma('vm:entry-point')
onBackgroundMessage(SmsMessage message) async {
  String smsBody = message.body ?? "Error reading message body.";
  debugPrint("Background message: ${message.body}");

  sendRequest(smsBody);
}

Future<void> initPlatformState() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (initializationSettings) {});

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
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  Telephony telephony = Telephony.instance;

  final bool? result = await telephony.requestSmsPermissions;

  if (result != null && result) {
    // Listen for incoming SMS messages
    telephony.listenIncomingSms(
        onNewMessage: onMessage,
        listenInBackground: true,
        onBackgroundMessage: onBackgroundMessage);
  }
  // if (!mounted) return;
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
        // _messageType = "Spam xabar";
        showNotification(
          "Spam xabar",
          "Bu xabarda spam aniqlandi: $msgBody",
        );
      } else {
        // _messageType = "Oddiy xabar";
        print("Message is not spam");
      }
    } else {
      print("Failed to send SMS to API: ${response.reasonPhrase}");
    }
  } catch (e) {
    print("Error sending SMS to API: $e");
  }
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initPlatformState();
  // await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CyberEnigma',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
