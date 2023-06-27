// ignore_for_file: deprecated_member_use, library_private_types_in_public_api
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../utils/utils.dart';

final List stories = [];

// ignore: must_be_immutable
class StoryScreen extends StatefulWidget {
  final List stories;
  String? title, writeby, section, abstract, url;
  int min, hr, day;
  StoryScreen(
      {super.key, required this.stories,
      required this.title,
      required this.writeby,
      required this.section,
      required this.abstract,
      required this.url,
      required this.min,
      required this.hr,
      required this.day});
  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  PageController? _pageController;
  late AnimationController _animController;
  int _currentIndex = 0;
  int? aa, bb, cc;
  String? write1,write2;
  bool bookmark = false;

  @override
  void initState() {
    super.initState();
    cc = widget.abstract.toString().length;

    for (int i = 0; i < cc!; i++) {
      if (widget.abstract.toString().contains("â")) {
        aa = widget.abstract.toString().indexOf("â");
        widget.abstract =
            widget.abstract.toString().replaceRange(aa!, aa! + 3, "'");
      }
      if (widget.abstract.toString().contains("â")) {
        bb = widget.abstract.toString().indexOf("â");
        widget.abstract =
            widget.abstract.toString().replaceRange(bb!, bb! + 3, "'");
      }
      if (widget.abstract.toString().contains("â")) {
        bb = widget.abstract.toString().indexOf("â");
        widget.abstract =
            widget.abstract.toString().replaceRange(bb!, bb! + 3, "'");
      }
      if (widget.abstract.toString().contains("â")) {
        bb = widget.abstract.toString().indexOf("â");
        widget.abstract =
            widget.abstract.toString().replaceRange(bb!, bb! + 3, "'");
      }
    }

    if(widget.writeby == ""){
      write2 = "The New york Times";
    }
    else{
      write1 = widget.writeby.toString().substring(3).trim().replaceAll(", ", ",\n");
      write2 = write1.toString().replaceAll("and ",",\n");
    }

    _pageController = PageController();
    _animController = AnimationController(vsync: this);

    final String firstStory = widget.stories.first;
    _loadStory(story: firstStory, animateToPage: false);

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.stop();
        setState(() {
          if (_currentIndex + 1 < widget.stories.length) {
            _currentIndex += 1;
            _loadStory(story: widget.stories[_currentIndex]);
          } else {
            // Out of bounds - loop story
            // You can also Navigator.of(context).pop() here
            _currentIndex = 0;
            _loadStory(story: widget.stories[_currentIndex]);
          }
        });
      }
    });

  }


  @override
  void dispose() {
    stories.clear();
    _pageController!.dispose();
    _animController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final story = widget.stories[_currentIndex];
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Green,
            ),
            GestureDetector(
              onTapDown: (details) => _onTapDown(details, story),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 3.08,
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.stories.length,
                  itemBuilder: (context, i) {
                    final String story = widget.stories[i];
                    return CachedNetworkImage(
                      imageUrl: story,
                      width: double.infinity,
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 10.0,
              left: 10.0,
              right: 10.0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: widget.stories
                        .asMap()
                        .map((i, e) {
                          return MapEntry(
                            i,
                            AnimatedBar(
                              animController: _animController,
                              position: i,
                              currentIndex: _currentIndex,
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 4.5, left: 20),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: Yellow),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        widget.section.toString()[0].toUpperCase() +
                            widget.section.toString().substring(1),
                        style: TextStyle(color: Green, fontSize: 15)),
                  )),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15, top: 20),
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white12),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: GestureDetector(
                        onTap: () {
                          stories.clear();
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close, size: 20, color: Yellow)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 3.5),
              child: GlassmorphicContainer(
                width: double.infinity,
                height: double.infinity,
                borderRadius: 20,
                blur: 10,
                border: 0,
                alignment: Alignment.topCenter,
                linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFffffff).withOpacity(0.1),
                      const Color(0xFFFFFFFF).withOpacity(0.05),
                    ],
                    stops: const [
                      0.1,
                      1,
                    ]),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFffffff).withOpacity(0.5),
                    const Color((0xFFFFFFFF)).withOpacity(0.5),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Text(
                          widget.title.toString(),
                          style: GoogleFonts.fraunces(
                              color: Yellow,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white12),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.account_circle_sharp,
                                          color: Colors.white, size: 20),
                                      const SizedBox(width: 5),
                                      Text(write2.toString(),
                                          style: TextStyle(
                                              color: Yellow, fontSize: MediaQuery.of(context).size.width *0.033))
                                    ],
                                  )
                                )),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white12),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.watch_later_outlined,
                                          color: Colors.white, size: 20),
                                      const SizedBox(width: 5),
                                      widget.min < 61
                                          ? Text(
                                              "${widget.min} Min ago",
                                              style: TextStyle(
                                                  color: Yellow, fontSize: MediaQuery.of(context).size.width *0.033),
                                            )
                                          : widget.hr < 24
                                              ? Text(
                                                  "${widget.hr} Hr ago",
                                                  style: TextStyle(
                                                      color: Yellow,
                                                      fontSize: MediaQuery.of(context).size.width *0.033),
                                                )
                                              : Text(
                                                  "${widget.day} Days ago",
                                                  style: TextStyle(
                                                      color: Yellow,
                                                      fontSize: MediaQuery.of(context).size.width *0.033),
                                                ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                         const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                final imageurl = stories[0];
                                final uri = Uri.parse(imageurl);
                                final response = await http.get(uri);
                                final bytes = response.bodyBytes;
                                final temp = await getTemporaryDirectory();
                                final path = '${temp.path}/image.jpg';
                                File(path).writeAsBytesSync(bytes);
                                await Share.shareFiles([path],
                                    text: 'Take a look at this *${widget.title}*\nWrite *${widget.writeby}*\nShow more at *StoyScape.*');
                              },
                              child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white12),
                                  child: Padding(
                                    padding:  const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.share,
                                      color: Yellow,
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  bookmark = !bookmark;
                                });
                              },
                              child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white12),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: bookmark ?
                                          Icon(
                                      Icons.star,
                                      color: Yellow,
                                    )
                                        : Icon(
                                      Icons.star_border,
                                      color: Yellow,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "About",
                              style: TextStyle(
                                  color: Yellow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            InkWell(
                                onTap: () {
                                  launch(widget.url.toString());
                                },
                                child: const Text(
                                  "Read more",
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 17),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.abstract.toString(),
                          style: GoogleFonts.hindGuntur(fontSize: 15,color: Colors.white38),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details, story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadStory(story: widget.stories[_currentIndex]);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_currentIndex + 1 < widget.stories.length) {
          _currentIndex += 1;
          _loadStory(story: widget.stories[_currentIndex]);
        } else {
          // Out of bounds - loop story
          // Navigator.of(context).pop();
          _currentIndex = 0;
          _loadStory(story: widget.stories[_currentIndex]);
        }
      });
    }
  }

  void _loadStory({String? story, bool animateToPage = true}) {
    _animController.stop();
    _animController.reset();
    _animController.duration = const Duration(seconds: 8);
    _animController.forward();
    if (animateToPage) {
      _pageController!.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
      );
    }
  }
}

class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar({super.key,
    required this.animController,
    required this.position,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                        animation: animController,
                        builder: (context, child) {
                          return _buildContainer(
                            constraints.maxWidth * animController.value,
                            Yellow,
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 4.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}
