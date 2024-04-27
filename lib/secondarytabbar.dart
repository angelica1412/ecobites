import 'package:flutter/material.dart';



class SecondaryTabbar extends StatefulWidget {
  const SecondaryTabbar({Key? key}) : super(key: key);

  @override
  _SecondaryTabbarState createState() => _SecondaryTabbarState();
}

class _SecondaryTabbarState extends State<SecondaryTabbar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      color: const Color(0xFF292929),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
              child: Container(
                color: _selectedIndex == 0 ? const Color(0xFF00BAAB) : Colors.transparent,
                child: Center(
                  child: Text(
                    'Home',
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
                });
              },
              child: Container(
                color: _selectedIndex == 1 ? const Color(0xFF00BAAB) : Colors.transparent,
                child: Center(
                  child: Text(
                    'Contact',
                    style: TextStyle(
                      color: _selectedIndex == 1 ? Colors.white : Colors.grey,
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
                  _selectedIndex = 2;
                });
              },
              child: Container(
                color: _selectedIndex == 2 ? const Color(0xFF00BAAB) : Colors.transparent,
                child: Center(
                  child: Text(
                    'About',
                    style: TextStyle(
                      color: _selectedIndex == 2 ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}