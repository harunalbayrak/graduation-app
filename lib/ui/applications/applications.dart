import 'package:flutter/material.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Applications extends StatefulWidget {
  Applications({Key? key}) : super(key: key);

  @override
  _ApplicationsState createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  final titles = ["List 1", "List 2", "List 3"];
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Applications')),
      body: Stack(
        children: [
          const Positioned.fill(
            child: Image(
              image: AssetImage("assets/images/background0.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          ListView.builder(
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: classicBlackGray,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ExpansionTile(
                      onExpansionChanged: (value) {
                        setState(() {
                          _isExpanded = value;
                        });
                      },
                      collapsedIconColor: gray,
                      textColor: gray,
                      collapsedTextColor: gray,
                      iconColor: gray,
                      tilePadding: EdgeInsets.fromLTRB(6, 1, 0, 1),
                      initiallyExpanded: false,
                      children: const [
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Icon(
                            Icons.dangerous,
                            color: gray,
                          ),
                          title: Text("Deneme2", style: textStyle2),
                          subtitle: Text("com.package.name", style: textStyle2),
                        ),
                      ],
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AutoSizeText(titles[index]),
                          AnimatedRotation(
                            turns: _isExpanded ? .5 : 0,
                            duration: Duration(seconds: 0),
                            child: IgnorePointer(
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_drop_down),
                                color: gray,
                              ),
                            ),
                          ),
                        ],
                      ),
                      leading: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
