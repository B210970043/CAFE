import 'package:find_and_contact/screens/auth/auth_service.dart';
import 'package:find_and_contact/screens/home/add_zar.dart';
import 'package:find_and_contact/screens/home/favorite.dart';
import 'package:find_and_contact/screens/home/notification.dart';
import 'package:find_and_contact/screens/home/search.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    int _selectedIndex = 0;

    final List<Widget> _pages = [
      SearchPage(),
      FavoritesPage(),
      AddZar(),
      NotificationPage(),
    ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:_pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey,
          currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Хайлт'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Таалагдсан'),
          BottomNavigationBarItem(icon: Icon(Icons.add_a_photo_sharp), label: 'Машин нэмэх'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active), label: 'Мэдэгдэл'),
        ],
        selectedItemColor: Colors.white,
        ),
      );    
  }
}