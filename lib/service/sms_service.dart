// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:telephony/telephony.dart';
// import 'notification_service.dart';

// class SmsService {
//   final Telephony telephony = Telephony.instance;

//   bool _isInitialized = false; // Add a flag to track initialization status

//   void init() {
//     if (!_isInitialized) {
//       notification.initNotification(SmsService());
//       _isInitialized = true;
//     }
//   }

//   String _messageType = "";

//   void onMessage(SmsMessage message) async {
//     String smsBody = message.body ?? "Error reading message body.";
//     await sendRequest(smsBody);
//   }

//   onBackgroundMessage(SmsMessage message) async {
//     String smsBody = message.body ?? "Error reading message body.";
//     debugPrint("Background message: $smsBody");
//     await sendRequest(smsBody);
//   }

//   Future<void> sendRequest(String msgBody) async {
//     String apiUrl = "https://api.cyberenigma.uz/analiz?msg=$msgBody";

//     try {
//       var response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         var responseData = jsonDecode(response.body);
//         print(responseData);

//         if (responseData['status'] == 'spam') {
//           _messageType = "Spam xabar";
//           notification.showNotification(
//             "Diqqat",
//             "Ushbu xabarda spam xabar topildi : $msgBody",
//           );
//         } else {
//           _messageType = "Oddiy xabar";
//           print("Message is not spam");
//         }
//       } else {
//         print("Failed to send SMS to API: ${response.reasonPhrase}");
//       }
//     } catch (e) {
//       print("Error sending SMS to API: $e");
//     }
//   }
// }
