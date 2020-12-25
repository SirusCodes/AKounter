import 'package:flutter/material.dart';

class NavigationWidget extends StatefulWidget {
  NavigationWidget({Key key, this.screenList, this.itemList}) : super(key: key);
  final List<Widget> screenList;
  final List<BottomNavigationBarItem> itemList;
  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.screenList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: widget.itemList,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
