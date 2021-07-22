import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/controller/usercontroller.dart';
import 'package:notes_app/provider/todoProvider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final searchController = TextEditingController();
    final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final bioController = Get.put(UserController());

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        color: backgroundColorDark,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
                top: 10, left: screenWidth * .1, right: screenWidth * .1),
            padding: EdgeInsets.only(
                top: 10,
                left: screenWidth * .05,
                right: screenWidth * .05,
                bottom: 10),
            color: backgroundColorDark,
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              minLines: 1,
              maxLines: 20,
              onChanged: (string) {
                if (searchController.text.isNotEmpty) {
                  print(
                      "the items changed list ${bioController.listViewData2.where((e) => e['title'].toLowerCase().contains(searchController.text.toLowerCase()) || e['description'].startsWith(searchController.text)).toList()}");
                  bioController.listViewData.clear();
                  bioController.listViewData.addAll(bioController.listViewData2
                      .where((e) =>
                          e['title']
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()) ||
                          e['description']
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()))
                      .toList());
                } else {
                  bioController.listViewData
                      .addAll(bioController.listViewData2);
                }
              },
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'search',
                border: OutlineInputBorder(),
                suffixIcon: Icon(FontAwesomeIcons.feather),
              ),
              controller: searchController,
            ),
          ),
          Expanded(
            child: Container(
              child: Consumer<TodoProvider>(
                builder: (context, model, _) {
                  
                  print("\nthe items datas of ${bioController.listViewData}");
                  return FutureBuilder(
                      future:
                          model.filterfetchData(bioController.userName.value),
                      builder: (context, snapshot) => snapshot
                                  .connectionState !=
                              ConnectionState.done
                          ? Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  LinearProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.greenAccent),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: SizedBox(
                                          height: screenHeight * .5,
                                          child: Image.asset(
                                              'assets/gif/girl-work-on-laptop.png')),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : model.todoData.length == 0
                              ? Container(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Container(
                                         
                                          child: bioController.displwidget(context)),
                                    ),
                                  ),
                                )
                              : Obx(() {
                                
                                  return ListView.builder(
                                      itemCount:
                                          bioController.listViewData.length,
                                      itemBuilder: (context, int index) {
                                        // if(searchController.text.isNotEmpty)
                                        //   model.todoData[index] = model.todoData[index].where((e) => e['title'].contains(searchController.text) && e['description'].startsWith(searchController.text)).toList();
                                        print(bioController.listViewData[index]
                                            ['title']);
                                        bool cmplt = bioController
                                            .listViewData[index]['completed'];
                                        String credate = bioController
                                            .listViewData[index]['createdAt'];
                                        DateTime date1 =
                                            DateTime.parse(credate);
                                        String formattedDate =
                                            DateFormat('EEE d MMM\nhh : mm a')
                                                .format(date1);
                                        String updated = bioController
                                            .listViewData[index]['updatedAt'];
                                        DateTime date2 =
                                            DateTime.parse(updated);
                                        String formattedDate2 =
                                            DateFormat('EEE d MMM\nhh : mm a')
                                                .format(date2);
                                        print(
                                            "the items are ${bioController.listViewData[index]['title']}");
                                        return Container(
                                          margin: EdgeInsets.only(
                                              right: screenWidth * .1,
                                              bottom: 10,
                                              top: 5,
                                              left: screenWidth * .1),
                                          child: Material(
                                            color: backgroundColorDark,
                                            elevation: 10,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                                padding: EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: backgroundColorDark),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "Created",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline6,
                                                                  fontSize: 14,
                                                                  color:
                                                                      grayColorDark,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                ),
                                                              ),
                                                              Text(
                                                                "$formattedDate",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline6,
                                                                  fontSize: 14,
                                                                  color:
                                                                      textColorDark,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child:
                                                                  SelectableText(
                                                                bioController
                                                                        .listViewData[
                                                                    index]['title'],
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                maxLines: 2,
                                                                style:
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline4,
                                                                  fontSize: 24,
                                                                  color:
                                                                      textColorCyanDark,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "Last Update",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline6,
                                                                  fontSize: 14,
                                                                  color:
                                                                      textColorDark,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                ),
                                                              ),
                                                              Text(
                                                                "$formattedDate2",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline6,
                                                                  fontSize: 14,
                                                                  color:
                                                                      grayColorDark,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(
                                                      thickness: 1,
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      child: SelectableText(
                                                        bioController
                                                                .listViewData[
                                                            index]['description'],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .robotoMono(
                                                          decoration: cmplt
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : null,
                                                          decorationColor:
                                                              Vx.blue300,
                                                          decorationThickness:
                                                              1.5,
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline4,
                                                          fontSize: 16,
                                                          color: cmplt
                                                              ? Vx.gray300
                                                              : Vx.white,
                                                          fontWeight: cmplt
                                                              ? FontWeight.w100
                                                              : FontWeight.w300,
                                                          fontStyle: cmplt
                                                              ? FontStyle.italic
                                                              : FontStyle
                                                                  .normal,
                                                        ),
                                                        textScaleFactor: 1.25,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        );
                                      });
                                }));
                },
              ),
            ),
          )
        ],
      ),
    ));
  }
}
