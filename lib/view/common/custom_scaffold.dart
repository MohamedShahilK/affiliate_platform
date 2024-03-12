import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({required this.body, super.key});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidebarX(
            controller: SidebarXController(selectedIndex: 0),
            items: const [
              SidebarXItem(icon: Icons.home, label: 'Home'),
              SidebarXItem(icon: Icons.search, label: 'Search'),
            ],
          ),
          // Your app screen body

          body,
        ],
      ),
    );
  }
}
