import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_store/presentation/ui/mannual_product_add.dart';
import 'package:grocery_store/presentation/ui/navigations/addtocart/add_to_cart.dart';
import 'package:grocery_store/presentation/ui/navigations/grocery_items/grocery_items.dart';
import 'package:grocery_store/presentation/ui/navigations/myDrawer/profile.dart';
import 'package:grocery_store/presentation/ui/navigations/recentsorders/purchase_history.dart';
import 'package:grocery_store/repositary/share_preferences/user_credentials_share_preferences.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int currentPageIndex = 0;
  List<String> titleOfNavigationScreens = [
    "Home",
    "Cart",
    "Orders"
  ];

  String? name;
  String? email;
  String? image_url;
  @override
  initState() {
    super.initState();
    check();
  }

  void check() async {
    LocalRepo repo = LocalRepo();
    final details = await repo.getUserCredentials();
    name = details.name;
    email = details.email;
    image_url = details.profileUrl;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 0.5,
        foregroundColor: Colors.black,
        title: Text(
          titleOfNavigationScreens[currentPageIndex],
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          // IconButton(onPressed: (){
          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ManualProductAdd()));
          // }, icon: Icon(Icons.add)),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
                onTap: () async {
                  LocalRepo repo = LocalRepo();
                  final details = await repo.getUserCredentials();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Profile(
                                userName: details.name.toString(),
                                email: details.email.toString(),
                                profile_url: details.profileUrl.toString(),
                              )));
                },
                child: ClipOval(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Icon(Icons.person))),
          ),
        ],
      ),
      body: SafeArea(
        child: <Widget>[
          ProductsItems(),
          //! Add to cart
          AddToCartPage(),
          //!Youtube
          PurchaseHistory(),
        ][currentPageIndex],
      ),
      bottomNavigationBar: myNavigationBarr(),
    );
  }

  NavigationBar myNavigationBarr() {
    return NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: Colors.deepPurple.shade200,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          const NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
            ),
            icon: Icon(Icons.home_outlined),
            label: 'Grocery Items',
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.shopping_cart_outlined),
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.shopping_bag_outlined),
            icon: Icon(Icons.shopping_bag),
            label: 'Orders',
          ),
        ]);
  }
}

