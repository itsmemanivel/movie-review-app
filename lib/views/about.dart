import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/utils/commons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      backgroundColor: Commons.bgColor,
      appBar: AppBar(
        backgroundColor: Commons.bgColor,
        title: Row(
          children: [
            Icon(
              CupertinoIcons.person,
              color: Colors.white,
              size: 35,
            ),
            Text(
              ' About',
              style: TextStyle(fontSize: 35),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              child: Text(
                'Description',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              child: Text(
                'RMDB - Riyas Movie DataBase, is an open source project. It is an flutter app, where you can able to get the details about Movies and Tv Shows. You can get project code thru github (riyasm449/movie-review-app). for more details or to collaborate in any projects, don\'t hesitate to contact me with below contact details.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              child: Text(
                'About Admin',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              child: Text(
                'Hi, I\'m MohamedRiyas, Flutter developer, student from Karur, India. I\'m currently pursuing my bachelore\'s degree in the field of Computer Science and Engineering. I create apps and websites using flutter. Ask me about flutter!. Support me guys with buying me a coffee with below link.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              child: Text(
                'Support Me',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                launchUrl('https://www.buymeacoffee.com/riyasm449');
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: Image.network(
                  'https://i.ytimg.com/vi/8LfPbnSPiVY/maxresdefault.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              child: Text(
                'Contact',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: ListTile(
                onTap: () async {
                  launchUrl('https://www.instagram.com/mohamedriyas.aa/');
                },
                leading: Image.network(
                  'https://img.icons8.com/dotty/80/000000/instagram-new.png',
                  width: 32,
                  height: 32,
                  color: Colors.white,
                ),
                title: Text(
                  '@mohamedriyas.aa',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: ListTile(
                onTap: () async {
                  launchUrl('https://github.com/riyasm449');
                },
                leading: Image.network(
                  'https://img.icons8.com/wired/64/000000/github.png',
                  width: 30,
                  height: 30,
                  color: Colors.white,
                ),
                title: Text(
                  'riyasm449',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: ListTile(
                onTap: () {
                  Clipboard.setData(new ClipboardData(text: 'riyasm449@gmail.com'));
                  scaffoldkey.currentState
                      .showSnackBar(SnackBar(content: Text('Copied mail address "riyasm449@gmail.com"')));
                },
                leading: Image.network(
                  'https://img.icons8.com/dotty/80/000000/google-logo.png',
                  width: 30,
                  height: 30,
                  color: Colors.white,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'riyasm449@gmail.com',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Icon(
                      Icons.copy,
                      color: Colors.white54,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void launchUrl(String url) async {
    await launch(
      url,
      forceSafariVC: false,
      universalLinksOnly: true,
    );
  }
}
