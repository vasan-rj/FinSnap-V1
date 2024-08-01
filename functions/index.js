/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// 

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.scheduleNotification = functions.firestore
    .document('Users/{userId}/Custom_Notification/{notificationId}')
    .onCreate((snap, context) => {
        const notificationData = snap.data();

        // Extract details from the notification
        const title = notificationData.title;
        const body = notificationData.description; // Assuming description is used for body
        const scheduledTime = notificationData.date; // Firestore timestamp
        const token = notificationData.token_id;

        // Convert Firestore timestamp to JavaScript Date object
        const sendTime = new Date(scheduledTime.seconds * 1000);

        // Send the notification at the scheduled time
        const message = {
            notification: {
                title: title,
                body: body
            },
            token: token
        };

        // Calculate delay (in milliseconds)
        const delay = sendTime.getTime() - new Date().getTime();

        if (delay > 0) {
            setTimeout(() => {
                admin.messaging().send(message)
                    .then(response => {
                        console.log('Successfully sent message:', response);
                    })
                    .catch(error => {
                        console.error('Error sending message:', error);
                    });
            }, delay);
        } else {
            console.error('Scheduled time is in the past');
        }

        return null;
    });


// const functions = require('firebase-functions');
// const admin = require('firebase-admin');
// admin.initializeApp();

// exports.scheduleNotification = functions.firestore
//     .document('notifications/{notificationId}')
//     .onCreate((snap, context) => {
//         const notificationData = snap.data();

//         // Extract details from the notification
//         const title = notificationData.title;
//         const body = notificationData.body;
//         const scheduledTime = notificationData.scheduledTime; // Firestore timestamp
//         const token = notificationData.token;

//         // Convert Firestore timestamp to JavaScript Date object
//         const sendTime = new Date(scheduledTime.seconds * 1000);

//         // Send the notification at the scheduled time
//         const message = {
//             notification: {
//                 title: title,
//                 body: body
//             },
//             token: token
//         };

//         // Calculate delay (in milliseconds)
//         const delay = sendTime.getTime() - new Date().getTime();

//         if (delay > 0) {
//             setTimeout(() => {
//                 admin.messaging().send(message)
//                     .then(response => {
//                         console.log('Successfully sent message:', response);
//                     })
//                     .catch(error => {
//                         console.error('Error sending message:', error);
//                     });
//             }, delay);
//         } else {
//             console.error('Scheduled time is in the past');
//         }

//         return null;
//     });

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
