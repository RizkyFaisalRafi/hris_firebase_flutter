import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  // Name
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  // NIP
  final TextEditingController _nipController = TextEditingController();
  TextEditingController get nipController => _nipController;

  // Tempat, Tanggal Lahir
  final TextEditingController _ttlController = TextEditingController();
  TextEditingController get ttlController => _ttlController;

  // Gender
  // final TextEditingController _genderController = TextEditingController();
  // TextEditingController get genderController => _genderController;

  // Divisi/Bagian
  // final TextEditingController _divisionController = TextEditingController();
  // TextEditingController get divisionController => _divisionController;

  // Posisi / Jabatan
  // final TextEditingController _positionController = TextEditingController();
  // TextEditingController get positionController => _positionController;

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

  // Validator TTL
  String? validateTtl(String ttl) {
    if (ttl.isEmpty) {
      return 'Tempat, Tanggal Lahir tidak boleh kosong!';
    } else {
      return null;
    }
  }

  // Validator Gender
  // String? validateGender(String gender) {
  //   if (gender.isEmpty) {
  //     return 'Jenis Kelamin tidak boleh kosong!';
  //   } else {
  //     return null;
  //   }
  // }

  // Validator Divisi
  // String? validateDivision(String division) {
  //   if (division.isEmpty) {
  //     return 'Divisi tidak boleh kosong!';
  //   } else {
  //     return null;
  //   }
  // }

  // Validator Jabatan
  // String? validatePosition(String position) {
  //   if (position.isEmpty) {
  //     return 'Posisi Jabatan tidak boleh kosong!';
  //   } else {
  //     return null;
  //   }
  // }

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
