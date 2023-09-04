import 'package:butcekontrol/Pages/add_data_page.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod_management.dart';

class NavBar extends ConsumerWidget {
  const NavBar({Key ?key}) : super(key : key) ;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(botomNavBarRiverpod).currentindex;
    var read = ref.read(botomNavBarRiverpod);
    var readCalendar  = ref.read(calendarRiverpod);
    CustomColors renkler = CustomColors();
    final Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        //color: Theme.of(context).primaryColor,
        width: size.width,
        height: 64,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                width: size.width,
                height: 52,
                child: Stack(
                  children: [
                    Container(
                      child: CustomPaint(
                        size: Size(size.width, 80),
                        painter: BNBCustomPainter(),
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 0)
                            )
                          ]
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: 52,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  size: 30,
                                  Icons.equalizer_rounded,
                                  color: Colors.white,
                                ),
                                highlightColor: Theme.of(context).primaryColor,
                                constraints: const BoxConstraints(
                                    minHeight: 45,
                                    minWidth: 50
                                ),
                                onPressed: () {
                                  read.setCurrentindex(1);
                                  Navigator.of(context).popUntil((route) => route.isFirst                                ) ; //Butun Navigator stacki boşaltıyor

                                },
                              ),
                              read.currentindex == 1
                                  ? ClipRRect(
                                borderRadius: const BorderRadius.vertical(top:Radius.circular(20)),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  height : 7,
                                  width : 25 ,
                                  color: Theme.of(context).disabledColor,
                                ),
                              )
                                  :const SizedBox(width: 1,)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  icon: const Icon(
                                    size: 30,
                                    Icons.calendar_month_rounded,
                                    color: Colors.white,
                                  ),
                                  highlightColor: Theme.of(context).primaryColor,
                                  constraints: const BoxConstraints(
                                      minHeight: 45,
                                      minWidth: 50
                                  ),
                                  onPressed: () {
                                    read.setCurrentindex(2);
                                    readCalendar.resetPageController();
                                    Navigator.of(context).popUntil((route) => route.isFirst) ;
                                  }
                              ),
                              read.currentindex == 2
                                  ? ClipRRect(
                                borderRadius: const BorderRadius.vertical(top:Radius.circular(20)),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  height : 7,
                                  width : 25 ,
                                  color: Theme.of(context).disabledColor,
                                ),
                              )
                                  :const SizedBox(width: 1,)
                            ],
                          ),
                          SizedBox(
                            width: size.width / 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  icon: const Icon(
                                    size: 30,
                                    Icons.calculate_rounded,
                                    color: Colors.white,
                                  ),
                                  highlightColor: Theme.of(context).primaryColor,
                                  constraints: const BoxConstraints(
                                      minHeight: 45,
                                      minWidth: 50
                                  ),
                                  onPressed:() {
                                    read.setCurrentindex(3);
                                    Navigator.of(context).popUntil((route) => route.isFirst) ;
                                  }
                              ),
                              read.currentindex == 3
                                  ? ClipRRect(
                                borderRadius: const BorderRadius.vertical(top:Radius.circular(20)),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  height : 7,
                                  width : 25 ,
                                  color: Theme.of(context).disabledColor,
                                ),
                              )
                                  :const SizedBox(width: 1,)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  icon: const Icon(
                                    size: 30,
                                    Icons.keyboard_control_rounded,
                                    color: Colors.white,
                                  ),
                                  highlightColor: Theme.of(context).primaryColor,
                                  constraints: const BoxConstraints(
                                      minHeight: 45,
                                      minWidth: 50
                                  ),
                                  onPressed: () {
                                    read.setCurrentindex(4);
                                    Navigator.of(context).popUntil((route) => route.isFirst) ;
                                  }
                              ),
                              read.currentindex == 4
                                  ? ClipRRect( ///navbar sarı pointer
                                borderRadius: const BorderRadius.vertical(top:Radius.circular(20)),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  height : 7,
                                  width : 25 ,
                                  color: Theme.of(context).disabledColor,
                                ),
                              )
                                  :const SizedBox(width: 1)
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.zero,
                width: 64,
                height: 64,
                child: Center(
                  heightFactor: 1,
                  child: FloatingActionButton.large(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddData(),));
                      read.setcur();  /// arastırılacak
                    },
                    splashColor: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).disabledColor,
                    elevation: 0,
                    child: Image.asset(
                      "assets/icons/add.png",
                      height: 38,
                      width: 38,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xff0D1C26)
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width * 0.5 - size.height, 0);
    //Path path. = Path()..moveTo(size.width * 0.40, size.width*0.5-size.height );
    path.quadraticBezierTo(
        size.width * 0.50, 0, size.width * 0.50, size.height);
    path.moveTo(size.width * 0.50, size.height);
    //path.lineTo(size.width * 0.50, size.height);
    path.quadraticBezierTo(
        size.width * 0.5, 0, size.width * 0.50 + size.height, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}