import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hris_firebase_flutter/models/users_data.dart';
import 'package:hris_firebase_flutter/view_model/register_provider.dart';

class GetDataProvider extends ChangeNotifier {
  // GET DATA
  String? _uid;
  UsersData? usersData;

  Future<void> getData() async {
    User? user = RegisterProvider().currentUser;
    _uid = user?.uid;

    final DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    notifyListeners();
    usersData = UsersData(
      name: snapshot.get('name'),
      sisaCuti: snapshot.get('sisaCuti'),
      alamat: snapshot.get('alamat'),
      divisi: snapshot.get('divisi'),
      email: snapshot.get('email'),
      jabatan: snapshot.get('jabatan'),
      jenisKelamin: snapshot.get('jenisKelamin'),
      nip: snapshot.get('nip'),
      numberPhone: snapshot.get('numberPhone'),
      password: snapshot.get('password'),
      tanggalLahir: snapshot.get('tanggalLahir'),
      uid: snapshot.get('uid'),
    );
  }
}
