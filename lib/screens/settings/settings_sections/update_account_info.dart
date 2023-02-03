import 'package:flutter/material.dart';

import '../../../shared/combonent/custom_text_field.dart';

class UpdateAccountInfo extends StatefulWidget {
  const UpdateAccountInfo({Key? key}) : super(key: key);

  @override
  State<UpdateAccountInfo> createState() => _UpdateAccountInfoState();
}

class _UpdateAccountInfoState extends State<UpdateAccountInfo> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                child: AlertDialog(
                  title: const Text('Update Account Info'),
                  titleTextStyle: Theme.of(context).textTheme.titleLarge,
                  content: Column(
                    children: [
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _controller,
                        validator: (value) {},
                        label: 'Email',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _controller,
                        validator: (value) {},
                        label: 'Phone',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _controller,
                        validator: (value) {},
                        label: 'Address',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _controller,
                        validator: (value) {},
                        label: 'Old Password',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _controller,
                        validator: (value) {},
                        label: 'New Password',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _controller,
                        validator: (value) {},
                        label: 'Confirm new password',
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancle'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              );
            });
      },
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: const Icon(Icons.person),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Update Profile',
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
