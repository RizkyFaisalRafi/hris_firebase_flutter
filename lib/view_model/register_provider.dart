import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hris_firebase_flutter/common/keys.dart';

class RegisterProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Dispose method to clean up resources(Masih error)
  @override
  void dispose() {
    nameController.dispose();
    nipController.dispose();
    super.dispose();
  }

  // Name
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  // NIP
  final TextEditingController _nipController = TextEditingController();
  TextEditingController get nipController => _nipController;

  // Tanggal Lahir
  TextEditingController tanggalController = TextEditingController();

  // Email
  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  // Password
  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  // Sisa Cuti
  final TextEditingController _sisaCutiController = TextEditingController();
  TextEditingController get sisaCutiController => _sisaCutiController;

  // Address / Alamat
  final TextEditingController _addressController = TextEditingController();
  TextEditingController get addressController => _addressController;

  // Number Phone
  final TextEditingController _numberPhoneController = TextEditingController();
  TextEditingController get numberPhoneController => _numberPhoneController;

  bool _obscureText = true;
  bool get obscureText => _obscureText;

  String? imagePath;

  // Gender
  Gender? _selectedValueGender;
  // List Gender
  final List<Gender> _genderList = [
    Gender(id: 1, genderName: "Pria"),
    Gender(id: 2, genderName: "Wanita"),
  ];
  // Tambahkan getter dan setter sesuai kebutuhan
  Gender? get selectedValueGender => _selectedValueGender;
  set selectedValueGender(Gender? value) {
    _selectedValueGender = value;
    notifyListeners(); // Memanggil notifyListeners() akan memberi tahu tampilan untuk diperbarui.
  }

  List<Gender> get genderList => _genderList;

  // Division
  Division? _selectedValueDivision;
  // List Division/Bagian Kerja
  final List<Division> _divisionList = [
    Division(id: 1, divisionName: "Software Engineer"),
    Division(id: 2, divisionName: "2ND Process"),
    Division(id: 3, divisionName: "Staff"),
  ];
  // Tambahkan getter dan setter sesuai kebutuhan
  Division? get selectedValueDivision => _selectedValueDivision;
  set selectedValueDivision(Division? value) {
    _selectedValueDivision = value;
    notifyListeners();
  }

  List<Division> get divisionList => _divisionList;

  // Position
  Position? _selectedValuePosition;
  // List Position/Jabatan
  final List<Position> _positionList = [
    Position(id: 1, positionName: "Karyawan"),
    Position(id: 2, positionName: "Manajer"),
    Position(id: 3, positionName: "Supervisor"),
    Position(id: 4, positionName: "Mobile Developer"),
    Position(id: 5, positionName: "Web Developer"),
  ];
  // Tambahkan getter dan setter sesuai kebutuhan
  Position? get selectedValuePosition => _selectedValuePosition;
  set selectedValuePosition(Position? value) {
    _selectedValuePosition = value;
    notifyListeners();
  }

  List<Position> get positionList => _positionList;

  // Validator Name
  String? validateName(name) {
    if (name.isEmpty) {
      return 'Nama tidak boleh kosong';
    } else if (name.split('').length < 2) {
      return 'Nama harus terdiri dari minimal 2 kata!';
    } else {
      return null;
    }
  }

  // Validator NIP
  String? validateNip(String nip) {
    if (nip.isEmpty) {
      return 'NIP tidak boleh kosong!';
    } else if (nip.split('').length < 2) {
      return 'NIP harus terdiri dari minimal 2 kata!';
    } else {
      return null;
    }
  }

  // Validator Number Telephone
  String? validateNumberPhone(String numberPhone) {
    if (numberPhone.isEmpty) {
      return 'Nomor Telephone tidak boleh kosong!';
    } else if (numberPhone.split('').length < 2) {
      return 'Nomor Telephone harus terdiri dari minimal 2 kata!';
    } else {
      return null;
    }
  }

  // Validator Tanggal Lahir
  String? validateTtl(String tanggalLahir) {
    if (tanggalLahir.isEmpty) {
      return 'Tanggal Lahir tidak boleh kosong!';
    } else {
      return null;
    }
  }

  // Validator Email
  String? validateEmail(email) {
    if (email.isEmpty) {
      return "Email tidak boleh kosong";
    } else if (email.contains(RegExp(r'[!#<>?":$_`~;[\]\\|=+)(*&^%-]'))) {
      return 'Email tidak boleh mengandung karakter khusus!';
    } else {
      return null;
    }
  }

  // Validator Password
  String? validatePass(pass) {
    if (pass.isEmpty) {
      return "Password tidak boleh kosong!";
    } else if (pass.split('').length < 8) {
      return 'Password harus terdiri dari minimal 8 kata!';
    } else {
      return null;
    }
  }

  // Validator Sisa Cuti
  String? validateSisaCuti(sisacuti) {
    if (sisacuti.isEmpty) {
      return "Sisa Cuti tidak boleh kosong!";
    } else {
      return null;
    }
  }

  // Validator Alamat
  String? validateAddress(alamat) {
    if (alamat.isEmpty) {
      return "Alamat tidak boleh kosong!";
    } else {
      return null;
    }
  }

  // Show Password
  void toggleObscureText() {
    notifyListeners();
    _obscureText = !_obscureText;
  }

  showImage() {
    // todo-show-01: change widget to show the image

    return kIsWeb
        ? Image.network(
            imagePath.toString(),
            fit: BoxFit.contain,
            width: 150,
            height: 150,
          )
        : Image.file(
            File(imagePath.toString()),
            fit: BoxFit.contain,
            width: 150,
            height: 150,
          );
  }

  authenticateRegister() async {
    UserCredential userCredential;
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // Email Verifikasi
      await userCredential.user!.sendEmailVerification();

      firebaseFirestore.collection("users").doc(userCredential.user?.uid).set({
        "uid": userCredential.user!.uid,
        "name": nameController.text,
        "nip": nipController.text,
        "number_phone": numberPhoneController.text,
        "tanggal_lahir": tanggalController.text,
        "jenis_kelamin": selectedValueGender?.genderName,
        "divisi": selectedValueDivision?.divisionName,
        "jabatan": selectedValuePosition?.positionName,
        "email": userCredential.user!.email,
        "password": passwordController.text,
        "sisaCuti": sisaCutiController.text,
        "alamat": addressController.text,
      });
    } on FirebaseAuthException catch (error) {
      Keys.scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
        content: Text(error.code),
        backgroundColor: Colors.red,
      ));
    }
  }

  bool? emailVerified;
  // Memperbarui status email verifikasi state
  Future<void> updateEmailVerificationState() async {
    String timerCalled = 'Timer Called';
    emailVerified = firebaseAuth.currentUser!.emailVerified;
    // Akan me reload otomatis 3 detik apabila email belum diverifikasi
    if (!emailVerified!) {
      Timer.periodic(const Duration(seconds: 3), (timer) async {
        log(timerCalled);
        await firebaseAuth.currentUser?.reload();
        final user = firebaseAuth.currentUser;
        if (user!.emailVerified) {
          emailVerified = user.emailVerified;
          timer.cancel(); // Ketika Sudah diverifikasi akan berhenti timernya
          notifyListeners();
        }
      });
    }
  }

  Future<void> logOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  final primaryColor = const Color(0xff7CA153);
  // tanggal
  DateTime _date = DateTime.now();
  final currentDate = DateTime.now();
  DateTime get date => _date;

  void updateDate(DateTime selectDate) {
    _date = selectDate;
    notifyListeners();
  }

  Future<void> selectDate(
      BuildContext context, RegisterProvider provider) async {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme.copyWith(
      primary: primaryColor,
      onPrimary: Colors.white,
    );
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
            data: theme.copyWith(
              colorScheme: colorScheme,
            ),
            child: child!);
      },
    );

    if (pickedDate != null) {
      provider.updateDate(pickedDate);
    }
  }
}

class Gender {
  int? id;
  String? genderName;

  Gender({this.id, this.genderName});
}

class Division {
  int? id;
  String? divisionName;

  Division({this.id, this.divisionName});
}

class Position {
  int? id;
  String? positionName;

  Position({this.id, this.positionName});
}
