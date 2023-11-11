import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris_firebase_flutter/view_model/get_data_provider.dart';
import 'package:hris_firebase_flutter/view_model/home_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../common/theme.dart';

class BodyHome extends StatefulWidget {
  const BodyHome({super.key});

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  @override
  void initState() {
    super.initState();

    final providerGetData = context.read<GetDataProvider>();
    providerGetData.getData();
  }

  @override
  Widget build(BuildContext context) {
    // Menggunakan context.read<HomeProvider>() untuk mengakses HomeProvider
    final homeProvider = context.read<HomeProvider>();

    return SafeArea(
      child: Container(
        color: const Color(0xffF1F1F1),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset('assets/bg_header.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // PRESENSIKU
                        Image.asset(
                          'assets/logo_app.png',
                          width: 80,
                        ),
                        const SizedBox(width: 12),

                        const SizedBox(height: 16),

                        // NOTES: Header Selamat Pagi Name
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 4),
                              const CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage('assets/orang.png'),
                              ),

                              const SizedBox(width: 8),

                              // NOTE: ISI
                              Expanded(
                                child: Consumer<GetDataProvider>(
                                    builder: (context, data, widget) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Selamat Bekerja ${data.usersData?.name ?? 'Null'}",
                                        style: fontRoboto.copyWith(
                                          fontSize: 12,
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.access_time_sharp,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Daily Shift: Maintenance',
                                            style: fontRoboto.copyWith(
                                              fontSize: 12,
                                              fontWeight: semiBold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),

                                      // Sisa Cuti, Agenda, Jadwal Kerja
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/sisa_cuti.png',
                                                width: 40,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '${data.usersData?.sisaCuti ?? 'Null'} Sisa Cuti',
                                                style: fontRoboto.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: medium,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/agenda.png',
                                                width: 40,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Agenda',
                                                style: fontRoboto.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: medium,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/jadwal_kerja.png',
                                                width: 40,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Jadwal Kerja',
                                                style: fontRoboto.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: medium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                              ),
                              const SizedBox(width: 4),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // NOTE: MENU
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Menu',
                        style: fontRoboto.copyWith(
                          fontSize: 16,
                          fontWeight: bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // NOTE: ISI MENU
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.4), // Warna Bayangan
                              spreadRadius:
                                  1, // Seberapa jauh bayangan menyebar
                              blurRadius: 1, // Seberapa kabur bayangan
                              offset: const Offset(0, 0), // Posisi bayangan
                            ),
                          ],
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: homeProvider.menuItems.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 160 / 190, // Setel rasio aspek
                          ),
                          itemBuilder: (BuildContext context, index) {
                            return InkWell(
                              onTap: () {
                                // final provider = context.read<HomeProvider>();
                                // Navigasi ke Menu
                                if (index == 0) {
                                  // Masuk
                                } else if (index == 1) {
                                  // Pulang
                                } else if (index == 2) {
                                  // Masuk Lapangan
                                } else if (index == 3) {
                                  // Pulang Lapangan
                                } else if (index == 4) {
                                  // Ajukan Izin
                                } else if (index == 5) {
                                  // Setujui Izin
                                } else if (index == 6) {
                                  // Mulai Lembur
                                } else if (index == 7) {
                                  // Selesai Lembur
                                }
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        index == 0 ? 20.0 : 0.0),
                                    topRight: Radius.circular(
                                        index == 3 ? 20.0 : 0.0),
                                    bottomLeft: Radius.circular(
                                        index == 4 ? 20.0 : 0.0),
                                    bottomRight: Radius.circular(
                                        index == 7 ? 20.0 : 0.0),
                                  ),
                                ),
                                margin: const EdgeInsets.all(0.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      index == 0
                                          ? 'assets/masuk.png'
                                          : index == 1
                                              ? 'assets/pulang.png'
                                              : index == 2
                                                  ? 'assets/masuk.png'
                                                  : index == 3
                                                      ? 'assets/pulang.png'
                                                      : index == 4
                                                          ? 'assets/ajukan_izin.png'
                                                          : index == 5
                                                              ? 'assets/setujui_izin.png'
                                                              : index == 6
                                                                  ? 'assets/mulai_lembur.png'
                                                                  : 'assets/selesai_lembur.png',
                                      width: 28,
                                      height: 28,
                                    ),
                                    Text(
                                      homeProvider.menuItems[index],
                                      textAlign: TextAlign.center,
                                      style: fontRoboto.copyWith(
                                        fontWeight: medium,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Quesioner
              Container(
                color: const Color(0xffF1F1F1),
                width: double.infinity,
                height: 150,
                child: Card(
                  color: Colors.white,
                  margin: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/icon_survei.png',
                        color: const Color(0xff00AFFF),
                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Silahkan mengisi quesioner',
                            style: fontRoboto.copyWith(
                              fontSize: 14,
                              fontWeight: medium,
                            ),
                          ),
                          const SizedBox(height: 4),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                    0xff00AFFF), // Warna latar belakang tombol
                                foregroundColor:
                                    Colors.white, // Warna teks tombol
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              final provider = context.read<HomeProvider>();
                              provider.launchQuesioner();
                            },
                            child: Text(
                              'Isi Quesioner',
                              style: fontRoboto.copyWith(
                                fontSize: 14,
                                fontWeight: medium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Pengumuman
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, top: 16, bottom: 12, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pengumuman',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'Lihat Semua',
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: medium,
                                  color: const Color(0xff00AFFF)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CarouselSlider.builder(
                      itemCount: homeProvider.itemPengumuman.length,
                      itemBuilder: (context, index, realIndex) {
                        return Card(
                          child: Row(
                            children: [
                              // Left
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                child: Image.asset(
                                  'assets/orang.png',
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // 'Judul',
                                      // homeProvider.itemPengumuman[index],
                                      homeProvider.itemPengumuman[index]
                                                  .length <=
                                              homeProvider.maxLengthJudul
                                          ? homeProvider.itemPengumuman[index]
                                          : '${homeProvider.itemPengumuman[index].substring(0, homeProvider.maxLengthJudul)}...',

                                      style: GoogleFonts.roboto(
                                        fontSize: 13,
                                        fontWeight: bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      // truncatedText,
                                      // homeProvider.itemIsiPengumuman[index],
                                      homeProvider.itemIsiPengumuman[index]
                                                  .length <=
                                              homeProvider.maxLength
                                          ? homeProvider
                                              .itemIsiPengumuman[index]
                                          : '${homeProvider.itemIsiPengumuman[index].substring(0, homeProvider.maxLength)}...',
                                      style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        fontWeight: reguler,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '01 Oktober 2023',
                                      style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        fontWeight: reguler,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 150,
                        autoPlay: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
