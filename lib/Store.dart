import 'package:ecobites/Widgets/scheduleStore.dart';
import 'package:ecobites/authenticate/Controller/productController.dart';
import 'package:ecobites/checkout.dart';
import 'package:flutter/material.dart';
import 'package:ecobites/Widgets/ProductCard.dart';
import 'package:ecobites/Widgets/category_button.dart';
import 'package:ecobites/Widgets/share_widget.dart';
import 'package:intl/intl.dart';
import 'Widgets/MapsContainer.dart';
import 'package:ecobites/authenticate/Controller/storeController.dart';

class StorePage extends StatefulWidget {
  final String storeID;
  const StorePage({super.key, required this.storeID});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  String _selectedCategory = 'Food';
  bool _searching = false; // Untuk melacak apakah sedang dalam mode pencarian
  bool _isFavorite = false; // Untuk melacak apakah toko ini merupakan favorit
  bool _showCheckoutButton =
      false; // Untuk melacak apakah harus menampilkan tombol checkout
  int _totalProducts = 0;
  double _totalPrice = 0.0;
  Map<String, String> _storeData = {};
  List<Product> _productData = [];
  bool _isLoading = true;
  String searchQuery = "";
  bool _productNotFound = false;
  final FocusNode _searchFocusNode = FocusNode();

  void _setSelectedCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  final TextEditingController _searchController = TextEditingController();

  List<Product> get productsWithQuantity {
    return _productData.where((product) => product.quantity > 0).toList();
  }

  Future<void> _fetchStoreData() async {
    setState(() {
      _isLoading = true; // Mulai memuat data
    });
    final storeData = await getStorebyID(widget.storeID);
    final productData = await getProductsByStoreID(widget.storeID);
    if (storeData != null) {
      setState(() {
        _storeData = storeData;
        if (productData != null && productData.isNotEmpty) {
          _productData = productData!
              .map((data) => Product.fromMap(data, data['id']))
              .toList();
          _productNotFound =
              false; // Setel variabel _productNotFound ke false jika productData tidak kosong
        } else {
          _productData =
              []; // Kosongkan _productData jika productData kosong atau null
          _productNotFound =
              true; // Setel variabel _productNotFound ke true jika productData kosong
        }
        _isLoading = false; // Data selesai dimuat
      });
    } else {
      // Handle the case where the store data could not be fetched
      print('Failed to fetch store data');
      setState(() {
        _isLoading = false; // Gagal memuat data
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _fetchStoreData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'id', symbol: 'Rp. ',decimalDigits: 0);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: _buildActions(),
        leading: _searching
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  setState(() {
                    _searching = false;
                  }); // Kembali ke halaman sebelumnya
                },
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                },
              ),
        title: _searching
            ? TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                  _searchFocusNode.requestFocus();
                },
                decoration: const InputDecoration(
                  hintText: 'Cari...',
                  border: InputBorder.none,
                ),
              )
            : const Text(
                '',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0), // Tinggi bayangan
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.2), // Warna dan opacity bayangan
                  spreadRadius: 1, // Radius penyebaran bayangan
                  blurRadius: 5, // Radius blur bayangan
                  offset: Offset(
                      0, 3), // Perubahan posisi bayangan (horizontal, vertical)
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height *
                          0.25, // Tinggi 1/10 dari layar
                      width: double.infinity, // Lebar penuh
                      child: (_storeData['imageURL'] != null && _storeData['imageURL']!.isNotEmpty)
                          ? Image.network(
                              _storeData['imageURL']!,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  width: double.infinity,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                              : null,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return const Icon(Icons.error);
                              },
                            )
                          : Image.asset(
                            'assets/shop.png',

                      ),
                    ),
                    //card toko
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Menyesuaikan tinggi dengan konten
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          height: 1.5,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: _storeData['namaToko'] ??
                                                  'Nama Toko',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Icon(Icons.star,
                                              color: Colors.yellow),
                                        ),
                                        Text('5.0 | Jarak'),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Icon(Icons.location_on),
                                      ),
                                      Text(_storeData['alamat'] ?? ''),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              // Panggil fungsi untuk menampilkan informasi toko
                              _showStoreInformation(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.info_outline),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Card(
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deskripsi Toko:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                  height:
                                      6), // Space between title and description
                              Text(
                                _storeData['deskripsi'] ??
                                    'Deskripsi toko tidak tersedia.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    //Tombol kategori
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CategoryButton(
                          category: 'Food',
                          selectedCategory: _selectedCategory,
                          onPressed: _setSelectedCategory,
                        ),
                        CategoryButton(
                          category: 'Bahan Daur',
                          selectedCategory: _selectedCategory,
                          onPressed: _setSelectedCategory,
                        ),
                        CategoryButton(
                          category: 'Hasil Daur',
                          selectedCategory: _selectedCategory,
                          onPressed: _setSelectedCategory,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (_productNotFound) ...[
                      Center(child: Text('Product not found')),
                    ] else if (searchQuery.isEmpty) ...[
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _productData
                            .where((product) =>
                                product.category == _selectedCategory)
                            .length,
                        itemBuilder: (context, index) {
                          final product = _productData
                              .where((product) =>
                                  product.category == _selectedCategory)
                              .toList()[index];
                          return ProductCard(
                            product: product,
                            onQuantityChanged: () {
                              _handleShowCheckoutButton();
                              for (var product in _productData) {
                                _totalProducts += product.quantity;
                                _totalPrice += product.quantity * product.price;
                              }
                            },
                          );
                        },
                      ),
                    ] else ...[
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _productData
                            .where((product) =>
                                product.category == _selectedCategory &&
                                product.name
                                    .toLowerCase()
                                    .contains(searchQuery.toLowerCase()))
                            .length,
                        itemBuilder: (context, index) {
                          final product = _productData
                              .where((product) =>
                                  product.category == _selectedCategory &&
                                  product.name
                                      .toLowerCase()
                                      .contains(searchQuery.toLowerCase()))
                              .toList()[index];
                          if (product.name
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()))
                            return ProductCard(
                              product: product,
                              onQuantityChanged: () {
                                _handleShowCheckoutButton();
                                for (var product in _productData) {
                                  _totalProducts += product.quantity;
                                  _totalPrice +=
                                      product.quantity * product.price;
                                }
                              },
                            );
                        },
                      ),
                    ],

                    const SizedBox(height: 60),
                  ],
                ),
          Positioned(
            bottom: 0.0, // Atur posisi vertical container
            left: 0.0, // Atur posisi horizontal container
            right: 0.0, // Atur lebar container agar sesuai dengan parent
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _showCheckoutButton ? 60.0 : 0.0,
              color: Colors.transparent,
              child: _showCheckoutButton
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderPage(
                                      productsWithQuantity:
                                          productsWithQuantity,
                                      totalprice: _totalPrice,
                                  storeID: widget.storeID,
                                    )));
                        // Lakukan tindakan saat container diklik
                        // Misalnya, tampilkan dialog, navigasi ke halaman checkout, dll.
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 30.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(
                                12.0), // Membuat sudut agak bulat dengan radius 12.0
                          ),
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Row(
                            children: [
                              // Icon keranjang
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                child: Icon(Icons.shopping_cart,
                                    color: Colors.white),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: VerticalDivider(
                                  color: Colors
                                      .white, // Warna garis pembatas vertikal
                                  thickness: 2, // Ketebalan garis
                                  indent:
                                      16, // Jarak dari tepi kiri ikon keranjang
                                  endIndent:
                                      16, // Jarak dari tepi kanan ikon keranjang
                                ),
                              ),
                              Text(
                                'Produk : $_totalProducts',
                                style: TextStyle(color: Colors.white),
                              ),
                              // Spacer untuk memberi jarak
                              Spacer(),
                              // Total harga
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                                child: Text(
                                  'Total: ${currencyFormatter.format(_totalPrice)}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun actions sesuai dengan mode pencarian
  List<Widget> _buildActions() {
    if (_searching) {
      return [
        IconButton(
          icon: const Icon(Icons.search),
          color: Colors.black,
          onPressed: () {
            // Tindakan pencarian
            print('Melakukan pencarian: ${_searchController.text}');
            // Lakukan pencarian sesuai dengan teks yang dimasukkan dalam _searchController
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: _isFavorite
              ? const Icon(Icons.favorite, color: Colors.red)
              : const Icon(Icons.favorite_border),
          color: Colors.black,
          onPressed: () {
            // Toggle status favorit
            setState(() {
              _isFavorite = !_isFavorite;
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.search),
          color: Colors.black,
          onPressed: () {
            // Aktifkan mode pencarian
            setState(() {
              _searching = true;
            });
            _searchFocusNode.requestFocus();
          },
        ),
        IconButton(
          icon: const Icon(Icons.share),
          color: Colors.black,
          onPressed: () {
            // Tampilkan modal bottom sheet untuk berbagi
            ShareWidget.showShareBottomSheet(context);
          },
        ),
      ];
    }
  }

  // Fungsi untuk menangani penampilan tombol checkout
  void _handleShowCheckoutButton() {
    int totalProducts = 0;
    double totalPrice = 0.0;
    bool hasProductWithQuantity = false;
    for (var product in _productData) {
      if (product.quantity > 0) {
        hasProductWithQuantity = true;
        break;
      }
    }
    setState(() {
      _showCheckoutButton = hasProductWithQuantity;
      _totalProducts = totalProducts;
      _totalPrice = totalPrice;
    });
  }

  void _showStoreInformation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              MapsContainer(
                storeName: _storeData['namaToko'] ?? '',
                storeAddress: _storeData['alamat'] ?? '',
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min, // Menyesuaikan tinggi dengan konten
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.03,
                                  height: 1.5,
                                ),
                                children: [
                                  TextSpan(
                                      text:
                                          _storeData['namaToko'] ?? 'Nama Toko',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.location_on),
                                ),
                                Text(_storeData['alamat'] ?? ''),
                              ],
                            ),
                          ),
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.route,
                                    color: Colors.greenAccent),
                              ),
                              Text('Jarak'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              scheduleStore(day: "Senin", time: "4.00 - 16.00"),
              scheduleStore(day: "Selasa", time: "4.00 - 16.00"),
              scheduleStore(day: "Rabu", time: "4.00 - 16.00"),
              scheduleStore(day: "Kamis", time: "4.00 - 16.00"),
              scheduleStore(day: "Jumat", time: "4.00 - 16.00"),
              scheduleStore(day: "Sabtu", time: "4.00 - 16.00"),
              scheduleStore(day: "Minggu", time: "4.00 - 16.00"),
            ],
          ),
        );
      },
    );
  }
}
