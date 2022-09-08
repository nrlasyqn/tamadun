import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../auth/user.provider.dart';

class PaymentProvider extends ChangeNotifier {
  var cid;
  var pid;
  String? receipt;
  String? status;
  String role = 'standard';
  var price = 'RM 50.00';
  void setCid(custId) {
    cid = custId;
    notifyListeners();
  }

  void setPid(id) {
    pid = id;
    notifyListeners();
  }

  void updateData(url, code) {
    receipt = url;
    status = code;
    notifyListeners();
  }

  void updateRole(url, paymentId, custId) {
    //update user detail in database on success
    //line after this example execution
    role = 'premium';
    notifyListeners();
  }

  void setDefault() {
    role = 'standard';
    status = null;
    receipt = null;
    cid = null;
    pid = null;
    notifyListeners();
  }
// Future<void> updateRole(url, pid, cid) async {
//   FirebaseFirestore db = FirebaseFirestore.instance;
//   db.collection("Users").doc(AppUser.instance.user!.uid).set({
//     "role": "premium",
//     "receipt-url": url,
//     "payment-id": pid,
//     "cust-id": cid
//   }, SetOptions(merge: true));
//   role = 'premium';
//   notifyListeners();
// }
///
// void updateData(url, code) {
//   receipt = url;
//   status = code;
//   notifyListeners();
// }
//
// void updateRole(url, paymentId, custId) {
//   //update user detail in database on success
//   //line after this example execution
//   role = 'premium';
//   notifyListeners();
// }
}