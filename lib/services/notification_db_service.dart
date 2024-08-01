
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


// Create
Future<void> saveNotification
  (
    String userid,
    String title,
    String description,
    DateTime dateTime,
    // DateTime createdAt,
    // DateTime updateAt,
    String notifiactionType,
    
    // String token_id,
    // bool isRead
    ) async 
    {
      String? tokenId = await FirebaseMessaging.instance.getToken();

    final notificationId = 
    {
        'title': title,
        'description': description,
        'date': Timestamp.fromDate(dateTime),
        // 'createdAt': Timestamp.now(),
        // 'isRead': false,
        'notificationType': notifiactionType,
        'token_id': tokenId,
        
        // 'token_id': token_id
      };
      if(title!=Null && description!=Null)
        {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userid)
            .collection('Custom_Notification')
            .add(notificationId);
        }
}

// Update

// Future<void> updateNotification
//   (
//     String userid,
//     String title,
//     String description,
//     DateTime dateTime,
//     // DateTime createdAt,
//     // DateTime updateAt,
//     String notifiactionType,
//     // bool isRead
//     ) async 
//     {
//     final notificationId = 
//     {
//         'title': title,
//         'description': description,
//         'date': Timestamp.fromDate(dateTime),
//         // 'createdAt': Timestamp.now(),
//         // 'isRead': false,
//         'notificationType': notifiactionType,
//       };
//       if(title!=Null && description!=Null)
//         {
//         await FirebaseFirestore.instance
//             .collection('Users')
//             .doc(userid)
//             .collection('Custom_Notification').UpdateAt(notificationId);
//         }
// }