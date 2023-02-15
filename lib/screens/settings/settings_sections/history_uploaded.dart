import 'package:flutter/material.dart';

class HistoryUploaded extends StatelessWidget {
  const HistoryUploaded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .pushNamed(UploadedScreen.routeName);
      },
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: const Icon(Icons.outbond),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Uploaded Products',
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

class UploadedScreen extends StatelessWidget {
  static const String routeName = 'uploadedScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GoBid'),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
          // color: Colors.redAccent,

          ),
    );
  }
}
