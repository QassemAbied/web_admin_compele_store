import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_admin_compele_store/screens/view_all_order_screen.dart';

import 'all_product_view_screen.dart';
import 'main_screen.dart';

class SamplePage extends StatefulWidget {
  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  Widget _selectedScreen = MainScreen();

  ScreenSlector(item){
    switch(item.route){
      case MainScreen.routeName:
        setState(() {
          _selectedScreen = MainScreen();
        });
        break;
      case AllProductViewScreen.routeName:
        setState(() {
          _selectedScreen = AllProductViewScreen();
        });
        break;
      case ViewAllOrderScreen.routeName:
        setState(() {
          _selectedScreen = ViewAllOrderScreen();
        });
        break;

    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Management'),
      ),
      sideBar: SideBar(
        items:  [

          AdminMenuItem(
            title: 'Home',
            route: MainScreen.routeName,
            icon: Icons.home_filled,
          ),
          AdminMenuItem(
            title: 'ViewAllProduct',
            route: AllProductViewScreen.routeName,
            icon: Icons.grid_view,

          ),
          AdminMenuItem(
            title: 'ViewAllOrder',
            route: ViewAllOrderScreen.routeName,
            icon: Icons.shopping_bag,

          ),

        ],
        textStyle: TextStyle(
          color: Colors.black,
        ),
        backgroundColor: Colors.deepPurple.shade100,
        selectedRoute: '',
        onSelected: (item) {
          ScreenSlector(item)  ;
        },
        header: Container(
          height: 100,
          width: double.infinity,
          color:  Colors.deepPurple.shade50,
          child:  Center(
            child:Image(image: AssetImage('assets/images/16.png')),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: Colors.deepPurple.shade50,
          child:  Center(
            child: Text(
              '${DateTimeFormat.format(DateTime.now(), format: AmericanDateFormats.dayOfWeek)}',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body:_selectedScreen ,
    );
  }
}