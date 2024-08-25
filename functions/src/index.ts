/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// import {onRequest} from "firebase-functions/v2/https";
// import * as logger from "firebase-functions/logger";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

// export const helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

export const sendNotification = functions.firestore
  .document("Users/{userid}/Custom_Notification/{notificationId}")
  .onCreate(async (snapshot, context) => {
    const notificationData = snapshot.data();
    const userId = context.params.userid;
    const notificationId = context.params.notificationId;
    const payload: admin.messaging.Message={
      notification: {
        title: notificationData.title,
        body: notificationData.description,
        
      },
      token: "",
    };
    const userDoc = await admin.firestore().collection("Users").doc(userId).collection("Custom_Notification").doc(notificationId).get();
    const fcmToken = userDoc.data()?.fcmToken;


    if (fcmToken) {
        payload.token = fcmToken;
        return admin.messaging().send(payload)
          .then(response => {
            console.log("Notification sent successfully:", response);
          })
          .catch(error => {
            console.error("Error sending notification:", error);
          });
      } else {
        console.log("No FCM token for user:", userId);
        return null;
      }
    // return admin.messaging().sendToTopic("notifications", payload)
    //   .then(response => {
    //     console.log("Notification sent successfully:", response);
    //   })
    //   .catch(error => {
    //     console.log("Error sending notification:", error);
    //   });
  });
