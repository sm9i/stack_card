import 'package:flutter/material.dart';
import 'dart:math';

class StackCardPage extends StatefulWidget {
  @override
  _StackCardPageState createState() => _StackCardPageState();
}

class _StackCardPageState extends State<StackCardPage> {
  List<Color> data = [];
  final ScrollController scrollController = ScrollController();

  double topItem = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      double value = scrollController.offset / 119;
      setState(() {
        topItem = value;
      });
    });
    initData();
  }

  initData() {
    for (int i = 0; i <= 50; i++) {
      data.add(getColor());
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('stack card'),
      ),
      body: ListView.builder(
        controller: scrollController,
        padding: EdgeInsets.symmetric(vertical: 30),
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          double scale = 1.0;

          if (topItem > 0.7) {
            scale = index + 1 - topItem;
            if (scale < 0) {
              scale = 0;
            } else if (scale > 1) {
              scale = 1;
            }
          }
          if (index == 3) {
            print(scale);
          }
          return Opacity(
            opacity: scale,
            child: Transform(
              transform: Matrix4.identity()..scale(scale, scale),
              alignment: Alignment.bottomCenter,
              child: Align(
                heightFactor: 0.7,
                alignment: Alignment.topCenter,
                child: ItemWidget(color: data[index]),
              ),
            ),
          );
        },
        itemCount: data.length,
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({Key key, this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            blurRadius: 10,
            spreadRadius: 3,
          )
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    );
  }
}

Color getColor() {
  return Color.fromARGB(
    255,
    Random.secure().nextInt(200),
    Random.secure().nextInt(200),
    Random.secure().nextInt(200),
  );
}
