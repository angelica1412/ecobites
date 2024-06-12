import 'package:ecobites/DoubleBackToExit.dart';
import 'package:ecobites/Widgets/voucher.dart';
import 'package:ecobites/authenticate/Controller/storeController.dart';
import 'package:flutter/material.dart';
import 'package:ecobites/Store.dart';
import 'package:ecobites/Widgets/storeCard.dart';
import 'package:ecobites/historypage.dart';
import 'package:ecobites/profile.dart';
import 'package:ecobites/voucherPage.dart';
import 'package:get/get.dart';

import 'UploadBarang.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? usedVoucherCode;
  bool isVoucherUsed = false;
  Color searchIconColor = Colors.grey; // State variable for search icon color
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  Future<List<Map<String, String>>?>? _storeFuture;

  @override
  void initState() {
    super.initState();
    _storeFuture = getAllStores();
  }

  void _refreshStoreData() {
    setState(() {
      _storeFuture = getAllStores();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBackToExit(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight:
            100, // Mengatur tinggi toolbar (termasuk title dan actions)
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Menengahkan title secara vertikal
          children: [
            Image.asset(
              'assets/logo.png',
              height: 75,
              width: 75,
            ),
            Text(
              'Ecobites',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 178, 178, 178),
              shape: BoxShape.circle,
            ),
            width: 48,
            height: 48,
            margin: EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(Icons.person, size: 24),
              color: Colors.black,
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
                if (result == true) {
                  _refreshStoreData();
                  // If data was saved, reload the store data
                }
              },
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1), // Mengatur tinggi border
          child: Container(
            color: Colors.black, // Warna border
            height: 1, // Ketebalan border
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, String>>?>(
          future: _storeFuture,
          builder: (context, snapshot) {
            final stores = snapshot.data ?? [];
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      // onTap: () {
                      //   setState(() {
                      //     searchIconColor = const Color(0xFF92E3A9); // Change color when tapped
                      //   });
                      // },
                      decoration: InputDecoration(
                        hintText: 'Search for store...',
                        prefixIcon: Icon(Icons.search, color: searchIconColor),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF92E3A9), width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (snapshot.connectionState == ConnectionState.waiting)
                      Center(child: CircularProgressIndicator())
                    else if (snapshot.hasError)
                      Center(child: Text('Error: ${snapshot.error}'))
                    else if (!snapshot.hasData || snapshot.data!.isEmpty)
                      Center(child: Text('No stores found'))
                    else if (searchQuery.isEmpty) ...[
                      // Display StoreCards with image on top and smaller size when search query is empty
                      Text(
                        'Recently Viewed',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: stores.length,
                          itemBuilder: (context, index) {
                            final store = stores[index];
                            return SizedBox(
                              width: 150,
                              child: StoreCard(
                                  store: Store(
                                    name: store['namaToko'] ?? '',
                                    description: store['deskripsi'] ?? '',
                                    imageURL:
                                        store['imageURL'] ?? 'assets/shop.png',
                                    storeID: store['id'] ?? '',
                                  ),
                                  imageOnTop: true),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: VoucherState(
                            fromCheckout: false, onVoucherUsed: (Voucher) {}),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Most Viewed',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: stores.length,
                          itemBuilder: (context, index) {
                            final store = stores[index];
                            return SizedBox(
                              width: 150,
                              child: StoreCard(
                                  store: Store(
                                    name: store['namaToko'] ?? '',
                                    description: store['deskripsi'] ?? '',
                                    imageURL:
                                        store['imageURL'] ?? 'assets/shop.png',
                                    storeID: store['id'] ?? '',
                                  ),
                                  imageOnTop: true),
                            );
                          },
                        ),
                      ),
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Menunjukkan hasil "$searchQuery"',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      // Display StoreCards in default layout after searching
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: stores.length,
                        itemBuilder: (context, index) {
                          final filteredStores = stores
                              .where((store) => store["namaToko"]!
                                  .toLowerCase()
                                  .contains(searchQuery.toLowerCase()))
                              .toList();
                          if (index < 0 || index >= filteredStores.length) {
                            return SizedBox(); // Atau widget lain yang sesuai dengan kebutuhan Anda
                          }
                          final store = filteredStores[index];
                          return StoreCard(
                              store: Store(
                            name: store['namaToko'] ?? '',
                            description: store['deskripsi'] ?? '',
                            imageURL: store['imageURL'] ?? 'assets/shop.png',
                            storeID: store['id'] ?? '',
                          ));
                        },
                      ),
                    ],
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }),
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
        currentIndex: 0, // Menetapkan indeks saat ini ke halaman Upload
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
                MaterialPageRoute(builder: (context) => HistoryPage()),
              ); // Pindah ke halaman History
              break;
          }
        },
        selectedItemColor: const Color(
            0xFF92E3A9), // Mengubah warna item yang dipilih menjadi hijau
        unselectedItemColor: Colors
            .grey, // Mengubah warna item yang tidak dipilih menjadi abu-abu
      ),
    ));
  }
}
