// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:telephony/telephony.dart';

// import 'sms_service.dart';

// void init() {
//   SmsService smsService = SmsService();
//   NotificationService notificationService = NotificationService();
//   notificationService.initNotification(smsService);
// }

// void backgroundMessageHandler(SmsMessage message) async {
//   await SmsService().sendRequest(message.body ?? "Empty message");
// }

// class NotificationService {
//   late FlutterLocalNotificationsPlugin notificationManager;

//   Future<void> initNotification(SmsService smsService) async {
//     WidgetsFlutterBinding.ensureInitialized();

//     // Initialize notification manager
//     notificationManager = FlutterLocalNotificationsPlugin();

//     // Initialize Android notification settings
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     // Initialize overall notification settings
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: DarwinInitializationSettings(),
//     );

//     // Initialize notification manager with settings
//     await notificationManager.initialize(initializationSettings);

//     // Request permissions and listen for incoming SMS
//     final bool? result =
//         await smsService.telephony.requestPhoneAndSmsPermissions;

//     if (result != null && result) {
//       smsService.telephony.listenIncomingSms(
//         onNewMessage: (msg) {
//           print("${msg.body ?? ""} NEW MESSAGE");
//         },
//         onBackgroundMessage: (msg) {
//           print("${msg.body ?? ""} Background MESSAGE");
//         },
//         listenInBackground: true,
//       );
//     }
//   }

//   Future<void> showNotification(String title, String subTitle) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'your channel id',
//       'your channel name',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await notificationManager.show(
//       0,
//       title,
//       subTitle,
//       platformChannelSpecifics,
//       payload: 'item x',
//     );
//   }
// }
