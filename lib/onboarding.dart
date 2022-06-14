import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIntro extends StatefulWidget {
  const AppIntro({Key? key}) : super(key: key);

  @override
  State<AppIntro> createState() => _AppIntroState();
}

class _AppIntroState extends State<AppIntro> {
  late PageController pageController;
  int pageIndex =0;

  @override
  void initState() {
    // TODO: implement initState
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    itemCount: OnBoardModel.listOnBoard.length,
                    controller: pageController,
                    itemBuilder: (context, index) => OnBoardContent(
                        image: OnBoardModel.listOnBoard[index].imageUrl,
                        title: OnBoardModel.listOnBoard[index].title,
                        description: OnBoardModel.listOnBoard[index].title)),
              ),
              Row(
                children: [
                  ...List.generate(OnBoardModel.listOnBoard.length, (index) => const Padding(padding: EdgeInsets.only(left:  4),
                    child: DotIndicator(isActive: true),
                  )),
                  Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        pageController.nextPage(
                            duration: const Duration(microseconds: 500),
                            curve: Curves.ease);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/rightarrow.svg",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key, required this.isActive,
  }) : super(key: key);
  final bool  isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isActive ? 12 : 4,
      width: 4,
      decoration: const BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}



class OnBoardModel {
  late final String imageUrl, title, description;

  OnBoardModel(
      {required this.imageUrl, required this.title, required this.description});

  static List<OnBoardModel> listOnBoard = [
    OnBoardModel(
        imageUrl: "assets/images/b1.png", title: "t1", description: "d1"),
    OnBoardModel(
        imageUrl: "assets/images/b2.png", title: "t2", description: "d2"),
    OnBoardModel(
        imageUrl: "assets/images/b3.png", title: "t3", description: "d3"),
  ];
}

class OnBoardContent extends StatefulWidget {
  const OnBoardContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String image, title, description;

  @override
  State<OnBoardContent> createState() => _OnBoardContentState();
}

class _OnBoardContentState extends State<OnBoardContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          widget.image,
          height: 250,
        ),
        const Spacer(),
        Text(widget.title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.w500)),
        const Spacer(),
        Text(widget.description),
      ],
    );
  }
}
