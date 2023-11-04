// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/eva.dart';

import '../common/theme.dart';

// ignore: must_be_immutable
class CustomForm extends StatelessWidget {
  final TextEditingController controller;
  final Function validate;
  final String title;
  final TextInputType typeForm;
  bool obscure = true;
  final bool? isShow;
  final Function togleObscure;

  CustomForm({
    Key? key,
    required this.controller,
    required this.validate,
    required this.title,
    required this.typeForm,
    required this.obscure,
    this.isShow,
    required this.togleObscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool obscure = true;
    // final provider = Provider.of<LoginProvider>(context, listen: true);
    // final providerRegis = Provider.of<RegisterProvider>(context, listen: true);

    return TextFormField(
      // obscureText: provider.obscureText,
      obscureText: obscure,
      // keyboardType: TextInputType.emailAddress,
      keyboardType: typeForm,
      // controller: provider.emailController,
      controller: controller,
      // validator: (value) => provider.validateEmail(value),
      validator: (value) => validate(value),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            color: Color(0xFF00AFFF),
          ),
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
        label: Text(
          // 'Email',
          title,
          style: GoogleFonts.poppins(
            fontWeight: reguler,
            color: Colors.black,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        suffixIcon: Builder(
          builder: (context) {
            if (isShow == true) {
              return IconButton(
                onPressed: () {
                  // providerRegis.toggleObscureText();
                  togleObscure();
                },
                icon: Iconify(
                  obscure ? Eva.eye_off_outline : Eva.eye_outline,
                  color: obscure ? greyColor : const Color(0xFF00AFFF),
                ),
              );
            } else {
              return const SizedBox(
                width: 0,
                height: 0,
              );
            }
          },
        ),
      ),
    );
  }
}
