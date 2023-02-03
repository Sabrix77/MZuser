import 'package:flutter/material.dart';

class DeliveryPolicySection extends StatelessWidget {
  const DeliveryPolicySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return const SizedBox(
                height: 800,
              );
            });
      },
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: const Icon(Icons.policy),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Delivery Policy',
                style: TextStyle(fontSize: 18),
              ),
              Icon(Icons.arrow_forward_ios_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
