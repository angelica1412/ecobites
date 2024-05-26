import 'package:ecobites/Widgets/voucher.dart';
import 'package:flutter/material.dart';
import 'package:ecobites/Store.dart';
import 'package:ecobites/Widgets/storeCard.dart';
import 'package:ecobites/historypage.dart';
import 'package:ecobites/profile.dart';
import 'package:ecobites/voucherPage.dart';

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

  List<Store> stores = [
    Store(
      name: 'Store 1',
      description: 'Description for Store 1',
      imageURL: 'assets/product1.png',
    ),
    Store(
      name: 'Store 2',
      description: 'Description for Store 2',
      imageURL: 'assets/product1.png',
    ),
    Store(
      name: 'Store 3',
      description: 'Description for Store 3',
      imageURL: 'assets/product1.png',
    ),
    Store(
      name: 'Store 4',
      description: 'Description for Store 4',
      imageURL: 'assets/product1.png',
    ),
    // Add more stores as needed
  ];

  void _handleVoucherUsed(Voucher voucher) {
    setState(() {
      isVoucherUsed = false;
      usedVoucherCode = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final double halfScreenHeight = MediaQuery.of(context).size.height / 2;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 80,
                    width: 80,
                  ),
                  Container(
                    padding: EdgeInsets.all(
                        2), // Menambahkan padding untuk memusatkan ikon
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                          255, 178, 178, 178), // Warna latar belakang
                      shape: BoxShape.circle, // Latar belakang bulat
                    ),
                    child: IconButton(
                      icon: Icon(Icons.person, size: 32),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                onTap: () {
                  setState(() {
                    searchIconColor =
                    const Color(0xFF92E3A9); // Change color when tapped
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search for food...',
                  prefixIcon: Icon(Icons.search, color: searchIconColor),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Color(0xFF92E3A9), width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (searchQuery.isEmpty) ...[
                // Display StoreCards with image on top and smaller size when search query is empty
                Text(
                    'Recently Viewed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
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
                        child: StoreCard(store: store, imageOnTop: true),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: VoucherState(fromCheckout: false, onVoucherUsed: (Voucher) {  },),

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
                        child: StoreCard(store: store, imageOnTop: true),
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
                    final store = stores[index];
                    if (store.name.toLowerCase().contains(searchQuery.toLowerCase())) {
                      return StoreCard(store: store);
                    } else {
                      return SizedBox.shrink(); // Return an empty widget if store does not match search query
                    }
                  },
                ),
              ],
              const SizedBox(height: 20),
            ],
          ),
        ),
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
                MaterialPageRoute(builder: (context) => UploadBarang()),
              ); // Pindah ke halaman Upload
              break;
            case 2:
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
    );
  }
}
