import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  final Color color;

  const HomeScreen({
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      color: widget.color,
    );
  }
}


// class HomeScreen extends StatelessWidget {
//   final Color color;
//
//   const HomeScreen({
//     required this.color,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 50.0,
//       height: 50.0,
//       color: color,
//     );
//   }
// }

/*
class HomeScreen extends StatefulWidget {
  final Color color;

  const HomeScreen({
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      color: widget.color,
    );
  }
}
 */
