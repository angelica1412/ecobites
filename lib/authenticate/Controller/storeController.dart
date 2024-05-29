

//Add Store Data ro Cloud FireStore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> addStoreToFireStore(Map<String, dynamic> userData) async {

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
        final alamat = data['alamat'] ?? '';
        final deskripsi = data['deskripsi'] ?? '';
        final logo = data['logo'] ?? '';
        final namaToko = data['namaToko'] ?? '';

        stores.add({
          'alamat': alamat,
          'deskripsi': deskripsi,
          'logo': logo,
          'namaToko': namaToko,
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
      final alamat = data['alamat'] ?? '';
      final deskripsi = data['deskripsi'] ?? '';
      final logo = data['logo'] ?? '';
      final namaToko = data['namaToko'] ?? '';

      return {
        'alamat': alamat,
        'deskripsi': deskripsi,
        'logo': logo,
        'namaToko': namaToko,
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
Future<void> updateStorebyID(Map<String, dynamic> updatedData) async {

}

// Delete Store Data by ID
// Future<void> deleteStoreFromFirestore(String userId) async {
//
// }
