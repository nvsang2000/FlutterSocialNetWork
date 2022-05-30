import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test/item/tittle/tittle.dart';

class AllImagePage extends StatelessWidget {
  const AllImagePage({Key? key, required this.list}) : super(key: key);
  final List<String> list;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                title:
                    Tittle(text: "All Photos", size: 24, color: Colors.black),
              ),
            ),
            Expanded(
                flex: 9,
                child: Container(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: list.length,
                    itemBuilder: ((context, index) => Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: list[index],
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                              ),
                            ),
                          ],
                        )),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
