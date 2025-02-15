import 'package:flutter/material.dart';
import 'package:foodshuffle/model/color.dart';
import 'package:foodshuffle/widgets/footer.dart';

class PageTemplate extends StatefulWidget {
  final String pageTitle;
  final Widget child;
  final Function? onInit;
  final Function? onDispose;
  final bool isExpanded;
  final bool displayFooter;
  final List<Widget>? actions;
  const PageTemplate(
      {super.key,
      required this.pageTitle,
      required this.child,
      this.onInit,
      this.onDispose,
      this.isExpanded = false,
      this.displayFooter = true,
      this.actions});

  @override
  createState() => _PageTemplateState();
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
  void dispose() {
    if (widget.onInit != null) {
      widget.onDispose!();
    }
    super.dispose();
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
        actions: widget.actions,
      ),
      resizeToAvoidBottomInset: false,
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
              // footerがあり、且つ拡張がオンならば余白を作る
              if (!widget.isExpanded && widget.displayFooter)
                const SizedBox(
                  height: 155,
                )
            ],
          ),
          widget.displayFooter
              ? const Positioned(
                  bottom: -20,
                  left: 0,
                  right: 0,
                  child: Footer(),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
