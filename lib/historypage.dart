import 'package:ecobites/Widgets/secondarytabbar.dart';
import 'package:ecobites/homepage.dart';
import 'package:flutter/material.dart';

import 'UploadBarang.dart';

class ActivityCard {
  final String date;
  final String status;
  final String imageName;
  final String productName;
  final int quantity;

  ActivityCard({
    required this.date,
    required this.status,
    required this.imageName,
    required this.productName,
    required this.quantity,
  });
}

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedTabIndex = 0;
  String? _selectedDropdown1;
  String? _selectedDropdown2;

  List<ActivityCard> salesData = [
    ActivityCard(date: '2021-12-01', status: 'On Progress', imageName: 'assets/martabak.jpg', productName: 'Martabak', quantity: 3),
    ActivityCard(date: '2021-12-02', status: 'Done', imageName: 'assets/pupuk.png', productName: 'Pupuk Kualitas bagus', quantity: 2),
    ActivityCard(date: '2021-12-03', status: 'Cancelled', imageName: 'assets/sosis.jpg', productName: 'Sosis Bakar', quantity: 5),
    // Tambahkan lebih banyak data sesuai kebutuhan
  ];

  List<ActivityCard> purchaseData = [
    ActivityCard(date: '2021-12-01', status: 'Done', imageName: 'assets/pupuk.png', productName: 'Pupuk Kualitas bagus', quantity: 1),
    ActivityCard(date: '2021-12-04', status: 'On Progress', imageName: 'assets/sosis.jpg', productName: 'Sosis Bakar', quantity: 4),
    // Tambahkan lebih banyak data sesuai kebutuhan
  ];

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
            title: 'Pembelian',
            title2: 'Penjualan',
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
            child: _selectedTabIndex == 0
                ? _buildSalesView()
                : _buildPurchaseView(),
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
            icon: Icon(Icons.history),
            label: 'Activity',
          ),
        ],
        currentIndex: 1,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 1:
              break;
          }
        },
        selectedItemColor: const Color(0xFF92E3A9),
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildSalesView() {
    return ListView.builder(
      itemCount: salesData.length,
      itemBuilder: (context, index) {
        final activity = salesData[index];
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
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(activity.date),
                        Text(activity.status),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Image.asset(
                        activity.imageName,
                        width: 70,
                        height: 70,
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(activity.productName),
                            Text('Jumlah: ${activity.quantity}'),
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
      itemCount: purchaseData.length,
      itemBuilder: (context, index) {
        final activity = purchaseData[index];
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
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(activity.date),
                        Text(activity.status),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Image.asset(
                        activity.imageName,
                        width: 70,
                        height: 70,
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(activity.productName),
                            Text('Jumlah: ${activity.quantity}'),
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
}
