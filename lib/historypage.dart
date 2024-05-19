import 'package:ecobites/Widgets/secondarytabbar.dart';
import 'package:ecobites/homepage.dart';
import 'package:ecobites/uploadpage.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedTabIndex = 0;
  String? _selectedDropdown1;
  String? _selectedDropdown2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('History Page',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          elevation: 0,
          backgroundColor: Color(0xFFFAFAFA),
        ),
        body: Column(
          children: [
            SecondaryTabbar(
              onTabSelected: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  value: _selectedDropdown1,
                  hint: Text("Status"),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedDropdown1 = newValue;
                    });
                  },
                  items: <String>['On Progress', 'Done', 'Cancelled']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: _selectedDropdown2,
                  hint: Text("Kategori"),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedDropdown2 = newValue;
                    });
                  },
                  items: <String>['Makanan', 'Bahan Daur Ulang', 'Daur Ulang']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Expanded(
              child: _selectedTabIndex == 0 ? _buildSalesView() : _buildPurchaseView(),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.upload),
              label: 'Upload',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Activity',
            ),
          ],
          currentIndex: 2,
          onTap: (int index) {
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UploadBarang()),
                );
                break;
              case 2:
                break;
            }
          },
          selectedItemColor: const Color(0xFF92E3A9),
          unselectedItemColor: Colors.grey,
        ));
  }

  Widget _buildSalesView() {
    return ListView.builder(
      itemCount: 10, // Contoh jumlah data
      itemBuilder: (context, index) {
        return Center(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8.0),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('2021-12-01'),
                        Text('On Progress'),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0), // Menambahkan jarak antar baris
                  Row(
                    children: [
                      Image.asset(
                        'assets/product2.png',
                        width: 70,
                        height: 70,
                      ),
                      SizedBox(width: 16.0), // Menambahkan jarak antara gambar dan teks
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nama Produk $index'),
                            Text('Jumlah: 3'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPurchaseView() {
    return ListView.builder(
      itemCount: 5, // Contoh jumlah data
      itemBuilder: (context, index) {
        return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8.0),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('2021-12-01'),
                        Text('Done'),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0), // Menambahkan jarak antar baris
                  Row(
                    children: [
                      Image.asset(
                        'assets/product3.png',
                        width: 70,
                        height: 70,
                      ),
                      SizedBox(width: 16.0), // Menambahkan jarak antara gambar dan teks
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nama Produk $index'),
                            Text('Jumlah: 3'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
      },
    );
  }
}
