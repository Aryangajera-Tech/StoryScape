import 'dart:convert';
import 'dart:async';
import 'package:day_2/screen/details.dart';
import 'package:day_2/utils/utils.dart';
import 'package:day_2/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> articles = [];
  int current = 1;

  Future<void> fetchData(String section) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final url =
        'https://api.nytimes.com/svc/topstories/v2/$section.json?api-key=FwdFmNysk1G4dGDRPzd1kCbm8cfv3aoS';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        articles = data['results'];
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData('us');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Yellow,
      body: SafeArea(
        child: Column(
          children: [
            /// New york times
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 40, bottom: 10),
              child: Text(
                "The New York Times",
                style: TextStyle(
                    fontFamily: "Chomsky", color: Green, fontSize: 25),
              ),
            ),

            /// CUSTOM TABBAR
            SizedBox(
              width: double.infinity,
              height: 70,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              fetchData(items[index]);
                              articles.clear();
                              current = index;
                              print(items[index]);
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(8),
                            height: 45,
                            decoration: BoxDecoration(
                              color: current == index ? Yellow : Green,
                              borderRadius: current == index
                                  ? BorderRadius.circular(15)
                                  : BorderRadius.circular(15),
                              border: current == index
                                  ? Border.all(color: Green, width: 2)
                                  : Border.all(color: Green, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                items[index][0].toUpperCase() +
                                    items[index].substring(1),
                                style: GoogleFonts.laila(
                                    fontWeight: FontWeight.w500,
                                    color: current == index ? Green : Yellow),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: current == index,
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Green, shape: BoxShape.circle),
                            ))
                      ],
                    );
                  }),
            ),

            /// MAIN BODY
            if (articles.isEmpty)
              Expanded(
                child: Center(
                  child:  SpinKitRipple(color:Green),
                ),
              )
            else
              Expanded(
                  child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: articles.length,
                itemBuilder: (BuildContext context, int index) {
                  final article = articles[index];
                  Duration difference = DateTime.now().difference(
                      DateTime.parse(article['published_date']!.toString()));
                  int differenceInDays = difference.inDays;
                  int differenceInHours = difference.inHours;
                  int differenceInMinutes = difference.inMinutes;
                  int? aa, bb, cc;
                  cc = article['title']!.toString().length;

                  for (int i = 0; i < cc; i++) {
                    if (article['title'].contains("â")) {
                      aa = article['title'].indexOf("â");
                      article['title'] =
                          article['title'].replaceRange(aa, aa! + 3, "'");
                    }
                    if (article['title'].contains("â")) {
                      bb = article['title'].indexOf("â");
                      article['title'] =
                          article['title'].replaceRange(bb, bb! + 3, "'");
                    }
                    if (article['title'].contains("â")) {
                      bb = article['title'].indexOf("â");
                      article['title'] =
                          article['title'].replaceRange(bb, bb! + 3, "'");
                    }
                    if (article['title'].contains("â")) {
                      bb = article['title'].indexOf("â");
                      article['title'] =
                          article['title'].replaceRange(bb, bb! + 3, "'");
                    }
                  }

                  return InkWell(
                    onTap: () {
                        if (article['multimedia'] == null) {
                          stories.add(
                              "https://play-lh.googleusercontent.com/gfmioo4VBEtPucdVNIYAyaqruXFRWDCc0nsBLORfOS0_s9r5r00Bn_IpjhCumkEusg=w240-h480-rw");
                        } else {
                          int l = article['multimedia'].length;
                          for (int i = 0; i < l; i++) {
                            stories.add(
                                article['multimedia'][i]['url'].toString());
                          }
                        }
                        print(article['title']);
                        print(stories);
                        nextScreen(
                            context,
                            StoryScreen(
                                stories: stories,
                                title: article['title'],
                                writeby: article['byline'],
                                section: article['section'],
                                abstract: article['abstract'],
                                url: article['short_url'],
                                min: differenceInMinutes,
                                hr: differenceInHours,
                                day: differenceInDays));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      article['multimedia'] == null
                                          ? Container(
                                              height: 125,
                                              width: 125,
                                              decoration: BoxDecoration(
                                                color: Yellow,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: const DecorationImage(
                                                  image: NetworkImage("https://play-lh.googleusercontent.com/gfmioo4VBEtPucdVNIYAyaqruXFRWDCc0nsBLORfOS0_s9r5r00Bn_IpjhCumkEusg=w240-h480-rw"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: 125,
                                              width: 125,
                                              decoration: BoxDecoration(
                                                color: Yellow,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      article['multimedia'][0]
                                                              ['url']
                                                          .toString()),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(
                                          // article['title'],
                                          // article['section'].toString().substring(0, 1).toUpperCase() + article['section'].toString().substring(1),
                                          // style: TextStyle(color: Colors.white54, fontSize: 17),
                                        // ),
                                        ReadMoreText(
                                          "${article['title']}",
                                          style: TextStyle(
                                              color: Yellow, fontSize: 15),
                                          trimLines: 2,
                                          colorClickableText: Colors.grey,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: 'Show more',
                                          moreStyle: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white54),
                                          trimExpandedText: '  Show less',
                                          lessStyle: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white54),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(Icons.watch_later_outlined,
                                                color: Colors.white54,
                                                size: 20),
                                            differenceInMinutes < 61
                                                ? Text(
                                                    ' $differenceInMinutes' "Min ago",
                                                    style: const TextStyle(
                                                        color: Colors.white54,
                                                        fontSize: 17),
                                                  )
                                                : differenceInHours < 24
                                                    ? Text(
                                                        " $differenceInHours" "Hr ago",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white54,
                                                            fontSize: 17),
                                                      )
                                                    : Text(
                                                        " $differenceInDays" "Days ago",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white54,
                                                            fontSize: 17),
                                                      ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )),
          ],
        ),
      ),
    );
  }
}
