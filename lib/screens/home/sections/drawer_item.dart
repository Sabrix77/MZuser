import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 240,
              width: double.infinity,
              child: Image.asset(
                'assets/images/logo.jpg',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 8),
            Container(
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(
                    Icons.dashboard,
                  ),
                  title: Text('Manage Products',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.black87)),
                  onTap: () {
                    //for deleting drawer
                    // and remove <- back to screen cause it wasnt refresh data
                    // Navigator.of(context, rootNavigator: true)
                    //     .pushReplacementNamed(ManageProductsScreen.routeName);
                    // Navigator.pushNamed(context, ManageProductsScreen.routeName);
                  },
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person_add_disabled,
                  ),
                  title: Text('Manage Users',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.black87)),
                  onTap: () {
                    //ممكن نحتاج route:false
                    //Navigator.pushNamed(context, ManageProductsScreen.routeName);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
