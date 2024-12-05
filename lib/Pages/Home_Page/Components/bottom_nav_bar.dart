import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final Function(int) onItemSelected;

  BottomNavBar({required this.onItemSelected});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, // Altura aumentada
      decoration: BoxDecoration(
        color: Colors.white, // Cor da barra
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(Icons.home, 0),
          _buildNavItem(Icons.search, 1),
          SizedBox(width: 60), // Espaço para o FAB
          _buildNavItem(Icons.note_alt_outlined, 2),
          _buildNavItem(Icons.person, 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Colors.blue : Colors.grey,
        size: 50, // Ajusta o tamanho dos ícones, se necessário
      ),
      onPressed: () => _onItemTapped(index),
    );
  }
}
