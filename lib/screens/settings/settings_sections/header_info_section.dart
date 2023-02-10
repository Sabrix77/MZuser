import 'package:flutter/material.dart';
import 'package:mzady/model/my_user.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:provider/provider.dart';

class HeaderInfoSection extends StatelessWidget {
  const HeaderInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyUser user = Provider.of<MainProvider>(context).user!;
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
              children: [
                Text(
                  'Hello, ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  user.firstName,
                  style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                ),
                SizedBox(width: 2),
                Text(
                  user.lastName,
                  style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              user.address,
              style: TextStyle(color: Colors.black45),
            ),
          ],
        )
      ],
    );
  }
}
