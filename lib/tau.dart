import 'package:flutter/material.dart';

class SliderWithLabel extends StatefulWidget {
  const SliderWithLabel({super.key});

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
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0)),
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
            const Text('Label',style: TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            Text('${_currentValue.toInt()} %',style: const TextStyle(fontWeight: FontWeight.w500))
          ],
        )
      ],
    );
  }
}