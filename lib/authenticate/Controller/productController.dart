

//Add Product Data ro Cloud FireStore
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> addProductToFireStore(String? storeID, Map<String, dynamic> productData, File? imageFile) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  try {
    final storeRef = db.collection('Stores').doc(storeID);
    final productRef = storeRef.collection('Products').doc(); // Create a new document reference in the Products subcollection
    final String productID = productRef.id;
    if (imageFile != null) {
      // Upload image to Firebase Storage
      final storageRef = storage.ref().child('product_images').child(
          '$productID.jpg');
      final uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
      final imageUrl = await taskSnapshot.ref.getDownloadURL();

      productData['productImageURL'] = imageUrl;
    }
    await productRef.set(productData);
    print('Upload product data to firestore');
  } catch (e) {
    print('Error adding product data: $e');
  }
}

Future<List<Map<String, String>>?> getAllProducts() async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  try {
    final QuerySnapshot querySnapshot = await db.collection("Product").get();
    if (querySnapshot.docs.isNotEmpty) {
      List<Map<String, String>> products = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;

        products.add({
        });
      }
      return products;
    } else {
      print('No Products Found');
    }
  } catch (e) {
    print('Error getting product: $e');
  }
}
//Read Product Data by ID
Future<Map<String, String>?> getProductbyID(String productID) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  try{
    final DocumentSnapshot doc = await db.collection("Product").doc(productID).get();
    if(doc.exists){
      final data = doc.data() as Map<String, dynamic>;
      //ambil data dari firebase
      return{
        //return data dari firebase
      };
    }else {
      print('product does not exist');
      return null;
    }
  }catch(e){
    print('Error getting product: $e');
    return null;
  }


}

// Get all Products by Store ID
Future<List<Map<String, dynamic>>?> getProductsByStoreID(String storeID) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  try {
    // Get reference to the store's products collection
    final storeRef = db.collection('Stores').doc(storeID);
    final QuerySnapshot querySnapshot = await storeRef.collection("Products").get();

    if (querySnapshot.docs.isNotEmpty) {
      List<Map<String, dynamic>> products = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final id=  doc.id; // Add product ID to the data
        final namaBarang = data['namaBarang']??'';
        final jumlahBarang = data['jumlahBarang']??'';
        final satuanBarang = data['satuanBarang']??'';
        final kualitasBarang = data['kualitasBarang']??'';
        final hargaAsliBarang = data['hargaAsliBarang']??'';
        final discount = data['discount']??'';
        final hargaAkhirBarang = data['hargaAkhirBarang']??'';
        final kategoriBarang = data['kategoriBarang']??'';
        final deskripsiBarang = data['deskripsiBarang']??'';
        final productImageURL = data['productImageURL']??'';

        products.add({
          'id':id,
          'namaBarang':namaBarang,
          'jumlahBarang':jumlahBarang,
          'satuanBarang':satuanBarang,
          'kualitasBarang':kualitasBarang,
          'hargaAsliBarang':hargaAsliBarang,
          'discount':discount,
          'hargaAkhirBarang':hargaAkhirBarang,
          'kategoriBarang':kategoriBarang,
          'deskripsiBarang':deskripsiBarang,
          'productImageURL' : productImageURL,
        });
      }
      return products;
    } else {
      print('No Products Found for the given store ID');
      return [];
    }
  } catch (e) {
    print('Error getting products by store ID: $e');
    return null;
  }
}

//Update Product Data by ID
Future<void> updateProductbyID(String productID, Map<String, dynamic> updatedData, File? imageFile) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  try{
    final docSnapshot = await db.collection('Product').doc(productID).get();
    if (docSnapshot.exists) {
      final currentData = docSnapshot.data() as Map<String, dynamic>;
      final currentImageUrl = currentData['productImageURL'] ?? null;

      // If a new image file is provided, delete the old image and upload the new one
      if (imageFile != null) {
        if (currentImageUrl != null && currentImageUrl != 'assets/shop.png') {
          // Delete the old image from Firebase Storage
          final oldImageRef = storage.refFromURL(currentImageUrl);
          await oldImageRef.delete();
        }

        // Upload the new image to Firebase Storage
        final storageRef = storage.ref().child('product_images').child('$productID.jpg');
        final uploadTask = storageRef.putFile(imageFile);
        final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
        final productImageURL = await taskSnapshot.ref.getDownloadURL();

        // Update the imageURL in the updatedData map
        updatedData['productImageURL'] = productImageURL;
      }

      // Update Firestore document
      await db.collection('Product').doc(productID).update(updatedData);
      print('Product data updated in Firestore');
    } else {
      print('Product document does not exist');
    }
  } catch (e) {
    print('Error updating product data: $e');
  }
}


// Delete Product Data by ID
Future<void> deleteProductFromFirestore(String productID) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  try {
    final docSnapshot = await db.collection('Product').doc(productID).get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      final imageUrl = data['productImageURL'] ?? null;

      // Delete the image from Firebase Storage
      if (imageUrl != null && imageUrl != 'assets/shop.png') {
        final imageRef = storage.refFromURL(imageUrl);
        await imageRef.delete();
      }

      // Delete the document from Firestore
      await db.collection('Product').doc(productID).delete();
      print('Product data deleted from Firestore');
    } else {
      print('Product document does not exist');
    }
  } catch (e) {
    print('Error deleting product data: $e');
  }
}
