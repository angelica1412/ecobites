import 'package:flutter/material.dart';

class SecondaryTabbar extends StatefulWidget {
  final ValueChanged<int>? onTabSelected;
  final String title;
  final String title2;

  const SecondaryTabbar({Key? key, this.onTabSelected, required this.title, required this.title2}) : super(key: key);

  @override
  _SecondaryTabbarState createState() => _SecondaryTabbarState();
}

class _SecondaryTabbarState extends State<SecondaryTabbar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 35,
        width: MediaQuery.of(context).size.width * 0.6, // Mengatur lebar menjadi 80% dari lebar layar
        decoration: BoxDecoration(
          color: const Color(0xFF292929),
          borderRadius: BorderRadius.circular(10), // Menambahkan border radius
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                    widget.onTabSelected?.call(_selectedIndex);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _selectedIndex == 0 ? const Color(0xFF92E3A9) : Colors.transparent,
                    borderRadius: BorderRadius.circular(10), // Menambahkan border radius
                  ),
                  child: Center(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: _selectedIndex == 0 ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                    widget.onTabSelected?.call(_selectedIndex);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _selectedIndex == 1 ? const Color(0xFF92E3A9) : Colors.transparent,
                    borderRadius: BorderRadius.circular(10), // Menambahkan border radius
                  ),
                  child: Center(
                    child: Text(
                      widget.title2,
                      style: TextStyle(
                        color: _selectedIndex == 1 ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
