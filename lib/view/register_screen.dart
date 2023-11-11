import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris_firebase_flutter/common/theme.dart';
import 'package:hris_firebase_flutter/view_model/register_provider.dart';
import 'package:hris_firebase_flutter/widgets/button_custom.dart';
import 'package:hris_firebase_flutter/widgets/custom_form.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    final providerRegister = context.read<RegisterProvider>();
    // mengakses data dari state
    final provider = Provider.of<RegisterProvider>(context, listen: false);


    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Photo
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: blackColor, // Warna Border
                      width: 2.0, // Lebar Border
                    ),
                    borderRadius: BorderRadius.circular(150), // Sudut Border
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: context.watch<RegisterProvider>().imagePath == null
                        ? const Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.image,
                              size: 120,
                            ),
                          )
                        : providerRegister.showImage(),
                  ),
                ),

                const SizedBox(
                  height: 40,
                ),

                Form(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      // Nama Pegawai
                      CustomForm(
                        controller: provider.nameController,
                        validate: provider.validateName,
                        title: 'Nama Lengkap',
                        typeForm: TextInputType.name,
                        obscure: false,
                        togleObscure: provider.toggleObscureText,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // NIP
                      CustomForm(
                        controller: provider.nipController,
                        validate: provider.validateNip,
                        title: 'Nomor Induk Pegawai',
                        typeForm: TextInputType.number,
                        obscure: false,
                        togleObscure: provider.toggleObscureText,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      CustomForm(
                        controller: provider.numberPhoneController,
                        validate: provider.validateNumberPhone,
                        title: 'Nomor Telepon',
                        typeForm: TextInputType.number,
                        obscure: false,
                        togleObscure: provider.toggleObscureText,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // TTL
                      // CustomForm(
                      //   controller: provider.ttlController,
                      //   validate: provider.validateTtl,
                      //   title: 'Tempat, Tanggal Lahir',
                      //   typeForm: TextInputType.datetime,
                      //   obscure: false,
                      //   togleObscure: provider.toggleObscureText,
                      // ),

                      // Tanggal Lahir
                      TextFormField(
                        controller: provider.tanggalController =
                            TextEditingController(
                          text: DateFormat('dd/MM/yyyy').format(provider.date),
                        ),
                        validator: (value) =>
                            provider.validateTtl(value ?? 'Null'),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: blackColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                          label: Text(
                            'Tanggal Lahir',
                            style: GoogleFonts.poppins(
                                fontWeight: reguler, color: blackColor),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                provider.selectDate(context, provider);
                              },
                              icon: Icon(
                                Icons.date_range_outlined,
                                color: greyColor,
                              )),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // DropdownButton Gender
                      Container(
                        height: 70,
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: blackColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Consumer<RegisterProvider>(
                              builder: (context, data, _) {
                            return DropdownButton<Gender?>(
                              hint: const Text('Jenis Kelamin'),
                              value: data.selectedValueGender,
                              onChanged: (value) {
                                if (value != null) {
                                  data.selectedValueGender = value;
                                }
                              },
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: provider.genderList
                                  .map<DropdownMenuItem<Gender?>>(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child:
                                          Text((e.genderName ?? '').toString()),
                                    ),
                                  )
                                  .toList(),
                            );
                          }),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // Gender
                      // CustomForm(
                      //   controller: provider.genderController,
                      //   validate: provider.validateGender,
                      //   title: 'Jenis Kelamin',
                      //   typeForm: TextInputType.text,
                      //   obscure: false,
                      //   togleObscure: provider.toggleObscureText,
                      // ),

                      // DropdownButton Divisi
                      Container(
                        height: 70,
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: blackColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Consumer<RegisterProvider>(
                              builder: (context, data, _) {
                            return DropdownButton<Division?>(
                              hint: const Text('Divisi'),
                              value: data.selectedValueDivision,
                              onChanged: (value) {
                                if (value != null) {
                                  data.selectedValueDivision = value;
                                }
                              },
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: provider.divisionList
                                  .map<DropdownMenuItem<Division?>>(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                          (e.divisionName ?? '').toString()),
                                    ),
                                  )
                                  .toList(),
                            );
                          }),
                        ),
                      ),

                      // // Divisi
                      // CustomForm(
                      //   controller: provider.divisionController,
                      //   validate: provider.validateDivision,
                      //   title: 'Divisi',
                      //   typeForm: TextInputType.text,
                      //   obscure: false,
                      //   togleObscure: provider.toggleObscureText,
                      // ),

                      const SizedBox(
                        height: 20,
                      ),

                      // DropdownButton Jabatan
                      Container(
                        height: 70,
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: blackColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Consumer<RegisterProvider>(
                              builder: (context, data, _) {
                            return DropdownButton<Position?>(
                              hint: const Text('Jabatan'),
                              value: data.selectedValuePosition,
                              onChanged: (value) {
                                if (value != null) {
                                  data.selectedValuePosition = value;
                                }
                              },
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: provider.positionList
                                  .map<DropdownMenuItem<Position?>>(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                          (e.positionName ?? '').toString()),
                                    ),
                                  )
                                  .toList(),
                            );
                          }),
                        ),
                      ),

                      // Jabatan
                      // CustomForm(
                      //   controller: provider.positionController,
                      //   validate: provider.validatePosition,
                      //   title: 'Posisi Jabatan',
                      //   typeForm: TextInputType.text,
                      //   obscure: false,
                      //   togleObscure: provider.toggleObscureText,
                      // ),

                      const SizedBox(
                        height: 20,
                      ),

                      // Email
                      CustomForm(
                        controller: provider.emailController,
                        validate: provider.validateEmail,
                        title: 'Email',
                        typeForm: TextInputType.emailAddress,
                        isShow: false,
                        obscure: false,
                        togleObscure: provider.toggleObscureText,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // Password
                      Consumer<RegisterProvider>(
                        builder: (context, data, _) {
                          return CustomForm(
                            obscure: data.obscureText,
                            controller: data.passwordController,
                            validate: data.validatePass,
                            title: 'Password',
                            typeForm: TextInputType.visiblePassword,
                            isShow: true,
                            togleObscure: data.toggleObscureText,
                          );
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // Sisa Cuti
                      CustomForm(
                        controller: provider.sisaCutiController,
                        validate: provider.validateSisaCuti,
                        title: 'Sisa Cuti',
                        typeForm: TextInputType.number,
                        obscure: false,
                        togleObscure: provider.toggleObscureText,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // Alamat
                      CustomForm(
                        controller: provider.addressController,
                        validate: provider.validateAddress,
                        title: 'Alamat',
                        typeForm: TextInputType.text,
                        obscure: false,
                        togleObscure: provider.toggleObscureText,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // Button Daftar
                      ButtonCustom(
                        onTap: () {
                          provider.authenticateRegister();
                        },
                        label: 'Daftar',
                        isExpand: true,
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
