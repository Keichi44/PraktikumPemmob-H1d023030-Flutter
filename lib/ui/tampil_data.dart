import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TampilData extends StatelessWidget {
  final String nama;
  final String nim;
  final DateTime tanggalLahir;

  const TampilData({
    super.key,
    required this.nama,
    required this.nim,
    required this.tanggalLahir,
  });


  int _hitungUmur(DateTime tanggalLahir) {
    final DateTime tanggalSekarang = DateTime.now();
    int umur = tanggalSekarang.year - tanggalLahir.year;
    if (tanggalSekarang.month < tanggalLahir.month ||
        (tanggalSekarang.month == tanggalLahir.month &&
            tanggalSekarang.day < tanggalLahir.day)) {
      umur--;
    }
    return umur;
  }

  @override
  Widget build(BuildContext context) {
    final int umur = _hitungUmur(tanggalLahir);

    final String tglLahirFormatted = DateFormat('d MMMM yyyy', 'id_ID').format(tanggalLahir);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perkenalan Diri'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.indigo,
              child: Icon(Icons.person, size: 70, color: Colors.white),
            ),
            const SizedBox(height: 32),


            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(

                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black87,
                  height: 1.5,
                ),
                children: <TextSpan>[
                  const TextSpan(text: 'Halo! Nama saya adalah '),

                  TextSpan(
                    text: nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ', dengan NIM '),

                  TextSpan(
                    text: nim,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: '. Saya lahir pada tanggal '),

                  TextSpan(
                    text: tglLahirFormatted,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ', dan saat ini saya berumur '),

                  TextSpan(
                    text: '$umur tahun',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: '. Senang bertemu dengan Anda!'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
