import 'package:aplikasi_pengelola_keuangan/controller/sql_helper.dart';
import 'package:aplikasi_pengelola_keuangan/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aplikasi_pengelola_keuangan/controller/user_provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  final DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    // Access the UserProvider to get user data
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Ubah Password",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password Saat Ini"),
            ),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password Baru"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _changePassword(user!);
              },
              child: Text("Simpan Password Baru"),
            ),
            SizedBox(height: 40),
            Text(
              "About Me",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CircleAvatar(
              radius: 50.0, // Atur ukuran radius sesuai keinginan
              backgroundColor: Colors.blue, // Atur warna latar belakang
              child: Container(
                width: 100.0, // Atur ukuran gambar
                height: 100.0, // Atur ukuran gambar
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Ubah ke bentuk lingkaran
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'assets/images/fotoku.jpg'), // Ganti dengan path gambar Anda
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Aplikasi ini dibuat oleh :"),
            Text("Rheina Yulia Wati"),
            Text("2141764136"),
          ],
        ),
      ),
    );
  }

  void _changePassword(User user) {
    String currentPasswordInput = currentPasswordController.text;
    String newPasswordInput = newPasswordController.text;

    if (currentPasswordInput == user.password) {
      // Password saat ini benar, simpan password baru
      dbHelper.changePassword(user.username!, newPasswordInput);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password berhasil diubah."),
      ));
    } else {
      // Password saat ini salah
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password saat ini salah. Ubah password gagal."),
      ));
    }
  }
}
