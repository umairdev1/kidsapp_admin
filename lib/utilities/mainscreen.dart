import 'package:flutter/material.dart';
import 'package:kidsapp_admin/utilities/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: kprimaryClr),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: kprimaryClr,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                      _selectedIndex == 0 ? Icons.home : Icons.home_outlined),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(_selectedIndex == 1
                      ? Icons.favorite
                      : Icons.favorite_outline),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(_selectedIndex == 2
                      ? Icons.search
                      : Icons.search_outlined),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(_selectedIndex == 3
                      ? Icons.shopping_bag
                      : Icons.shopping_bag_outlined),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(_selectedIndex == 4
                      ? Icons.person
                      : Icons.person_outline),
                  label: '',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: kwhiteClr,
              unselectedItemColor: ksecondaryClr,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
