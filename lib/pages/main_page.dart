import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapplication/blocs/main_bloc.dart';
import 'package:testapplication/constants.dart';
import 'package:testapplication/data.dart';
import 'package:testapplication/pages/view_news_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/logo_hor.png',
            fit: BoxFit.contain,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
          List<Widget> list = List();
          if (state.listItems != null)
            for (var i in state.listItems)
              list.add(_card(snapshot: i, context: context, isSnapshot: true));

          return ListView(
            children: [
                  SizedBox(
                    height: 20,
                  ),
                  _card(map: newsData[0], context: context),
                  _card(map: newsData[1], context: context),
                  _card(map: newsData[2], context: context),
                  _card(map: newsData[3], context: context),
                ] +
                list,
          );
        }),
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
                onPressed: () {},
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
        ));
  }

  Widget _card(
      {DocumentSnapshot snapshot,
      Map<String, dynamic> map,
      BuildContext context,
      bool isSnapshot = false}) {
    Record record;
    isSnapshot
        ? record = Record.fromSnapshot(snapshot)
        : record = Record.fromMap(map, false);

    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width * 0.9,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              fullscreenDialog: true,
              //transitionDuration: Duration(milliseconds: 1000),
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return ViewNewsPage(
                  data: record,
                );
              },
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) {
                return FadeTransition(
                  opacity:
                      animation, // CurvedAnimation(parent: animation, curve: Curves.elasticInOut),
                  child: child,
                );
              },
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        image: DecorationImage(
                            image: isSnapshot
                                ? NetworkImage(
                                    record.image,
                                  )
                                : AssetImage(record.image),
                            fit: BoxFit.fitHeight))),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  //хочу переносить этот текст
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9 - 140,
                    child: Text(
                      record.title,
                      textAlign: TextAlign.left,
                      style: titleStyleCard,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9 - 140,
                    child: Text(
                      record.description,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: descriptionStyleCard,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          record.author,
                          style: bottomStyleCard,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          record.date,
                          style: bottomStyleCard,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
