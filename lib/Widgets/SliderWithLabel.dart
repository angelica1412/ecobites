import 'package:flutter/material.dart';

class SliderWithLabel extends StatefulWidget {
  const SliderWithLabel({Key? key}) : super(key: key);

  @override
  State<SliderWithLabel> createState() => _SliderWithLabelState();
}

class _SliderWithLabelState extends State<SliderWithLabel> {
  double _currentValue = 30;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 14,
            activeTrackColor: const Color(0xFF00BAAB),
            thumbColor: Colors.transparent,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 15), // Atur bentuk overlay
            overlayColor: Color.fromARGB(255, 0, 62, 57), // Atur warna overlay
          ),
          child: Slider(
            min: 0,
            max: 100,
            value: _currentValue,
            onChanged: (value) {
              setState(() {
                _currentValue = value;
              });
            },
          ),
        ),
        Row(
          children: [
            const Spacer(),
            Text('${_currentValue.toInt()} %', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
            const Spacer(),
          ],
        )
      ],
    );
  }
}
