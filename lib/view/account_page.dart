import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:hris_firebase_flutter/view/login_screen.dart';
import 'package:hris_firebase_flutter/view_model/get_data_provider.dart';
import 'package:hris_firebase_flutter/view_model/register_provider.dart';
import 'package:provider/provider.dart';
import '../common/theme.dart';
import '../widgets/menu_profile.dart';
import 'about_screen.dart';
import 'call_dev_screen.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<GetDataProvider>(builder: (context, data, _) {
          return Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset('assets/bg_header.png'),
                  ),
                  const CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage('assets/orang.png'),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                data.usersData?.name ?? 'Null',
                style: fontRoboto.copyWith(
                  fontWeight: bold,
                  fontSize: 17,
                ),
              ),
              Text(
                data.usersData?.nip ?? 'Null',
                style: fontRoboto.copyWith(
                  fontWeight: semiBold,
                  fontSize: 17,
                ),
              ),
              Text(
                data.usersData?.divisi ?? 'Null',
                style: fontRoboto.copyWith(
                  fontWeight: semiBold,
                  fontSize: 17,
                ),
              ),

              const SizedBox(
                height: 44,
              ),

              // // Edit Profile
              // MenuProfile(
              //   image: 'assets/edit_profile.png',
              //   title: 'Edit Profile',
              //   subTitle: 'Pengaturan Profile',
              //   onTap: () {},
              // ),

              // const SizedBox(
              //   height: 8,
              // ),

              // Hubungi Kami
              MenuProfile(
                image: 'assets/hubungi_kami.png',
                title: 'Hubungi Kami',
                subTitle: 'Sampaikan kendala, kritik, dan saran Anda',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CallDevScreen()),
                  );
                },
              ),

              const SizedBox(
                height: 8,
              ),

              // Tentang Aplikasi
              MenuProfile(
                image: 'assets/tentang_app.png',
                title: 'Tentang Aplikasi',
                subTitle: 'Lihat informasi lengkap tentang aplikasi',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutScreen()),
                  );
                },
              ),

              // Button Hapus AwesomeDialog
              Container(
                margin: const EdgeInsets.only(
                  top: 50,
                  left: 16,
                  right: 16,
                ),
                width: double.infinity,
                height: 56,
                child: AnimatedButton(
                  text: "Keluar Akun",
                  // text: AppLocalizations.of(context)!.btnDelete,
                  // color: dangerSecond,
                  color: Colors.red[700],
                  borderRadius: BorderRadius.circular(10),
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.topSlide,
                      showCloseIcon: true,
                      alignment: Alignment.centerLeft,
                      title: 'Keluar Akun Presensiku?',
                      desc:
                          'Jika kamu ingin menggunakan layanan Presensiku kembali, kamu perlu masuk ke akunmu lagi.',
                      // desc: AppLocalizations.of(context)!.subTitleWarning,

                      // Action to perform on cancel and ok buttons
                      btnCancel: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                          backgroundColor: whiteColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          // AppLocalizations.of(context)!.btnCancelled,
                          'Batal',
                          style: TextStyle(color: blackColor),
                        ),
                      ),
                      btnOk: Consumer<RegisterProvider>(
                          builder: (context, provider, _) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () async {
                            // Keluar Akun
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));

                            Navigator.pop(context);
                            
                            provider.logOut();
                          },
                          child: Text(
                            // AppLocalizations.of(context)!.logOut,
                            'Keluar',
                            style: TextStyle(color: whiteColor),
                          ),
                        );
                      }),
                    ).show();
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
