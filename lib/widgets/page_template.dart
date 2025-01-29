import 'package:flutter/material.dart';
import 'package:foodshuffle/model/color.dart';
import 'package:foodshuffle/widgets/footer.dart';

class PageTemplate extends StatefulWidget {
  final String pageTitle;
  final Widget child;
  final Function? onInit;
  const PageTemplate(
      {super.key, required this.pageTitle, required this.child, this.onInit});

  @override
  _PageTemplateState createState() => _PageTemplateState();
}

class _PageTemplateState extends State<PageTemplate> {
  @override
  void initState() {
    super.initState();
    if (widget.onInit != null) {
      widget.onInit!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pageTitle,
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
              Expanded(child: widget.child),
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
