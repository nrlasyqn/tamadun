import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineWidget extends StatelessWidget {
  const TimelineWidget({
    Key? key,
    required this.url,
    required this.color,
    required this.text,
    required this.title,
  }) : super(key: key);

  final List<String> url;
  final List<MaterialAccentColor> color;
  final List<String> text;
  final List<String> title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 120),
            child: Text(
              '',
            ),
          ),
          for (int i = 0; i < 3; i++)
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.2,
              endChild: Padding(
                padding: const EdgeInsets.all(45.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("Tapped a Container");
                      },
                      child: Container(
                        height: 100,
                        width: 320,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              url[i],
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          color: color[i],
                        ),
                        constraints: const BoxConstraints(
                          minHeight: 120,
                        ),
                      ),
                    ),
                    SizedBox(height: 4,),
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4), color: Colors.grey),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(title[i],textAlign: TextAlign.center,),
                      ),
                    ),
                  ],
                ),
              ),
              startChild: Center(
                  child: Text(
                    text[i],
                    textAlign: TextAlign.center,
                  )),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 240),
            child: Text(
              '',
            ),
          ),
        ],
      ),
    );
  }
}