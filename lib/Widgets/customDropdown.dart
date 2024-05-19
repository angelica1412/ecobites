import 'package:flutter/material.dart';

class CustomDropdownWidget extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final Icon? customIcons;
  final TextEditingController controller;

  const CustomDropdownWidget({
    super.key,
    required this.items,
    required this.hintText,
    this.customIcons,
    required this.controller,
  });

  @override
  State<CustomDropdownWidget> createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  // Selected item
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
      _selectedItem = widget.controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.black, width: 1), // Border color and width
      //   borderRadius: BorderRadius.circular(10), // Rounded corners
      // ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Custom icon
          if (widget.customIcons != null) widget.customIcons!,
          if (widget.customIcons != null) const SizedBox(width: 8),
          const SizedBox(width: 8), // Space between icon and dropdown
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text(widget.hintText),
              value: _selectedItem,
              items: widget.items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedItem = newValue;
                  widget.controller.text = newValue ?? '';
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
