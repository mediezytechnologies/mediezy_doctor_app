import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediezy_doctor/Ui/Screens/demo.dart/page1.dart';
import 'package:mediezy_doctor/Ui/Screens/demo.dart/page2.dart';

import 'demo/demo_bloc.dart';

class MyHomePages extends StatefulWidget {
  @override
  _MyHomePagesState createState() => _MyHomePagesState();
}

class _MyHomePagesState extends State<MyHomePages> {
  int _selectedIndex = 0;
  int _dropdownValue = 1;

  List<Widget> screens = [
    Page2(),
    Page1(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    log('data');
    return BlocConsumer<LandingPageBloc, LandingPageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Bottom Navigation Bar Example'),
          ),
          body:screens.elementAt(state.tabIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: state.tabIndex,
            selectedItemColor: Colors.blue,
            onTap: (value) {
              BlocProvider.of<LandingPageBloc>(context)
                  .add(TabChange(tabIndex: value));
            },
          ),
        );
      },
    );
  }
}