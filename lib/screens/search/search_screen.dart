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
        body: Column(
          children: [
            Container(
              // color: Color(0xfffc6e51),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
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
            const Expanded(flex: 1, child: SizedBox()),
            Container(
                width: MediaQuery.of(context).size.width * .7,
                child: Image.asset(
                  'assets/images/shopingcar.png',
                  fit: BoxFit.fill,
                  opacity: const AlwaysStoppedAnimation(.5),
                )),
            const Expanded(flex: 2, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
