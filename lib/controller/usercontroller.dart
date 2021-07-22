	import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

class UserController extends GetxController {
  var userName = "".obs;
  var listViewData = [].obs;
var listViewData2 = [];
  Widget displyimag = Container();
final String assetName2 = 'assets/gif/No data-amico.png';
    displwidget(BuildContext context){ return  SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 250.0,
            height: 50,
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 35,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 7.0,
                    color: Colors.white,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                stopPauseOnTap: true,
                animatedTexts: [
                  FlickerAnimatedText(
                    "Mhhh...",
                    textStyle: GoogleFonts.montserrat(
                      textStyle: Theme.of(context).textTheme.headline5,
                      fontSize: 48,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                 
                ],
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * .6,
              child: Image.asset(assetName2)),
          Text(
            "Looks quiet in here. \nAdd New Todo and it will be listed.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Zenloop",
              fontSize: 20,
              color: Colors.white,
              fontStyle: FontStyle.normal,
            ),
          ),
        ],
      ),
    );}


}