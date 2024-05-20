import 'package:flutter/material.dart';

class Voucher {
  String code;
  String imageName;

  Voucher({required this.code, required this.imageName});
}

class VoucherPage extends StatefulWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  _VoucherPageState createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Voucher> _voucherCodes = [
    Voucher(code: 'VOUCHER123', imageName: 'voucher.png'),
    Voucher(code: 'ECO456', imageName: 'voucher.png'),
    Voucher(code: 'SAVE50', imageName: 'voucher.png'),
    Voucher(code: 'SPRINGSALE', imageName: 'voucher.png'),
    Voucher(code: 'FREEDELIVERY', imageName: 'voucher.png'),
  ];
  final List<Voucher> _filteredVoucherCodes = [];

  @override
  void initState() {
    super.initState();
    _filteredVoucherCodes.addAll(_voucherCodes);
  }

  void _filterVouchers(String query) {
    _filteredVoucherCodes.clear();
    for (var voucher in _voucherCodes) {
      if (voucher.code.toLowerCase().contains(query.toLowerCase())) {
        _filteredVoucherCodes.add(voucher);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voucher Page'),
        backgroundColor: const Color(0xFF92E3A9), // Change app bar color to green
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search for voucher code...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                _filterVouchers(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredVoucherCodes.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/${_filteredVoucherCodes[index].imageName}',
                          height: 80,
                          width: double.infinity, // Make the image full width
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_filteredVoucherCodes[index].code),
                                const Text('Discount or Offer Description'),

                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Add functionality when the "Pakai" button is tapped
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF92E3A9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text('Pakai'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      // Add functionality when a voucher is tapped
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
