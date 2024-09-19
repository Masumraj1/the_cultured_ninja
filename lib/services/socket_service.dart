// import 'package:flutter/foundation.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;
// import 'package:track_booking/helper/shared_prefe/shared_prefe.dart';
// import 'package:track_booking/services/app_url.dart';
// import 'package:track_booking/utils/app_const/app_const.dart';
//
// ///<------------------------- Socket Class ---------------->
// class SocketApi {
//   // Singleton instance
//   static final SocketApi _instance = SocketApi._internal();
//
//   // Factory constructor to return the same static instance every time you create an object.
//   factory SocketApi() {
//     return _instance;
//   }
//
//   // Private internal constructor
//   SocketApi._internal();
//
//   // Static Socket variable to store the socket instance
//   static late io.Socket _socket;
//
//   ///<------------------------- Static Socket Initialization ---------------->
//   static Future<void> init() async {
//     // Fetch the bearer token asynchronously
//     String bearerToken = await SharePrefsHelper.getString(AppConstants.bearerToken);
//
//     if(bearerToken.isEmpty|| bearerToken=='null'){
//       return;
//     }
//
//     // Initialize socket
//     _socket = io.io(
//       ApiUrl.socketUrl,
//       io.OptionBuilder()
//           .setTransports(['websocket'])
//           .setAuth({'token': bearerToken})
//           .build(),
//     );
//
//     // Listen for socket events
//     _socket.onConnect((value) {
//       debugPrint('=====================================Socket Connected=======================');
//     });
//
//     _socket.on('unauthorized', (dynamic data) {
//       debugPrint('Unauthorized');
//     });
//
//     _socket.onError((dynamic error) {
//       debugPrint('Socket error: $error');
//     });
//
//     _socket.onDisconnect((dynamic data) {
//       debugPrint('======================================Socket disconnected=========================');
//     });
//   }
//
//   // Static getter for the socket instance
//   static io.Socket get socket => _socket;
//
//   // Static method to emit events
//   static void emit(String event, dynamic data) {
//     _socket.emit(event, data);
//   }
//
//   // Static method to listen for events
//   static void on(String event, Function(dynamic) callback) {
//     _socket.on(event, callback);
//   }
// }
