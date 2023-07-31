import 'package:butcekontrol/UI/spend_detail.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod_management.dart';
class searchPage extends ConsumerStatefulWidget {
  const searchPage({Key? key}) : super(key: key);

  @override
  ConsumerState<searchPage> createState() => _searchPageState();
}

class _searchPageState extends ConsumerState<searchPage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var dbRiv = ref.watch(databaseRiverpod);
    var readDailyRiv = ref.read(dailyInfoRiverpod);
    var size = MediaQuery.of(context).size ;
    var renkler = CustomColors();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.5),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height : 60,
                    color: renkler.koyuuRenk,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: size.height * .05,
                          width : size.width * 0.65,
                          decoration: BoxDecoration(
                            color: renkler.arkaRenk,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: TextField(
                              onChanged: (value) {
                                dbRiv.searchItem(_controller.text);
                              },
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: "Aramak İstediğiniz Notu Giriniz.",
                                contentPadding: EdgeInsets.symmetric(horizontal: size.width * .01,vertical: 13),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Filitreleme yapıyoruz");
                          },
                          child: Container(
                            width: size.width * .085,
                            height: size.width * .085,
                            decoration: BoxDecoration(
                              color: renkler.sariRenk,
                              shape: BoxShape.circle
                            ),
                            child: const Icon(
                                Icons.filter_alt,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: size.width * .085,
                            height: size.width * .085,
                            decoration: BoxDecoration(
                                color: renkler.sariRenk,
                                shape: BoxShape.circle
                            ),
                            child: const Icon(
                              Icons.close_sharp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * .01),
                  dbRiv.searchListTile?.length == 0 || dbRiv.searchListTile == null
                  ?Padding(
                    padding:  EdgeInsets.only(top: size.height * .01),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: renkler.sariRenk,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                          "Eşleşen Veri Yok",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Nexa3"
                        ),
                      ),
                    ),
                  )
                  :Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .04),
                    child: SizedBox(
                      height: size.height * .75,
                      child: ListView.builder(
                       itemCount: dbRiv.searchListTile!.length,
                       itemBuilder: (context, index) {
                         return Column(
                           children: [
                             GestureDetector(
                               onTap: () {
                                 readDailyRiv.setSpendDetail(dbRiv.searchListTile!, index);
                                 showModalBottomSheet(
                                   context: context,
                                   shape: const RoundedRectangleBorder(
                                       borderRadius: BorderRadius.vertical(
                                           top: Radius.circular(25))),
                                   backgroundColor:
                                   const Color(0xff0D1C26),
                                   builder: (context) {
                                     // genel bilgi sekmesi açılıyor.
                                     return SpendDetail();
                                   },
                                 );
                               },
                               child: Container(
                                 padding: EdgeInsets.only(right: size.width * .04),
                                 height: size.height * .088,
                                 decoration: BoxDecoration(
                                   color: renkler.koyuuRenk,
                                   borderRadius: BorderRadius.circular(12),
                                 ),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Container(
                                       width: 6,
                                       height: size.height * .055 ,
                                       decoration: BoxDecoration(
                                        color: dbRiv.searchListTile![index].operationType == "Gelir"
                                        ?renkler.yesilRenk
                                        :renkler.kirmiziRenk,
                                        borderRadius: BorderRadius.horizontal(right: Radius.circular(12))
                                       ),
                                     ),
                                     SizedBox(
                                       width: size.width * .82,
                                       height: size.height * .072,
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                         children: [
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               SizedBox(
                                                 width: size.width * .30,
                                                 child: Text(
                                                   "${dbRiv.searchListTile![index].category}",
                                                  //"aaaaaaaaaaaaaaaaaaaa",
                                                   style: TextStyle(
                                                       color: renkler.arkaRenk,
                                                       fontSize: 16
                                                   ),
                                                 ),
                                               ),
                                               SizedBox(
                                                 width: size.width * .28,
                                                 child: Text(
                                                   "${dbRiv.searchListTile![index].operationDate}",
                                                   style: TextStyle(
                                                       color: renkler.arkaRenk,
                                                       fontSize: 16
                                                   ),
                                                 ),
                                               ),
                                               SizedBox(
                                                 width: size.width * .225,
                                                 child: Align(
                                                   alignment: Alignment.centerRight,
                                                   child: Text(
                                                     "${dbRiv.searchListTile![index].amount} ₺",
                                                     style: TextStyle(
                                                         color: renkler.arkaRenk,
                                                         fontFamily: "Nexa",
                                                         fontSize: 16
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ],
                                           ),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               SizedBox(
                                                 width : size.width * .7,
                                                 child: Text(
                                                   "${dbRiv.searchListTile![index].note}",
                                                   style: TextStyle(
                                                       color: renkler.arkaRenk,
                                                       fontSize: 16
                                                   ),
                                                   maxLines: 1,
                                                   overflow: TextOverflow.ellipsis,
                                                 ),
                                               ),
                                               Icon(
                                                 Icons.arrow_forward_ios,
                                                 color: renkler.sariRenk,
                                               )
                                             ],
                                           ),
                                         ],
                                       ),
                                     ),
                                     /*
                                     SizedBox(
                                       width: size.width * .9,
                                         child: Text(
                                             "${dbRiv.searchListTile![index].operationDate}",
                                           style: TextStyle(
                                             color: renkler.arkaRenk,
                                             fontSize: 16
                                           ),
                                         )
                                     )
                                      */
                                   ],
                                 ),
                               ),
                             ),
                             SizedBox(height: size.height * .007),
                           ],
                         );
                       },
                 ),
                    ),
                  ),
                  /*
                  FutureBuilder(
                    future: dbRiv.searchListTile,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        var data = snapshot!.data;
                        return ListView.builder(
                          itemCount: data!.length,//kayıt sayısı
                          itemBuilder: (context, index) {//her kayıtın görünümü
                          },
                        );
                      }else{
                        return CircularProgressIndicator();
                      }
                    },
                  ),

                   */

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:size.width * .07, vertical: size.height * 0.02),
                    child: Column(
                      children: [

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
