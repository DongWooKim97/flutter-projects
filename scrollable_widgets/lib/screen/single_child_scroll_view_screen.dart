import 'package:flutter/material.dart';
import 'package:scrollable_widgets/constant/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  const SingleChildScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'SingChildScrollView',
      body: SingleChildScrollView(
        child: Column(
          children:
              rainbowColors.map((e) => renderContainer(color: e)).toList(),
        ),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
  }) {
    return Container(
      height: 300,
      color: color,
    );
  }
}
