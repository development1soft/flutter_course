import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

const db = admin.firestore();

const fcm = admin.messaging();

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
export const helloWorld = functions.https.onRequest((request, response) => {
 response.send("Hello from Firebase!");
});

export const sendToDevice = functions.firestore.document('posts/{postID}').onCreate(async snapshot => {
    
    const querySnapshot = await db.collection('tokens').get();

    const tokens = new Array();

    querySnapshot.forEach(async tokenDoc => {
        tokens.push(tokenDoc.data().token);
    });

    const payload : admin.messaging.MessagingPayload = {
        notification : {
            title : ' New Post Created ',
            body : 'Please Check Your Timeline',
            click_action : 'FLUTTER_NOTIFICATION_CLICK' 
        }
    };

    return fcm.sendToDevice(tokens , payload);

});
