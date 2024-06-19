import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';


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
      final userImageURL = data['userImageURL']??'';

      return {
        'email': email,
        'username': username,
        'phone' : phone,
        'userImageURL' : userImageURL
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
Future<void> updateUserDetailsbyUID(Map<String, dynamic> updatedData, File? imageFile) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final myUid = user?.uid;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  try {
    final docSnapshot = await db.collection('Users').doc(myUid).get();
    if (docSnapshot.exists){
      final currentData = docSnapshot.data() as Map<String, dynamic>;
      final currentImageUrl = currentData['userImageURL'] ?? null;
      if(imageFile != null){
        File compressedFile = await compressImage(imageFile, 50); // Compress with 85% quality
        if(currentImageUrl != null && currentImageUrl != ''){
          final oldImageRef = storage.refFromURL(currentImageUrl);
          await oldImageRef.delete();
        }
        final storageRef = storage.ref().child('users_images').child('$myUid.jpg');
        final uploadTask = storageRef.putFile(compressedFile);
        final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
        final userImageURL = await taskSnapshot.ref.getDownloadURL();

        // Update the imageURL in the updatedData map
        updatedData['userImageURL'] = userImageURL;
      }

    }
    await db.collection('Users').doc(myUid).update(updatedData);
    print('User data updated in Firestore');
  } catch (e) {
    print('Error updating user data: $e');
  }
}

Future<File> compressImage(File file, int quality) async {
  final dir = await getTemporaryDirectory();
  final targetPath = '${dir.absolute.path}/temp.jpg';

  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: quality, // Anda bisa menyesuaikan kualitas sesuai kebutuhan
  );

  return File(result!.path);
}

