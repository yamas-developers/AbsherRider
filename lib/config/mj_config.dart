
import 'package:firebase_core/firebase_core.dart';

class MJConfig{

  static const String mj_session_token = "session_token";
  static const String mj_zone_id = "zone_id";
  static const String please_wait = "Please Wait.";
  static const String mj_addresses = "mj_addresses";
  static const String mj_current_address = "mj_current_address";

  static FirebaseOptions firebaseIOSOptions =  FirebaseOptions(
    databaseURL: 'https://absher-apps-default-rtdb.firebaseio.com/',
    apiKey: 'AIzaSyCPg13bzvvoHC7fE3S--Og-vaIB2ED_a3I',
    appId: '1:565172443161:ios:158302990b51886b373288',
    messagingSenderId: '565172443161',
    projectId: 'absher-apps',
    storageBucket: 'absher-apps.appspot.com',
  );
  static FirebaseOptions firebaseAndroidOptions =  FirebaseOptions(
    databaseURL: 'https://absher-apps-default-rtdb.firebaseio.com/',
    apiKey: 'AIzaSyCPg13bzvvoHC7fE3S--Og-vaIB2ED_a3I',
    appId: '1:477538002455:android:bd6dbd3d9f0000bb4ade52',
    messagingSenderId: '477538002455',
    projectId: 'pichfarmerapp',
    storageBucket: 'pichfarmerapp.appspot.com',
  );
}