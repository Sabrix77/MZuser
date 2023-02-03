import 'package:flutter/material.dart';

class HeaderInfoSection extends StatelessWidget {
  const HeaderInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: Colors.lightBlueAccent,
            shape: BoxShape.circle,
            image:
                DecorationImage(image: AssetImage('assets/images/shopcar.png')),
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  'Hello, ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Omar Muhammad',
                  style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Banimzar-Minya',
              style: TextStyle(color: Colors.black45),
            ),
          ],
        )
      ],
    );
  }
}
