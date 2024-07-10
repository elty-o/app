import 'package:flutter/material.dart';

class AppBarDesign {
  AppBar mainAppBar() {
    return AppBar(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            height: 40,
            image: AssetImage('assets/appbar/appbar.png'),
          ),
          SizedBox(
            width: 10,
          ),
          Image(
            height: 30,
            image: AssetImage('assets/appbar/ndp.png'),
          ),
          SizedBox(
            width: 30,
          ),
          Image(
            height: 30,
            image: AssetImage('assets/appbar/saflag.png'),
          ),
        ],
      ),
    );
  }

  AppBar secondaryAppBar() {
    return AppBar(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            height: 40,
            image: AssetImage('assets/appbar/appbar.png'),
          ),
          SizedBox(
            width: 15,
          ),
          Image(
            height: 30,
            image: AssetImage('assets/appbar/ndp.png'),
          ),
          SizedBox(
            width: 20,
          ),
          Image(
            height: 30,
            image: AssetImage('assets/appbar/saflag.png'),
          ),
        ],
      ),
    );
  }

  AppBar noDrawerAppBar() {
    return AppBar(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            height: 30,
            image: AssetImage('assets/appbar/appbar.png'),
          ),
          SizedBox(
            width: 10,
          ),
          Image(
            height: 30,
            image: AssetImage('assets/appbar/ndp.png'),
          ),
          SizedBox(
            width: 10,
          ),
          Image(
            height: 30,
            image: AssetImage('assets/appbar/saflag.png'),
          ),
        ],
      ),
    );
  }
}
