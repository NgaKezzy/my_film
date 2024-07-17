import 'package:app/config/print_color.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  printGreen('Title : ${message.notification!.title}');
  printGreen('Body : ${message.notification!.body}');
  printGreen('Payload : ${message.data}');
}

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    final FCMToken = await firebaseMessaging.getToken();
    printGreen('Token : $FCMToken');

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      printGreen('Thông báo khi ứng dụng đang mở');
    });
  }
}
