import 'package:flutter/material.dart';
import 'package:leviosa/widgets/common/adv_network_image.dart';

class DefaultDp extends StatelessWidget {
  final String name;
  final double size;
  final String? dpUrl;
  const DefaultDp({
    super.key,
    required this.name,
    required this.size,
    this.dpUrl,
  });
  static final List<Color> colors = [
    Colors.red.shade200,
    Colors.green.shade200,
    Colors.yellow.shade200,
    Colors.purple.shade200,
    Colors.blue.shade200,
    Colors.deepOrange.shade200
  ];

  static Color genColor(String char) {
    int index = 0;
    if (char.isEmpty) {
      final int randInt = (DateTime.now().millisecond) % colors.length;
      return colors[randInt];
    }
    for (var i in char.codeUnits) {
      index += i;
    }
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return dpUrl == null
        ? Container(
            alignment: Alignment.center,
            width: size,
            height: size,
            decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              shape: BoxShape.circle,
              color: genColor(name),
            ),
            child: Text(
              name.isEmpty ? '' : name[0].toUpperCase(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(size),
            child: AdvancedNetworkImage(
                imgUrl: dpUrl!, width: size, height: size));
  }
}
