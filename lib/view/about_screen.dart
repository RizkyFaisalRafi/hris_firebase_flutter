import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double containerWidth = screenWidth * 0.5;
    return Scaffold(
      backgroundColor: const Color(0xffEFEFEF),
      appBar: AppBar(
        // backgroundColor: Colors.black,
        title: const Text('About'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo_app.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'PRESENSIKU',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aplikasi versi 1.0 - PRESENSIKU',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'PRESENSIKU merupakan sebuah aplikasi Human Resource Information System. Berikut beberapa fitur utama yang ada pada aplikasi:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.donut_large_rounded),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Presensi (Now)'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.donut_large_rounded),
                    SizedBox(
                      width: 8,
                    ),
                    Text('History Presensi (Now)'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.donut_large_rounded),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Perizinan Karyawan (Now)'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.donut_large_rounded),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Sisa Cuti (Now)'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.donut_large_rounded),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Qusioner (Now)'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.donut_large_rounded),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Pengumuman (Coming Soon)'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.donut_large_rounded),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Penggajian (Coming Soon)'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.donut_large_rounded),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Akun: Edit Profile (Coming Soon)'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
