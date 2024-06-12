import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Add user Data ro Cloud FireStore
Future<void> addUserDetailsToFirestore(Map<String, dynamic> userData) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final myUid = user?.uid;
  if (user == null) {
    print('User is not authenticated');
    return;
  }
  final FirebaseFirestore db = FirebaseFirestore.instance;
  try {
    final CollectionReference addusers = db.collection('Users');
    addusers.doc(myUid).set(userData);
    print('User added to Firestore');
  } catch (e) {
    print('Error adding user to Firestore: $e');
  }
}


//Read User Data by UID
Future<Map<String, String>?> getUserDetailsbyUID() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final myUid = user?.uid;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    final DocumentSnapshot doc = await db.collection("Users").doc(myUid).get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      final email = data['email'] ?? '';
      final username = data['username'] ?? '';
      final phone = data['phone']??'';

      return {
        'email': email,
        'username': username,
        'phone' : phone,
      };
    } else {
      print('Document does not exist');
      return null;
    }
  } catch (e) {
    print('Error getting document: $e');
    return null;
  }
}

//Update User Data by UID
Future<void> updateUserDetailsbyUID(Map<String, dynamic> updatedData) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final myUid = user?.uid;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  try {
    await db.collection('Users').doc(myUid).update(updatedData);
    print('User data updated in Firestore');
  } catch (e) {
    print('Error updating user data: $e');
  }
}

//Delete User Data by UID
// Future<void> deleteUserFromFirestore(String userId) async {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final User? user = auth.currentUser;
//   final myUid = user?.uid;
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   try {
//     await db.collection('users').doc(myUid).delete();
//     print('User deleted from Firestore');
//   } catch (e) {
//     print('Error deleting user: $e');
//   }
// }