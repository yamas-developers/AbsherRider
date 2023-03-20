import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class FirebaseHelper extends ChangeNotifier {
  // static String users = "/admin";
  StreamSubscription<DatabaseEvent>? chatMessagesRef = null;
  final database = FirebaseDatabase.instance;
  var newOrderRef = null;
  bool initNewOrderFun = false;

  initNewOrder(riderId, {onSuccess = null, onError = null}) async {
    if(newOrderRef != null){
      newOrderRef.cancel;
      newOrderRef = null;
    }

    newOrderRef = database.ref("riders/${riderId}/new_order").onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null && initNewOrderFun) {
        notifyListeners();
        debugPrint(event.snapshot.value.toString());
        if (onSuccess != null) onSuccess(event);
      }
      initNewOrderFun = true;
      notifyListeners();
    }, onError: (error) {
      if (onError != null) onError(error);
    });
  }
// initChatMessagesNotifications() async {
//   User user = (await getUser())!;
//   if(chatMessagesRef != null){
//     chatMessagesRef!.cancel();
//   }
//   chatMessagesRef = database
//       .ref("users/${user.id}/chat_notifications")
//       .onValue
//       .listen((event) {
//     if(event.snapshot.value != null) {
//       chatMessageNotifications = (event.snapshot.value as Map)['count'];
//       if(chatMessageNotifications > 0 && initChatNotification){
//         showSnakBar(title: "New Message", message: "You have received new message");
//       }
//       initChatNotification = true;;
//       notifyListeners();
//       debugPrint(event.snapshot.value.toString());
//     }
//   }, onError: (error) {});
// }
//
// setLocalNotification(count) async {
//   User user = (await getUser())!;
//   database.ref('users/${user.id}/user_notification').set({"count": 0});
// }
// setMessageNotification({required userId, required count, required message}){
//   print('users/${userId}/chat_notifications');
//   database.ref('users/${userId}/chat_notifications').set({"count": count,"message":"${message}"});
// }

}
