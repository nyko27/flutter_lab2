import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MaterialApp(home: HomePage()));
}

class HomePage extends StatelessWidget {
  final titleText = 'Good night!';
  iconSelector(iconName) => IconButton(
        icon: Icon(iconName),
        iconSize: 18,
        color: Colors.white,
        onPressed: () {},
      );

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 0.8,
            colors: [
              Colors.grey.shade600,
              Colors.grey.shade700,
              Colors.grey.shade800,
              Colors.grey.shade900,
              Colors.black12,
            ],
            center: const Alignment(-1.0, -1.0),
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              titleText,
              style: const TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'ProximaNova',
                  color: Colors.white),
            ),
            actions: [
              iconSelector(Icons.notifications_none_outlined),
              iconSelector(Icons.restore_outlined),
              iconSelector(Icons.settings),
            ],
          ),
          body: const SingleChildScrollView(child: Layout()),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: const Color.fromRGBO(255, 255, 255, 0.1),
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(caption: const TextStyle(color: Colors.white))),
            child: BottomNavigationBar(
              fixedColor: Colors.white,
              unselectedItemColor: Colors.grey.shade400,
              items: const [
                BottomNavigationBarItem(
                  backgroundColor: Colors.blue,
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.yellow,
                  icon: Icon(Icons.search_outlined),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.greenAccent,
                  icon: Icon(Icons.library_music_outlined),
                  label: 'Library',
                ),
              ],
            ),
          ),
        ));
  }
}

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        RecentlyListened(),
        Recomedations(),
      ],
    );
  }
}

class RecentlyListened extends StatelessWidget {
  const RecentlyListened({Key? key}) : super(key: key);

  Expanded resentlyListenedItem(
      String name, String imagePath, double imageScaler) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.2),
                border: Border.all(
                  color: const Color.fromRGBO(0, 0, 0, 0),
                  width: 0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(5)),
                  child: Image.asset(
                    imagePath,
                    height: imageScaler * 0.06,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(name,
                      style: const TextStyle(
                          fontSize: 17.5,
                          fontFamily: 'ProximaNova',
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double imageScaler =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          resentlyListenedItem('general', 'assets/gnrl.jpg', imageScaler),
          resentlyListenedItem('rock', 'assets/rock.jpg', imageScaler)
        ]),
        Row(children: <Widget>[
          resentlyListenedItem('random', 'assets/rand.jpg', imageScaler),
          resentlyListenedItem('ukrainian', 'assets/ukr.jpg', imageScaler)
        ]),
        Row(children: <Widget>[
          resentlyListenedItem('pop', 'assets/pop.jpg', imageScaler),
          resentlyListenedItem('old but gold', 'assets/old.jpg', imageScaler)
        ]),
      ],
    );
  }
}

styledTextSelector(
    String textContent,
    double fontSizeValue,
    FontWeight fontWeightValue,
    Color fontColor,
    double paddingLeft,
    double paddingTop,
    double paddingRight,
    double paddingBottom) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: EdgeInsets.fromLTRB(
          paddingLeft, paddingTop, paddingRight, paddingBottom),
      child: Text(
        textContent,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: fontSizeValue,
            fontWeight: fontWeightValue,
            fontFamily: 'ProximaNova',
            color: fontColor),
      ),
    ),
  );
}

recomendationsItem({
  required String imagePath,
  required String title,
  required String subtitle,
}) {
  return InkWell(
    onTap: () {},
    child: Container(
      width: 150,
      decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0)),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Column(
          children: <Widget>[
            Image.asset(imagePath),
            styledTextSelector(
                title, 18, FontWeight.w600, Colors.white, 0, 13, 0, 0),
            styledTextSelector(subtitle, 17, FontWeight.w400,
                Colors.grey.shade400, 0, 3, 0, 0),
          ],
        ),
      ),
    ),
  );
}

recommendationsList(List<List> data) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    height: 250,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        ...data.map((params) => recomendationsItem(
              imagePath: params[0],
              title: params[1],
              subtitle: params[2],
            ))
      ],
    ),
  );
}

class Recomedations extends StatelessWidget {
  const Recomedations({Key? key}) : super(key: key);

  static const List<List<String>> dataToday = [
    ['assets/am.png', 'AM', 'album  \nArctic Monkeys'],
    ['assets/coldplay.jpg', 'Yellow', 'single \nColdplay'],
    ['assets/oe.jpg', 'Суперсиметрія ', 'album  \nОкеан Ельзи'],
    ['assets/bedroom.jpg', 'Im My Head', 'single \nBedroom'],
    ['assets/white.jpg', 'Lorem Ipsum', 'Lorem Ipsum'],
    ['assets/white.jpg', 'Lorem Ipsum', 'Lorem Ipsum'],
    ['assets/white.jpg', 'Lorem Ipsum', 'Lorem Ipsum'],
  ];

  static const List<List<String>> dataSingles = [
    ['assets/billie.png', 'Therefore I Am', 'Billie Eilish,'],
    ['assets/weekend.jpg', 'Save Your Tears', 'The Weeknd'],
    ['assets/memories.jpg', 'Memories', 'Maroon 5'],
    ['assets/shivers.jpg', 'Shivers', 'Ed Sheeran'],
    ['assets/white.jpg', 'Lorem Ipsum', 'Lorem Ipsum'],
    ['assets/white.jpg', 'Lorem Ipsum', 'Lorem Ipsum'],
    ['assets/white.jpg', 'Lorem Ipsum', 'Lorem Ipsum'],
  ];
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      styledTextSelector('Recommendations for today', 26, FontWeight.w700,
          Colors.white, 15, 35, 0, 0),
      recommendationsList(dataToday),
      styledTextSelector(
          'Popular singles', 26, FontWeight.w700, Colors.white, 15, 25, 0, 0),
      recommendationsList(dataSingles),
    ]);
  }
}
