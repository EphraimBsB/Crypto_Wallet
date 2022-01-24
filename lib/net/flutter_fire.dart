import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String password) async {
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return true;
  }catch(e){
    print(e.toString());
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  return true;
} on FirebaseAuthException catch  (e) {
  if(e.code == 'weak-password'){
    print('Password provided is too weak');
  }else if(e.code == 'email-already-in-use'){
    print('The ccount already exist for that email');
  }
  return false;
} catch(e){
  print(e.toString());
  return false;
}
}

Future<bool> addCoins( String id, String amount ) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var value = double.parse(amount);
    DocumentReference documentReference = FirebaseFirestore.instance.collection('Users').doc(uid).collection('Coins').doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if(!snapshot.exists){
        documentReference.set({'Amount': value});
        return true;
      }
      double newAmount = (snapshot.data()as Map<String, dynamic>)['Amount'] + value;
      transaction.update(documentReference, {'Amount': newAmount});
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
}