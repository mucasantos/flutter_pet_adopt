import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/services/constants.dart';
import 'package:flutter_pet_adopt/view/dashboard_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({
    super.key,
  });

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const DashBoardScreen(),
          Container(
            color: Colors.blueGrey,
          ),
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.green,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
            //   backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Adicionar',
            // backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_sharp),
            label: 'Profile',
            //    backgroundColor: Colors.pink,
          ),
        ],
        selectedLabelStyle: const TextStyle(
          decoration: TextDecoration.underline,
          decorationColor: mainColor,
        ),
        currentIndex: _currentPageIndex,
        selectedItemColor: mainColor,
        unselectedItemColor: const Color.fromARGB(139, 255, 135, 171),
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
