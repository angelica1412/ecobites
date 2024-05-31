import 'package:ecobites/homepage.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  final bool isDelivery;
  const CheckoutPage({super.key, required this.isDelivery});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Future<bool> _onWillPop() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
    );
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isDelivery ? "Delivery" : "Pickup",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFFAFAFA),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
                  (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: widget.isDelivery ? _buildDeliveryContent() : _buildPickupContent(),
    ),
    );
  }

  Widget _buildDeliveryContent() {
    return Stack(
      children: [
        // Map image
        Positioned.fill(
          child: Image.asset(
            'assets/maps.png', // Path to your map image
            fit: BoxFit.cover,
          ),
        ),
        // Driver details and communication options
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(bottom: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30.0, // increased radius for a bigger profile picture
                      backgroundImage: AssetImage(
                          'assets/driver.png'), // Add your driver image asset
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DD6396PR',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        const SizedBox(height: 4.0),
                        const Text('Hasrul Muhammad', style: TextStyle(fontSize: 16.0)),
                        const SizedBox(height: 4.0),
                        Row(
                          children: const [
                            Icon(Icons.star,
                                color: Colors.yellow, size: 16.0),
                            SizedBox(width: 4.0),
                            Text('5.0'),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Text('4 mnt', style: TextStyle(fontSize: 16.0)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPickupContent() {
    return Center(
      child: Text(
        'Your order is ready for pickup!',
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
