import 'package:flutter/material.dart';
import 'dart:io';


// import 'package:hris_firebase_flutter/view/account_page.dart';

import 'package:hris_firebase_flutter/view/history_page.dart';
import 'package:hris_firebase_flutter/view/payroll_page.dart';
import 'package:hris_firebase_flutter/widgets/body_home.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart'
    show ImagePicker, ImageSource, XFile;
import 'package:url_launcher/url_launcher.dart';

import '../view/account_page.dart';

class HomeProvider extends ChangeNotifier {
  int selectedIndex = 0;
  // int get selectedIndex => _selectedIndex;
  int activeIndex = 0;

  void _onItemTapped(int index) {
    // Akan bertambah 1 selectedIndexnya
    selectedIndex = index;
    notifyListeners();
  }

  bodyNavigation() {
    switch (selectedIndex) {
      // HomeScreen Widget
      case 0:
        return const BodyHome();
      // History Screen
      case 1:
        return const HistoryPage();
      // Payroll/Penggajian Screen
      case 2:
        return const PayrollPage();
      // Account/Profil Screen
      case 3:
        return const AccountPage();
    }
    return null;
  }

  bottomNav() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mark_as_unread_sharp),
              label: 'Penggajian',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Akun',
            ),
          ],
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xff1E88E5),
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }

  String announcementText =
      'Penggunaan absensi agar dioptimalkan dengan penambahan fitur lain lainnya...';
  int maxLength = 30; // Atur panjang maksimal teks isi yang ditampilkan
  int maxLengthJudul = 35; // Atur panjang maksimal teks isi yang ditampilkan
  final List<String> menuItems = [
    'Masuk\nShift',
    'Pulang\nShift',
    'Masuk\nLapangan',
    'Pulang\nLapangan',
    "Ajukan\nIzin",
    "Setujui\nIzin",
    "Mulai\nLembur",
    "Selesai\nLembur"
  ];

  final List<String> itemPengumuman = [
    'Peningkatan Gaji',
    'Program Pengembangan Karyawan',
    'Kenaikan Jabatan Internal',
    'Penghargaan Karyawan Terbaik Bulan Ini',
    'Program Kesejahteraan Karyawan',
    'Hari Raya Perusahaan',
  ];

  final List<String> itemIsiPengumuman = [
    'Kami senang mengumumkan bahwa dalam pengakuan atas kontribusi luar biasa Anda kepada perusahaan selama beberapa tahun terakhir, kami akan melakukan peningkatan gaji untuk semua karyawan. Peningkatan ini akan mulai berlaku pada [30 Desember 2023]. Kami sangat menghargai dedikasi Anda dan berharap Anda terus berkinerja dengan baik.',
    'Kami senang mengumumkan peluncuran program pengembangan karyawan baru kami. Program ini dirancang untuk membantu Anda mengembangkan keterampilan dan karir Anda di perusahaan. Ini akan mencakup pelatihan, mentoring, dan peluang pertumbuhan yang lebih besar. Kami berkomitmen untuk mendukung perkembangan profesional Anda.',
    'Kami dengan senang hati mengumumkan bahwa [Rizky Faisal Rafi] telah dipromosikan ke posisi [Co Founder]. Kenaikan ini adalah hasil dari kinerja luar biasa dan kontribusi yang telah diberikan selama bertahun-tahun. Kami yakin [Rizky Faisal Rafi] akan terus berkinerja dengan sangat baik di peran baru ini.',
    'Kami ingin memberikan penghargaan khusus kepada [Irwan Richwandi Putra] atas kinerja yang luar biasa selama bulan ini. Prestasi Anda dalam [Programming Back End Golang] sangat mengesankan. Kami berterima kasih atas dedikasi Anda kepada perusahaan.',
    'Kami ingin memperkenalkan program kesejahteraan karyawan baru kami, yang dirancang untuk meningkatkan kualitas hidup Anda. Program ini akan mencakup manfaat tambahan seperti asuransi kesehatan yang lebih baik, program kesehatan, dan sumber daya untuk mencapai keseimbangan kerja-hidup yang lebih baik.',
    'Kami berencana untuk merayakan Hari Raya Perusahaan pada [tanggal]. Ini adalah kesempatan bagi semua karyawan untuk bersatu, berbagi cerita, dan merayakan prestasi perusahaan selama tahun ini. Kami mengundang Anda untuk bergabung dalam perayaan ini dan menikmati waktu bersama rekan-rekan kerja.\n\nPastikan untuk menyesuaikan pengumuman dengan konteks dan kebutuhan perusahaan Anda. Pengumuman ini dapat digunakan untuk memotivasi dan memberi pengakuan kepada karyawan yang sudah bekerja.',
  ];

  String? imagePath;
  // Simpan waktu, tanggal, dan hari ke dalam variabel (Monday, 25 September 2023)
  final String currentDate =
      DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now());

  /// todo-gallery-04: create a image variable so save image information
  XFile? imageFile;

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  /// todo-gallery-04-02: create a function to save a value
  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  // url_launcher to Quesioner
  void launchQuesioner() async {
    String url = "forms.gle/iPecSSdNnV2sb2wq8";
    final Uri quesionerUrl = Uri(scheme: 'https', path: url);

    if (await canLaunchUrl(quesionerUrl)) {
      await launchUrl(quesionerUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $quesionerUrl';
    }
  }

  // url_launcher to Info Setting Camera
  Future<void> launchUrlInfoSettingCamera() async {
    String url = "www.leskompi.com/izin-aplikasi/";
    final Uri cameraInfoUrl = Uri(scheme: 'https', path: url);

    if (await canLaunchUrl(cameraInfoUrl)) {
      await launchUrl(cameraInfoUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $cameraInfoUrl';
    }
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

  onCameraView(BuildContext context, Function onTapNav) async {
    // Minta izin akses kamera
    final PermissionStatus status = await Permission.camera.request();

    if (status.isGranted) {
      // todo-image-04: check if not Mobile
      final isAndroid = defaultTargetPlatform == TargetPlatform.android;
      final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
      final isNotMobile = !(isAndroid || isiOS);
      if (isNotMobile) return;

      // todo-image-01: initial ImagePicker class
      final picker = ImagePicker();

      // todo-image-02: pick image from camera app
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );

      // todo-image-03: check the result and update the image
      if (pickedFile != null) {
        setImageFile(pickedFile);
        setImagePath(pickedFile.path);

        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => onTapNav(),
            ),
          );
        }
      }
    } else {
      // Izin akses ditolak, tampilkan pesan kesalahan atau permintaan lagi
      // Anda dapat memberikan feedback kepada pengguna untuk memberikan izin akses
      // atau memberi tahu mereka cara mengubahnya di pengaturan perangkat mereka.
      // Misalnya:
      if (status.isDenied) {
        openAppSettings(); // Buka pengaturan aplikasi untuk mengaktifkan izin
      }
    }
  }
}
