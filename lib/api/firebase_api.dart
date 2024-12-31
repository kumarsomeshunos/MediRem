import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// Initialize Firebase Notifications
  Future<void> initNotifications() async {
    await _requestPermissions();
    await _getToken();
    _handleForegroundMessages();
    _handleBackgroundMessageClick();
  }

  /// Request notification permissions
  Future<void> _requestPermissions() async {
    final settings = await _firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission: ${settings.authorizationStatus}');
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print('User denied permission.');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission.');
    } else {
      print('Permission status: ${settings.authorizationStatus}');
    }
  }

  /// Retrieve the FCM token
  Future<void> _getToken() async {
    try {
      final fcmToken = await _firebaseMessaging.getToken();
      if (fcmToken != null) {
        print('FCM Token: $fcmToken');
        // Send token to your server if needed
      } else {
        print('Failed to get FCM token.');
      }
    } catch (e) {
      print('Error retrieving FCM token: $e');
    }
  }

  /// Handle foreground notifications
  void _handleForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        print('Foreground message received: ${notification.title}');
        print('Body: ${notification.body}');
        // Show local notification or update UI
      }
    });
  }

  /// Handle notifications opened from background
  void _handleBackgroundMessageClick() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        print('Notification opened: ${notification.title}');
        print('Body: ${notification.body}');
        // Handle navigation or logic when notification is clicked
      }
    });
  }
}
