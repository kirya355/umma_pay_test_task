import 'package:flutter/material.dart';
import 'package:testapplication/blocs/main_bloc.dart';
import 'package:testapplication/constants.dart';

class ViewNewsPage extends StatelessWidget {
  final Record data;
  ViewNewsPage({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: Color(0xFF3C516D),
                ),
                onPressed: () {Navigator.pop(context);},
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Color(0xFF3C516D),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.credit_card, color: Color(0xFF3C516D)),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.school, color: Color(0xFF3C516D)),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.person, color: Color(0xFF3C516D)),
                onPressed: () {},
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: Container(),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/logo_hor.png',
            fit: BoxFit.contain,
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              data.title,
              style: titleStyleDetails,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 110,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      image: DecorationImage(
                          image: data.isSnapshot
                              ? NetworkImage(
                                  data.image,
                                )
                              : AssetImage(data.image),
                          fit: BoxFit.fitWidth))),
            ),
            Text(
              'Автор: ${data.author}',
              style: bottomStyleDetails,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Flexible(
                child: Text(
                  data.description,
                  style: descriptionStyleDetails,
                  textAlign: TextAlign.left,
                ),
              ),
            )
          ],
        ));
  }
}
