import 'package:flutter/material.dart';

class PengaturanAkun extends StatefulWidget {
  const PengaturanAkun({super.key});

  @override
  State<PengaturanAkun> createState() => _PengaturanAkunState();
}

class _PengaturanAkunState extends State<PengaturanAkun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Akun'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF000000),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFFAFAFA),
      ),
    );
  }
}