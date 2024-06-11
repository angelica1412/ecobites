//Add Store Data ro Cloud FireStore
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> addStoreToFireStore(Map<String, dynamic> storeData) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final myUid = user?.uid;
  if (user == null) {
    print('User is not authenticated');
    return;
  }
  final FirebaseFirestore db = FirebaseFirestore.instance;
  try{
    final CollectionReference addStores = db.collection('Stores');
    addStores.doc(myUid).set(storeData);
    print('Store added to Firestore');
  }catch(e){
    print('Error adding store to Firestore: $e');
  }
}


//Read Store Data by ID
Future<List<Map<String, String>>?> getAllStores() async {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    final QuerySnapshot querySnapshot = await db.collection("Stores").get();

    if (querySnapshot.docs.isNotEmpty) {
      List<Map<String, String>> stores = [];

      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final alamat = data['alamat'] ?? 'no address';
        final deskripsi = data['deskripsi'] ?? 'no desc';
        final imageURL = data['imageURL'] ?? 'assets/shop.png';
        final namaToko = data['namaToko'] ?? '-';
        final id = doc.id;

        stores.add({
          'alamat': alamat,
          'deskripsi': deskripsi,
          'imageURL': imageURL,
          'namaToko': namaToko,
          'id' : id,
        });
      }

      return stores;
    } else {
      print('No stores found');
      return null;
    }
  } catch (e) {
    print('Error getting stores: $e');
    return null;
  }
}

Future<Map<String, String>?> getStorebyID(String storeId) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    final DocumentSnapshot doc = await db.collection("Stores").doc(storeId).get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      final alamat = data['alamat'] ?? 'no address';
      final deskripsi = data['deskripsi'] ?? 'no desc';
      final imageURL = data['imageURL'] ?? 'assets/shop.png';
      final namaToko = data['namaToko'] ?? '-';
      final id = doc.id;

      return {
        'alamat': alamat,
        'deskripsi': deskripsi,
        'imageURL': imageURL,
        'namaToko': namaToko,
        'id':id,
      };
    } else {
      print('Store does not exist');
      return null;
    }
  } catch (e) {
    print('Error getting store: $e');
    return null;
  }
}

//Update Store Data by ID
Future<void> updateStorebyID(String storeID, Map<String, dynamic> updatedData, File? imageFile) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  try {
    // Get the current store document
    final docSnapshot = await db.collection('Stores').doc(storeID).get();
    if (docSnapshot.exists) {
      final currentData = docSnapshot.data() as Map<String, dynamic>;
      final currentImageUrl = currentData['imageURL'] ?? null;

      // If a new image file is provided, delete the old image and upload the new one
      if (imageFile != null) {
        if (currentImageUrl != null && currentImageUrl != 'assets/shop.png') {
          // Delete the old image from Firebase Storage
          final oldImageRef = storage.refFromURL(currentImageUrl);
          await oldImageRef.delete();
        }

        // Upload the new image to Firebase Storage
        final storageRef = storage.ref().child('store_images').child('$storeID.jpg');
        final uploadTask = storageRef.putFile(imageFile);
        final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
        final imageUrl = await taskSnapshot.ref.getDownloadURL();

        // Update the imageURL in the updatedData map
        updatedData['imageURL'] = imageUrl;
      }

      // Update Firestore document
      await db.collection('Stores').doc(storeID).update(updatedData);
      print('Store data updated in Firestore');
    } else {
      print('Store document does not exist');
    }
  } catch (e) {
    print('Error updating store data: $e');
  }
}
