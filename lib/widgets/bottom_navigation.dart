import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: currentIndex == 0
                ? const Icon(Icons.home)
                : const Icon(Icons.home_outlined),
            label: "Home"),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.search),
        //   label: "Search",
        // ),
        // BottomNavigationBarItem(
        //   icon: currentIndex == 2
        //       ? Icon(Icons.location_on)
        //       : const Icon(Icons.location_on_outlined),
        //   label: "Taxi Map",
        // ),
        BottomNavigationBarItem(
          icon: currentIndex == 1
              ? const Icon(Icons.bookmark)
              : const Icon(Icons.bookmark_outline),
          label: "Saved Taxis",
        )
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
