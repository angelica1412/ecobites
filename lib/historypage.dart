import 'package:ecobites/Widgets/secondarytabbar.dart';
import 'package:ecobites/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'UploadBarang.dart';
import 'authenticate/Controller/historyController.dart';

class ActivityCard {
  final String id; // ID dari dokumen Firestore
  final String storeID;
  final String storeName;
  final List<Map<String, dynamic>> products;
  final double totalPrice;
  final String address;
  final bool isDelivery;
  final List<Map<String, dynamic>> voucher; // Assuming voucher is a list of maps
  final String paymentMethod;
  final DateTime date;

  ActivityCard({
    required this.id,
    required this.storeID,
    required this.storeName,
    required this.products,
    required this.totalPrice,
    required this.address,
    required this.isDelivery,
    required this.voucher,
    required this.paymentMethod,
    required this.date,
  });

  factory ActivityCard.fromMap(Map<String, dynamic> data, String documentId) {
    final DateFormat dateFormat = DateFormat('dd MMMM yyyy HH:mm:ss'); // Ubah format untuk termasuk jam
    DateTime parsedDate;

    try {
      parsedDate = dateFormat.parse(data['date'] ?? DateTime.now().toIso8601String());
    } catch (e) {
      // Handle format exception jika terjadi kesalahan parsing
      parsedDate = DateTime.now();
    }
    return ActivityCard(
      id: documentId,
      storeID: data['storeID'] ?? '',
      storeName: data['storeName'] ?? '',
      products: List<Map<String, dynamic>>.from(data['Products'] ?? []).map((product) {
        return {
          'namaBarang': product['namaBarang'] ?? '',
          'quantity': product['quantity'] ?? 0,
          'productImageURL': product['productImageURL'] ?? '',
        };
      }).toList(),
      totalPrice: data['totalPrice']?.toDouble() ?? 0.0,
      address: data['address'] ?? '',
      isDelivery: data['isDelivery'] ?? false,
      voucher: List<Map<String, dynamic>>.from(data['voucher'] ?? []),
      paymentMethod: data['paymentMethod'] ?? '',
      date: parsedDate,
    );
  }
}


class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedTabIndex = 0;
  String? _selectedDropdown1;
  String? _selectedDropdown2;
  List<ActivityCard> salesData = [];
  List<ActivityCard> purchaseData = [];
  bool _isSalesDataLoading = true;
  bool _isPurchaseDataLoading = true;
  // List<ActivityCard> salesData = [
  //   ActivityCard(date: '2021-12-01', status: 'On Progress', imageName: 'assets/martabak.jpg', productName: 'Martabak', quantity: 3),
  //   ActivityCard(date: '2021-12-02', status: 'Done', imageName: 'assets/pupuk.png', productName: 'Pupuk Kualitas bagus', quantity: 2),
  //   ActivityCard(date: '2021-12-03', status: 'Cancelled', imageName: 'assets/sosis.jpg', productName: 'Sosis Bakar', quantity: 5),
  //   // Tambahkan lebih banyak data sesuai kebutuhan
  // ];
  //
  // List<ActivityCard> purchaseData = [
  //   ActivityCard(date: '2021-12-01', status: 'Done', imageName: 'assets/pupuk.png', productName: 'Pupuk Kualitas bagus', quantity: 1),
  //   ActivityCard(date: '2021-12-04', status: 'On Progress', imageName: 'assets/sosis.jpg', productName: 'Sosis Bakar', quantity: 4),
  //   // Tambahkan lebih banyak data sesuai kebutuhan
  // ];

  @override
  void initState() {
    super.initState();
    _fetchHistoryData();
  }
  Future<void> _fetchHistoryData() async {
    // Start loading
    setState(() {
      _isSalesDataLoading = true;
      _isPurchaseDataLoading = true;
    });

    try {
      // Load sales history
      List<ActivityCard> purchases = await readStoreHistoryFromFirestore();
      List<ActivityCard> sales = await readUserHistoryFromFirestore();

      setState(() {
        // Sort data based on date
        purchaseData = purchases..sort((a, b) => b.date.compareTo(a.date));
        salesData = sales..sort((a, b) => b.date.compareTo(a.date));
      });
    } catch (e) {
      // Handle error
      print('Error fetching history data: $e');
    } finally {
      // End loading
      setState(() {
        _isSalesDataLoading = false;
        _isPurchaseDataLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Activity Page',
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        elevation: 0,
        backgroundColor: Color(0xFFFAFAFA),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
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
    if (_isSalesDataLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (salesData.isEmpty) {
      return const Center(
        child: Text('No sales data available'),
      );
    }
    return ListView.separated(
      itemCount: salesData.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.0), // Tambahkan jarak setinggi 16.0 antara setiap Card
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
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              activity.storeName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DateFormat('dd MMMM yyyy').format(activity.date), style: TextStyle(fontSize: 12),), // Tanggal di atas
                              Text(DateFormat('HH:mm:ss').format(activity.date), style: TextStyle(fontSize: 12),), // Jam di bawah
                            ],
                          ),
                          // Text(activity.status),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(height: 16.0), // Tambahkan jarak setinggi 16.0 antara setiap Card
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: activity.products.length,
                    itemBuilder: (context, idx) {
                      final product = activity.products[idx];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.network(
                                product['productImageURL'],
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    height: 70,
                                    width: 70,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded/(loadingProgress.expectedTotalBytes ?? 1)
                                            :null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                  return const Icon(Icons.error);
                                }
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product['namaBarang']),
                                  Text('Jumlah: ${product['quantity']}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8,),
                  Divider(),
                  SizedBox(height: 8.0), // Jarak antara produk dan total price
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Jumlah Harga', // Menampilkan total price dengan format 2 digit desimal
                          style: TextStyle(
                          ),
                        ),
                        Text(
                          'Rp ${NumberFormat("#,##0", "id_ID").format(activity.totalPrice)}', // Menampilkan total price dengan format 2 digit desimal// Menampilkan total price dengan format 2 digit desimal
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
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
    if (_isPurchaseDataLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (purchaseData.isEmpty) {
      return const Center(
        child: Text('No purchase data available'),
      );
    }
    return ListView.separated(
      itemCount: purchaseData.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.0), // Tambahkan jarak setinggi 16.0 antara setiap Card
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
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            activity.storeName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DateFormat('dd MMMM yyyy').format(activity.date), style: TextStyle(fontSize: 12),), // Tanggal di atas
                              Text(DateFormat('HH:mm:ss').format(activity.date), style: TextStyle(fontSize: 12),), // Jam di bawah
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(height: 16.0), // Tambahkan jarak setinggi 16.0 antara setiap Card
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: activity.products.length,
                    itemBuilder: (context, idx) {
                      final product = activity.products[idx];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Image.network(
                              product['productImageURL'],
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    height: 70,
                                    width: 70,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded/(loadingProgress.expectedTotalBytes ?? 1)
                                            :null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                  return const Icon(Icons.error);
                                }
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product['namaBarang']),
                                  Text('Jumlah: ${product['quantity']}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8.0),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Jumlah Harga', // Menampilkan total price dengan format 2 digit desimal
                          style: TextStyle(
                          ),
                        ),
                        Text(
                          'Rp ${NumberFormat("#,##0", "id_ID").format(activity.totalPrice)}', // Menampilkan total price dengan format 2 digit desimal // Menampilkan total price dengan format 2 digit desimal
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
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