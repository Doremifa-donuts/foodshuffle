import 'package:flutter/material.dart';
import 'package:foodshuffle/model/color.dart';
import 'package:foodshuffle/widgets/footer.dart';

class PageTemplate extends StatelessWidget {
  final Widget child;
  final String pageTitle;
  const PageTemplate({
    required this.pageTitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pageTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(mainColor),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/backimg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: child),
              SizedBox(
                height: 155,
              )
            ],
          ),
          const Positioned(
            bottom: -20,
            left: 0,
            right: 0,
            child: Footer(),
          ),
        ],
      ),
    );
  }
}
