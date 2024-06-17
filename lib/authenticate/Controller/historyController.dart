import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../historypage.dart';

Future<void> addHistorytoStoresFirestore(String? storeID, Map<String, dynamic> historyData) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  try{
    final storeRef = db.collection('Stores').doc(storeID);
    final historyRef = storeRef.collection('History').doc();
    await historyRef.set(historyData);
    print('History adding to Store Firestore');
  }catch(e){
    print('Error adding history data to Stores: $e');
  }

}

Future<void> addHistorytoUsersFirestore (Map<String, dynamic> historyData) async{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final myUid = user?.uid;
  if (user == null) {
    print('User is not authenticated');
    return;
  }
  final FirebaseFirestore db = FirebaseFirestore.instance;
  try{
    final userRef = db.collection('Users').doc(myUid);
    final productRef = userRef.collection('History').doc();
    productRef.set(historyData);
    print('History adding to User Firestore');
  }catch(e){
    print('Error adding store to Firestore: $e');
  }
}

Future<List<ActivityCard>> readUserHistoryFromFirestore() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final myUid = user?.uid;
  if (user == null) {
    print('User is not authenticated');
    return [];
  }

  final FirebaseFirestore db = FirebaseFirestore.instance;
  try {
    final userRef = db.collection('Users').doc(myUid);
    final historySnapshot = await userRef.collection('History').get();

    if (historySnapshot.docs.isNotEmpty) {
      List<ActivityCard> activityCards = historySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ActivityCard.fromMap(data, doc.id);
      }).toList();

      return activityCards;
    } else {
      print('No history data found for the user');
      return [];
    }
  } catch (e) {
    print('Error reading user history from Firestore: $e');
    return [];
  }
}

Future<List<ActivityCard>> readStoreHistoryFromFirestore() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final myUid = user?.uid;
  if (user == null) {
    print('User is not authenticated');
    return [];
  }
  final FirebaseFirestore db = FirebaseFirestore.instance;
  try {
    final storeRef = db.collection('Stores').doc(myUid);
    final historySnapshot = await storeRef.collection('History').get();

    if (historySnapshot.docs.isNotEmpty) {
      List<ActivityCard> activityCards = historySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ActivityCard.fromMap(data, doc.id);
      }).toList();

      return activityCards;
    } else {
      print('No history data found for the store');
      return [];
    }
  } catch (e) {
    print('Error reading store history from Firestore: $e');
    return [];
  }
}