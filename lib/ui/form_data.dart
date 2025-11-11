import 'package:flutter/material.dart';
import 'package:h1d023030_tugas6/ui/tampil_data.dart';
import 'package:intl/intl.dart';

class FormData extends StatefulWidget {
  const FormData({super.key});

  @override
  State<FormData> createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {
  final _namaController = TextEditingController();
  final _nimController = TextEditingController();

  DateTime? _tanggalLahir;

  Future<void> _pilihTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _tanggalLahir ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: 'Pilih Tanggal Lahir',
      cancelText: 'Batal',
      confirmText: 'Pilih',
    );
    if (picked != null && picked != _tanggalLahir) {
      setState(() {
        _tanggalLahir = picked;
      });
    }
  }


  void _kirimData() {
    if (_namaController.text.isEmpty ||
        _nimController.text.isEmpty ||
        _tanggalLahir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua field harus diisi!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    String nama = _namaController.text;
    String nim = _nimController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TampilData(
          nama: nama,
          nim: nim,
          tanggalLahir: _tanggalLahir!,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Data Diri'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Silakan isi data Anda di bawah ini',
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),


              TextField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 20),


              TextField(
                controller: _nimController,
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  prefixIcon: Icon(Icons.school_outlined),
                ),
              ),
              const SizedBox(height: 20),


              Text(
                'Tanggal Lahir',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.grey[800]),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                icon: const Icon(Icons.calendar_month_outlined),

                label: Text(
                  _tanggalLahir == null
                      ? 'Pilih Tanggal'
                      : DateFormat('d MMMM yyyy').format(_tanggalLahir!),
                  style: TextStyle(
                    color: _tanggalLahir == null ? Colors.grey[700] : Colors.black,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.centerLeft,
                  side: BorderSide(color: Colors.grey[400]!),
                ),
                onPressed: () => _pilihTanggal(context),
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: _kirimData,
                child: const Text('Tampilkan Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
