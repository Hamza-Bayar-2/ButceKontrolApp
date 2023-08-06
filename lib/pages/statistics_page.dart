import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/pages/category_info_page.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:d_chart/d_chart.dart';
import 'package:butcekontrol/classes/language.dart';

class Statistics extends ConsumerWidget {
  const Statistics({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarForPage(title: translation(context).statisticsTitle),
        body: const StaticticsBody(),
      ),
    );
  }
}

class StaticticsBody extends ConsumerStatefulWidget {
  const StaticticsBody({Key? key}) : super(key: key);
  @override
  ConsumerState<StaticticsBody> createState() => _StaticticsBody();
}

class _StaticticsBody extends ConsumerState<StaticticsBody> {
  @override
  Widget build(BuildContext context) {
    ref.listen(databaseRiverpod, (previous, next) {
      ref.watch(databaseRiverpod).isuseinsert;
      ref.watch(databaseRiverpod).updatest;
      categoryList(context);
      return ref.watch(databaseRiverpod);
    });
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(height: 15),
        SizedBox(
          height: size.height * 0.26,
          width: size.width,
          child: pasta(context),
        ),
        const SizedBox(
          height: 15,
        ),
        filterAdd(context),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: SizedBox(
              width: size.width * 0.9,
              child: categoryList(context)),
        ),
        /*SizedBox(
          child: Text(
              "data ${validDateMenu} tür ${giderGelirHepsi} yıl ${selectedYearIndex} ay ${selectedMonthIndex} hafta ${selectedWeekIndex} gün ${selectedDayIndex}"),
        ),*/
      ],
    );
  }

  Widget filterAdd(BuildContext context){
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    return InkWell(
      child: Container(
        width: size.width*0.9,
        height: 30,
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
        child: Center(child: Text("Filtrelemek için dokunun",style: TextStyle(color: renkler.arkaRenk,fontFamily: 'Nexa3',fontSize: 15),)),

      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  contentPadding: const EdgeInsets.only(top: 10,bottom: 10),
                  backgroundColor: Theme.of(context).primaryColor,
                  shadowColor: Colors.black54,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10))),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8,right: 8),
                            child: SizedBox(
                              width: size.width*0.95,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                   "İstatistik Filtreleme",
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontFamily: "Nexa4",
                                        fontSize: 21),
                                  ),
                                  SizedBox(
                                    height: 32,
                                    width: 32,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).canvasColor,
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(20)),
                                      ),
                                      child: IconButton(
                                        icon: Image.asset(
                                          "assets/icons/remove.png",
                                          height: 16,
                                          width: 16,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        iconSize: 24,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Container(
                                  height: 30,
                                  width: size.width*0.95,
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0,right: 8),
                                child: SizedBox(
                                  height: 32,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("İşlem Türü",style: TextStyle(color: renkler.arkaRenk,fontSize: 16,fontFamily: 'Nexa3'),),
                                      Container(
                                        height: 36,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: renkler.sariRenk,
                                          borderRadius: const BorderRadius.all(Radius.circular(10))
                                          
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Container(
                                  height: 30,
                                  width: size.width*0.95,
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0,right: 8),
                                child: SizedBox(
                                  height: 32,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Tarih",style: TextStyle(color: renkler.arkaRenk,fontSize: 16,fontFamily: 'Nexa3'),),
                                      Container(
                                        height: 36,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: renkler.sariRenk,
                                            borderRadius: const BorderRadius.all(Radius.circular(10))

                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Container(
                                  height: 30,
                                  width: size.width*0.95,
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0,right: 8),
                                child: SizedBox(
                                  height: 32,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Sadece Kayıtlı İşlemler",style: TextStyle(color: renkler.arkaRenk,fontSize: 16,fontFamily: 'Nexa3'),),
                                      Container(
                                        height: 36,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: renkler.sariRenk,
                                            borderRadius: const BorderRadius.all(Radius.circular(10))

                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Container(
                                  height: 30,
                                  width: size.width*0.95,
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0,right: 8),
                                child: SizedBox(
                                  height: 32,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("İşlem Aracı",style: TextStyle(color: renkler.arkaRenk,fontSize: 16,fontFamily: 'Nexa3'),),
                                      Container(
                                        height: 36,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: renkler.sariRenk,
                                            borderRadius: const BorderRadius.all(Radius.circular(10))

                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4,right: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                onTap: () {

                                },
                                  child: Container(
                                    height: 26,
                                    width: 150,
                                    decoration: BoxDecoration(color: Theme.of(context).shadowColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Center(child: Text("Eski Haline Getir",style: TextStyle(color: Theme.of(context).canvasColor,fontSize: 15,fontFamily: 'Nexa3'),)),
                                  ),
                              ),
                                InkWell(
                                  onTap: () {

                                  },
                                  child: Container(
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(color: Theme.of(context).highlightColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Center(child: Text("TAMAM",style: TextStyle(color: renkler.arkaRenk,fontSize: 15,fontFamily: 'Nexa3'),)),
                                  ),
                                ),
                              ],
                            ),
                          )

                        ],
                      ),
                      const Text(
                        "Debug:",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ).then((_) => setState(() {}));
      },
    );
  }

  Widget categoryList(BuildContext context) {
    var read = ref.read(statisticsRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    var readCategoryInfo = ref.read(categoryInfoRiverpod);
    var size = MediaQuery.of(context).size;
    final ScrollController scrolbarcontroller1 = ScrollController();
    Future<List<Map<String, dynamic>>> myList = read.getCategoryByMonth(
        validDateMenu,
        giderGelirHepsi,
        selectedYearIndex,
        selectedMonthIndex,
        selectedWeekIndex,
        selectedDayIndex);
    return FutureBuilder(
        future: myList,
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var item = snapshot.data!;
          double totalAmount = 0;
          for (var item in item) {
            totalAmount += item['amount'];
          }
          int colorChangeCount = 0;
          ///Yüzde 5\'ten büyük olan eleman sayısı:
          for (int i = 0; i < item.length; i++) {
            if (item[i]['percentages'] != null && item[i]['percentages'] > 5) {
              colorChangeCount++;
            }
          }
          if (snapshot.data!.isEmpty) {
            return Column(
              children: [
                SizedBox(
                  width: size.width * 0.9,
                  height: size.height * 0.32,
                  child: Center(
                    child: Container(
                      height: 45,
                      width: 160,
                      decoration: BoxDecoration(
                          color: const Color(0xFF0D1C26),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        translation(context).dataNotFound,
                        style: const TextStyle(height: 1,color: Colors.white, fontSize: 16),
                      )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: size.height * 0.04,
                )
              ],
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 1.5),
                            child: SizedBox(
                              width: 4,
                              //height: size.height * 0.35,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 1.5, left: 1.5),
                            child: Container(
                              width: 4,
                              //height: size.height * 0.35,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  color: snapshot.data!.length <= 4
                                      ? Theme.of(context).indicatorColor
                                      : Theme.of(context).canvasColor),
                            ),
                          ),
                        ],
                      ),
                      Theme(
                        data: Theme.of(context).copyWith(
                            scrollbarTheme: ScrollbarThemeData(
                          thumbColor: MaterialStateProperty.all(
                            Theme.of(context).dialogBackgroundColor,)
                        )),
                        child: Scrollbar(
                          thumbVisibility: true,
                          controller: scrolbarcontroller1,
                          scrollbarOrientation: readSettings.localChanger() == const Locale("ar") ? ScrollbarOrientation.left :
                          ScrollbarOrientation.right,
                          interactive: true,
                          thickness: 7,
                          radius: const Radius.circular(15.0),
                          child: ListView.builder(
                            controller: scrolbarcontroller1,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8, right: 16, left: 16),
                                child: InkWell(
                                  onTap: () {
                                    readCategoryInfo.setDateAndCategory(
                                        selectedDayIndex,
                                        selectedMonthIndex,
                                        selectedYearIndex,
                                        selectedWeekIndex,
                                        item[index]['category'],
                                        validDateMenu);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const CategoryInfo(),
                                    ));
                                  },
                                  child: SizedBox(
                                    height: 42,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        color: Theme.of(context).focusColor,
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 5),
                                          Container(
                                            width: 65,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              color: colorsList[index],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                                child: Text(
                                              "% ${item[index]['percentages'].toString()}",
                                              style: const TextStyle(
                                                height: 1,
                                                fontFamily: 'NEXA3',
                                                color: Colors.white,
                                              ),
                                            )),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            item[index]['category'],
                                            style: TextStyle(
                                              height: 1,
                                              fontFamily: 'NEXA3',
                                              fontSize: 18,
                                              color: Theme.of(context).canvasColor,
                                            ),
                                          ),
                                          const Spacer(),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: item[index]['amount']
                                                      .toStringAsFixed(2),
                                                  style: TextStyle(
                                                    height: 1,
                                                    fontFamily: 'NEXA3',
                                                    fontSize: 16,
                                                    color: Theme.of(context).dialogBackgroundColor,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: readSettings.prefixSymbol,
                                                  style: TextStyle(
                                                    height: 1,
                                                    fontFamily: 'TL',
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    color: Theme.of(context).dialogBackgroundColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: size.width * 0.9,
                  height: size.height * 0.04,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 210,
                        child: Text(
                          translation(context).totalAmountStatistics,
                          style: TextStyle(
                            height: 1,
                            fontFamily: 'NEXA3',
                            fontSize: 17,
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color: Theme.of(context).focusColor,
                        ),
                        height: 26,
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: totalAmount.toStringAsFixed(1),
                                      style: TextStyle(
                                        height: 1,
                                        fontFamily: 'Nexa3',
                                        fontSize: 17,
                                        color: Theme.of(context).canvasColor,
                                      ),
                                    ),
                                     TextSpan(
                                      text: readSettings.prefixSymbol,
                                      style: TextStyle(
                                        height: 1,
                                        fontFamily: 'TL',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        color: Theme.of(context).canvasColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        });
  }

  tarihButon(BuildContext context) {
    if (selectDateMenu == 0) {
      return dateSelectMenu(context);
    } else if (selectDateMenu == 1) {
      return yearSelectMenu(context);
    } else if (selectDateMenu == 2) {
      return monthSelectMenu(context);
    } else if (selectDateMenu == 3) {
      return weekSelectMenu(context);
    } else {
      return daySelectMenu(context);
    }
  }

  int selectDateMenu = 2;
  int validDateMenu = 2;
  int selectedMonthIndex = DateTime.now().month;
  int selectedYearIndex = DateTime.now().year;
  int selectedWeekIndex = 1;
  int selectedDayIndex = DateTime.now().day;
  final PageController pageDayController =
      PageController(initialPage: DateTime.now().day - 1);
  final PageController pageWeekController = PageController(initialPage: 0);
  final PageController pageMonthController =
      PageController(initialPage: DateTime.now().month - 1);
  final PageController pageYearController =
      PageController(initialPage: DateTime.now().year - 2020);

  Widget dateSelectMenu(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 240,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Color(0xff0D1C26),
              ),
              height: 34,
              width: 240,
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectDateMenu = 1;
                                validDateMenu = 1;
                                selectedYearIndex = DateTime.now().year;
                              });
                            },
                            child: Text(
                              translation(context).yearly,
                              style: const TextStyle(
                                height: 1,
                                fontFamily: 'NEXA4',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 5,
                          width: 36,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10)),
                            color: Color(0xffF2CB05),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 44,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectDateMenu = 2;
                                validDateMenu = 2;
                                selectedYearIndex = DateTime.now().year;
                                selectedMonthIndex = DateTime.now().month;
                              });
                            },
                            child: Text(
                              translation(context).monthly,
                              style: const TextStyle(
                                height: 1,
                                fontFamily: 'NEXA4',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 5,
                          width: 40,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15)),
                            color: Color(0xffF2CB05),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 70,
                  height: 40,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectedYearIndex = DateTime.now().year;
                                selectedMonthIndex = DateTime.now().month;
                                selectedWeekIndex = 1;
                                selectDateMenu = 3;
                                validDateMenu = 3;
                              });
                            },
                            child: Text(
                              translation(context).weekly,
                              style: const TextStyle(
                                height: 1,
                                fontFamily: 'NEXA4',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 5,
                          width: 66,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15)),
                            color: Color(0xffF2CB05),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 50,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectedYearIndex = DateTime.now().year;
                                selectedMonthIndex = DateTime.now().month;
                                selectedDayIndex = DateTime.now().day;
                                selectDateMenu = 4;
                                validDateMenu = 4;
                              });
                            },
                            child: Text(
                              translation(context).daily,
                              style: const TextStyle(
                                height: 1,
                                fontFamily: 'NEXA4',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          child: Container(
                            height: 5,
                            width: 46,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15)),
                              color: Color(0xffF2CB05),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget monthSelectMenu(BuildContext context) {
    var read = ref.read(statisticsRiverpod);
    List monthName = read.getMonths();
    List yearName = read.getYears();
    return SizedBox(
      height: 40,
      width: 240,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Color(0xff0D1C26),
              ),
              height: 34,
              width: 240,
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15)),
                      color: Color(0xffF2CB05),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectDateMenu = 0;
                          });
                        },
                        child: Text(
                          translation(context).monthly,
                          style: const TextStyle(
                            height: 1,
                            fontFamily: 'NEXA4',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 34,
                      width: 60,
                      child: PageView(
                        controller: pageMonthController,
                        onPageChanged: (index) {
                          setState(() {
                            selectedMonthIndex = index + 1;
                          });
                        },
                        children: monthName
                            .map(
                              (year) => Center(
                                child: Text(
                                  year,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa3',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 60,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 34,
                      width: 48,
                      child: PageView(
                        controller: pageYearController,
                        onPageChanged: (index) {
                          setState(() {
                            selectedYearIndex = index + 2020;
                          });
                        },
                        children: yearName
                            .map(
                              (year) => Center(
                                child: Text(
                                  year,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa4',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 48,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget yearSelectMenu(BuildContext context) {
    var read = ref.read(statisticsRiverpod);
    List yearName = read.getYears();
    return SizedBox(
      height: 40,
      width: 240,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Color(0xff0D1C26),
              ),
              height: 34,
              width: 240,
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Container(
                    height: 40,
                    width: 140,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15)),
                      color: Color(0xffF2CB05),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              selectDateMenu = 0;
                            });
                          },
                          child: Text(
                            translation(context).yearly,
                            style: const TextStyle(
                              height: 1,
                              fontFamily: 'NEXA4',
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 34,
                      width: 48,
                      child: PageView(
                        controller: pageYearController,
                        onPageChanged: (index) {
                          setState(() {
                            selectedYearIndex = index + 2020;
                          });
                        },
                        children: yearName
                            .map(
                              (year) => Center(
                                child: Text(
                                  year,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa4',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 48,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget weekSelectMenu(BuildContext context) {
    var read = ref.read(statisticsRiverpod);
    List yearName = read.getYears();
    List monthName = read.getMonths();
    List weekName = read.getWeeks(selectedMonthIndex, selectedYearIndex + 2020);
    return SizedBox(
      height: 40,
      width: 240,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Color(0xff0D1C26),
              ),
              height: 34,
              width: 240,
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Container(
                    height: 40,
                    width: 66,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15)),
                      color: Color(0xffF2CB05),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              selectDateMenu = 0;
                            });
                          },
                          child: Text(
                            translation(context).weekly,
                            style: const TextStyle(
                              height: 1,
                              fontFamily: 'NEXA4',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 34,
                      width: 16,
                      child: PageView(
                        controller: pageWeekController,
                        onPageChanged: (index) {
                          setState(() {
                            selectedWeekIndex = index + 1;
                          });
                        },
                        children: weekName
                            .map(
                              (week) => Center(
                                child: Text(
                                  "$week.",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa3',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 12,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 34,
                      width: 60,
                      child: PageView(
                        controller: pageMonthController,
                        onPageChanged: (index) {
                          setState(() {
                            selectedMonthIndex = index + 1;
                          });
                        },
                        children: monthName
                            .map(
                              (year) => Center(
                                child: Text(
                                  year,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa3',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 60,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 34,
                      width: 48,
                      child: PageView(
                        controller: pageYearController,
                        onPageChanged: (index) {
                          setState(() {
                            selectedYearIndex = index + 2020;
                          });
                        },
                        children: yearName
                            .map(
                              (year) => Center(
                                child: Text(
                                  year,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa4',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 48,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget daySelectMenu(BuildContext context) {
    var read = ref.read(statisticsRiverpod);
    List yearName = read.getYears();
    List monthName = read.getMonths();
    List dayName = read.getDays(selectedMonthIndex, selectedYearIndex + 2020);
    return SizedBox(
      height: 40,
      width: 240,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Color(0xff0D1C26),
              ),
              height: 34,
              width: 240,
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Container(
                    height: 40,
                    width: 56,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15)),
                      color: Color(0xffF2CB05),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              selectDateMenu = 0;
                            });
                          },
                          child: Text(
                            translation(context).daily,
                            style: const TextStyle(
                              height: 1,
                              fontFamily: 'NEXA4',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 34,
                      width: 20,
                      child: PageView(
                        controller: pageDayController,
                        onPageChanged: (index) {
                          setState(() {
                            selectedDayIndex = index + 1;
                          });
                        },
                        children: dayName
                            .map(
                              (year) => Center(
                                child: Text(
                                  year,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa3',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 18,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 34,
                      width: 60,
                      child: PageView(
                        controller: pageMonthController,
                        onPageChanged: (index) {
                          setState(() {
                            selectedMonthIndex = index + 1;
                          });
                        },
                        children: monthName
                            .map(
                              (year) => Center(
                                child: Text(
                                  year,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa3',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 60,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 34,
                      width: 48,
                      child: PageView(
                        controller: pageYearController,
                        onPageChanged: (index) {
                          setState(() {
                            selectedYearIndex = index + 2020;
                          });
                        },
                        children: yearName
                            .map(
                              (year) => Center(
                                child: Text(
                                  year,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa4',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 48,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String giderGelirHepsi = 'Gider';
  double buttonHeight = 34; //Basılmamış yükseklik
  double buttonHeight2 = 40; //Basılmış yükseklik
  double buttonHeight3 = 34; //Basılmamış yükseklik
  Color containerColor3 = const Color(0xff0D1C26); //Basılmamış renk
  Color containerColor2 = const Color(0xff0D1C26); //Basılmamış renk
  Color containerColor = const Color(0xffF2CB05); //Basılmış renk
  Color textColor3 = Colors.white; //Basılmamış yazı rengi
  Color textColor2 = Colors.white; //Basılmamış yazı rengi
  Color textColor = const Color(0xff0D1C26); //Basılmış yazı rengi
  int index = 0; // Gider ve Gelir butonları arasında geçiş yapmak için
  Widget gelirGiderButon(BuildContext context) {
    void changeColor2(int index) {
      if (index == 0) {
        setState(() {
          buttonHeight2 = 40;
          buttonHeight = 34;
          buttonHeight3 = 34;
          containerColor = const Color(0xffF2CB05);
          containerColor2 = const Color(0xff0D1C26);
          containerColor3 = const Color(0xff0D1C26);
          textColor = const Color(0xff0D1C26);
          textColor2 = Colors.white;
          textColor3 = Colors.white;
          //this.index = 1;
        });
      } else if (index == 1) {
        setState(() {
          buttonHeight = 40;
          buttonHeight2 = 34;
          buttonHeight3 = 34;
          containerColor2 = const Color(0xffF2CB05);
          containerColor = const Color(0xff0D1C26);
          containerColor3 = const Color(0xff0D1C26);
          textColor = Colors.white;
          textColor2 = const Color(0xff0D1C26);
          textColor3 = Colors.white;
          //this.index = 0;
        });
      } else {
        setState(() {
          buttonHeight3 = 40;
          buttonHeight2 = 34;
          buttonHeight = 34;
          containerColor3 = const Color(0xffF2CB05);
          containerColor2 = const Color(0xff0D1C26);
          containerColor = const Color(0xff0D1C26);
          textColor = Colors.white;
          textColor2 = Colors.white;
          textColor3 = const Color(0xff0D1C26);
          //this.index = 0;
        });
      }
    }
    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              color: Color(0xff0D1C26),
            ),
            height: 34,
            width: 240,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: containerColor,
                  ),
                  height: buttonHeight2,
                  child: SizedBox(
                    width: 70,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            changeColor2(0);
                            giderGelirHepsi = "Gider";
                          });
                        },
                        child: Text(translation(context).expenses,
                            style: TextStyle(
                              height: 1,
                                color: textColor,
                                fontSize: 16,
                                fontFamily: 'Nexa4',
                                fontWeight: FontWeight.w800))),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: containerColor2,
                  ),
                  height: buttonHeight,
                  child: SizedBox(
                    width: 70,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            changeColor2(1);
                            giderGelirHepsi = 'Gelir';
                          });
                        },
                        child: Text(translation(context).income,
                            style: TextStyle(
                              height: 1,
                                color: textColor2,
                                fontSize: 16,
                                fontFamily: 'Nexa4',
                                fontWeight: FontWeight.w800))),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: containerColor3,
                  ),
                  height: buttonHeight3,
                  child: SizedBox(
                    width: 70,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            changeColor2(3);
                            giderGelirHepsi = 'Hepsi';
                          });
                        },
                        child: Text(translation(context).both,
                            style: TextStyle(
                              height: 1,
                                color: textColor3,
                                fontSize: 16,
                                fontFamily: 'Nexa4',
                                fontWeight: FontWeight.w800))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }

  Widget pasta(BuildContext context) {
    var read = ref.read(statisticsRiverpod);
    Future<List<Map<String, dynamic>>> listeeme = read.getCategoryAndAmount(
        validDateMenu,
        giderGelirHepsi,
        selectedYearIndex,
        selectedMonthIndex,
        selectedWeekIndex,
        selectedDayIndex);

    return FutureBuilder(
        future: listeeme,
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var item = snapshot.data!; // !
          if (snapshot.data!.isEmpty) {
            return Center(
              child: SizedBox(
                height: 140,
                width: 140,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(200)),
                ),
              ),
            );
          } else {
            return DChartPie(
              data: item,
              strokeWidth: 1,
              fillColor: (pieData, index) {
                return  colorsList[index!];
              },
              pieLabel: (pieData, index) {
                return "${pieData['domain']}:\n${pieData['measure']}%";
              },
              labelPosition: PieLabelPosition.auto,
              //donutWidth: 15,
              showLabelLine: true,
              labelColor: Theme.of(context).canvasColor,
              labelFontSize: 11,
              labelLinelength: 5,
              labelLineColor: Theme.of(context).canvasColor,
            );
          }
        });
  }

  var colorsList = [
    Colors.red.shade900,
    Colors.red,
    Colors.orange.shade800,
    Colors.orange.shade500,
    Colors.amber.shade500,
    Colors.yellow.shade500,
    Colors.lime.shade700,
    Colors.lime.shade500,
    Colors.green.shade700,
    Colors.green.shade500,
    Colors.lightGreen.shade600,
    Colors.lightGreen.shade300,
    Colors.green.shade200,
    Colors.teal.shade700,
    Colors.teal.shade500,
    Colors.teal.shade200,
    Colors.cyanAccent,
    Colors.blue.shade600,
    Colors.blue.shade400,
    Colors.indigo.shade500,
    Colors.deepPurple.shade800,
    Colors.deepPurple.shade500,
    Colors.deepPurple.shade200,
  ];
  var colorsList2 = [
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lime,
    Colors.lightGreen,
    Colors.green,
    Colors.teal,
    Colors.cyanAccent,
    Colors.blue,
    Colors.indigo,
    Colors.deepPurple,
  ];
}
