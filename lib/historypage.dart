import 'package:ecobites/uploadBarang.dart';
import 'package:ecobites/Widgets/HistoryPembelian.dart';
import 'package:ecobites/Widgets/HistoryPenjualan.dart';
import 'package:ecobites/Widgets/Secondarytabbar.dart';
import 'package:ecobites/homepage.dart';
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
         title: const Text(
          'History Page',
          style: TextStyle(color: Colors.black,
          fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFFAFAFA),
      ),
      body: Column(
        children: [
          SecondaryTabbar(
            title: 'Penjualan',
            title2: 'Pembelian',
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
            child: _selectedTabIndex == 0 ? SalesView() : PurchaseView(),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
              break;
          }
        },
        selectedItemColor: const Color(0xFF92E3A9),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
