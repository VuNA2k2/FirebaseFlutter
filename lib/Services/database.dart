import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tutorial/Models/coffee.dart';

class DatabaseService {
  final String _uId;

  DatabaseService(this._uId);

  final CollectionReference collection = FirebaseFirestore.instance.collection("Coffee");

  Future updateUserData(String id, String sugars, String name, int strength) async {
    return await collection.doc(_uId).collection("Selection").doc(id).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }
  Future addUserData(String sugars, String name, int strength) async {
      return await collection.doc(_uId).collection("Selection").add({
        'sugars': sugars,
        'name': name,
        'strength': strength,
      });
    }

  Future createCollectionInUser() async {
    return await collection.doc(_uId).collection("Selection");
  }

  Stream<List<Coffee>> get coffee {
    return collection.doc(_uId).collection("Selection").snapshots().map((event) => listCoffeeFromFirebase(event));
    // return collection.snapshots().map((event) => listCoffeeFromFirebase(event));
  }
  
  List<Coffee> listCoffeeFromFirebase(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Coffee(
        e.id,
        e['name'],
        e['sugars'],
        int.parse(e['strength'].toString())
      );
    }).toList();
  }

  Future deleteDocument(String id) async {
    return await collection.doc(_uId).collection("Selection").doc(id).delete();
  }

}