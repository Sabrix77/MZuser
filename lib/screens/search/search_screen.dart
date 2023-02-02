import 'package:flutter/material.dart';
import 'package:mzady/shared/combonent/custom_text_field.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // color: Color(0xfffc6e51),
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Center(
                child: CustomTextField(
                  controller: _searchController,
                  borderColor: Colors.black,
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      )),
                  hint: 'Search about specific item',
                  label: 'Search',
                  validator: (value) {
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: 60),
            Container(
                width: MediaQuery.of(context).size.width * .7,
                height: MediaQuery.of(context).size.width * .7,
                child: Image.asset('assets/images/shopcar.png')),
          ],
        ),
      ),
    ));
  }
}
//
// Container(
// height: double.infinity,
// color: const Color(0xFFE5E5E5),
// padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
// child: SingleChildScrollView(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// const SizedBox(height: 20),
// Form(
// child: Container(
// color: Color(0xff9dd2d8),
// padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
// child: CustomTextField(
// controller: _searchController,
// borderColor: Colors.black,
// suffixIcon: IconButton(
// onPressed: () {}, icon: const Icon(Icons.search)),
// hint: 'Search about specific item',
// label: 'Search',
// validator: (value) {
// return null;
// },
// ),
// ),
// ),
//
// Center(child: Image.asset('assets/images/shopcar.png')),
//
// ],
// ),
// ),
// ),
