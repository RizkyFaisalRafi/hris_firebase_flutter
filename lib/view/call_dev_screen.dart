import 'package:flutter/material.dart';
import 'package:hris_firebase_flutter/view_model/call_dev_provider.dart';
import 'package:provider/provider.dart';

import '../common/theme.dart';

class CallDevScreen extends StatelessWidget {
  const CallDevScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CallDevProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Developer',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Untuk keluhan, kritik, dan saran dalam penggunaan aplikasi Presensiku, Anda dapat menghubungi:',
              style: fontRoboto.copyWith(fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {
                provider.launchWhatsApp();
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    '0895-4128-92094',
                    style: fontRoboto.copyWith(fontSize: 15),
                  ),
                  leading: Image.asset(
                    'assets/icon_wa.png',
                    width: 28,
                    height: 28,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                provider.launchEmail();
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    'rizkyfaisalrafi123@gmail.com',
                    style: fontRoboto.copyWith(fontSize: 15),
                  ),
                  leading: Image.asset(
                    'assets/icon_email_dua.png',
                    width: 28,
                    height: 28,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Hubungi kami pada saat jam kerja:\n09:00 - 16:00 WIB',
              style: fontRoboto.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
