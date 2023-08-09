import 'package:app_settings/app_settings.dart';
import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/classes/nav_bar.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/constans/theme.dart';
import 'package:butcekontrol/pages/more/password.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'password_splash.dart';
import 'backup.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

///Koyu tema , Yedeklenme durumunun  database ile implementi sağlanrı
class _SettingsState extends ConsumerState<Settings> {
  List<String> moneyPrefix = <String>[
    'TRY',
    "USD",
    "EUR",
    "GBP",
    "KWD",
    "JOD",
    "IQD",
    "SAR"
  ];
  List<String> dilDestegi = <String>["Türkçe", "English", "العربية"];
  CustomColors renkler = CustomColors();

  @override
  Widget build(BuildContext context) {
    var readNavBar = ref.read(botomNavBarRiverpod);
    readNavBar.currentColor = Theme.of(context).primaryColor;
    ref.watch(settingsRiverpod).isuseinsert;
    var size = MediaQuery.of(context).size;
    var readSetting = ref.read(settingsRiverpod);
    var currencyRiv = ref.read(currencyRiverpod);
    //String? Language = readSetting.Language;
    bool darkthememode = readSetting.DarkMode == 1 ? true : false;
    bool isPassword = readSetting.isPassword == 1 ? true : false;
    bool isBackup = readSetting.isBackUp == 1 ? true : false;
    String language =
        readSetting.Language! == "Turkce" ? "Türkçe" : readSetting.Language!;

    /// dilDestegi ile database çakışmasından dolayı böyle bir koşullu atama ekledik
    String dropdownshowitem = 'TRY';
    String? Prefix = readSetting.Prefix;
    ref.watch(settingsRiverpod).isuseinsert;
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          //backgroundColor: ThemeData().scaffoldBackgroundColor,
          bottomNavigationBar: const NavBar(),
          appBar: AppBarForPage(title: translation(context).settingsTitle),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: 40,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: renkler.arkaRenk, // Set border color
                        width: 1.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        Text(
                          translation(context).darkMode,
                          style: const TextStyle(
                            fontFamily: "Nexa3",
                            fontSize: 15,
                            height: 1
                          ),
                        ),
                        const Spacer(),
                        darkthememode
                            ? Text(
                                translation(context).on,
                                style: const TextStyle(fontFamily: "Nexa3",fontSize: 15,),
                              )
                            : Text(
                                translation(context).off,
                                style: const TextStyle(fontFamily: "Nexa3",fontSize: 15,),
                              ),
                        Switch(
                          activeColor: renkler.sariRenk,
                          value: darkthememode,
                          onChanged: (bool value) {
                            setState(() {
                              readSetting.setDarkMode(value);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ///Koyu tema
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: 40,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: renkler.arkaRenk, // Set border color
                        width: 1.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: InkWell(
                      onTap: () {
                        if (isPassword && readSetting.Password != "null") {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 1),
                              pageBuilder: (context, animation, nextanim) =>
                                  const PasswordSplash(mode: "admin"),
                              reverseTransitionDuration:
                                  const Duration(milliseconds: 1),
                              transitionsBuilder:
                                  (context, animation, nexttanim, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 1),
                              pageBuilder: (context, animation, nextanim) =>
                                  const PasswordPage(),
                              reverseTransitionDuration:
                                  const Duration(milliseconds: 1),
                              transitionsBuilder:
                                  (context, animation, nexttanim, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            translation(context).loginPassword,
                            style: TextStyle(
                              fontFamily: "Nexa3",
                                fontSize: 15,
                                height: 1
                            ),
                          ),
                          const Spacer(),
                          isPassword
                              ? Text(
                                  translation(context).on,
                                  style: const TextStyle(fontFamily: "Nexa3",height: 1,fontSize: 15,),
                                )
                              : Text(
                                  translation(context).off,
                                  style: const TextStyle(fontFamily: "Nexa3",height: 1,fontSize: 15,),
                                ),
                          const Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: 40,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: renkler.arkaRenk, // Set border color
                        width: 1.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 1),
                            pageBuilder: (context, animation, nextanim) =>
                                const BackUp(),
                            reverseTransitionDuration:
                                const Duration(milliseconds: 1),
                            transitionsBuilder:
                                (context, animation, nexttanim, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            translation(context).backupStatus,
                            style: TextStyle(
                              fontFamily: "Nexa3",
                                fontSize: 15,
                                height: 1
                            ),
                          ),
                          const Spacer(),
                          isBackup
                              ? Text(
                            translation(context).on,
                            style: const TextStyle(fontFamily: "Nexa3",height: 1,fontSize: 15,),
                          )
                              : Text(
                            translation(context).off,
                            style: const TextStyle(fontFamily: "Nexa3",height: 1,fontSize: 15,),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: 40,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: renkler.arkaRenk, // Set border color
                        width: 1.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: InkWell(
                      onTap: () {
                        AppSettings.openAppSettings(
                            type: AppSettingsType.notification);
                      },
                      child: Row(
                        children: const [
                          Text(
                            "Bildirimler",
                            style: TextStyle(
                              fontFamily: "Nexa3",
                                fontSize: 15,
                                height: 1
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(11)),
                  child: Container(
                    height: 40,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: renkler.arkaRenk, // Set border color
                          width: 1.0),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          const Text(
                            "Varsayılan Para Birimi",
                            style: TextStyle(
                              fontFamily: "Nexa3",
                                fontSize: 15,
                                height: 1
                            ),
                          ),
                          const Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 30,
                              width: 80,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              color: renkler.koyuuRenk,
                              child: DropdownButton(
                                dropdownColor: renkler.koyuuRenk,
                                borderRadius: BorderRadius.circular(20),
                                value: Prefix,
                                elevation: 16,
                                style: TextStyle(color: renkler.sariRenk),
                                underline: Container(
                                  height: 2,
                                  color: renkler.koyuuRenk,
                                ),
                                onChanged: (newValue) {
                                  if (readSetting.Prefix != newValue) {
                                    readSetting.setPrefix(newValue!);
                                    currencyRiv.calculateAllSQLRealTime(); //Bütün kayıtları hocam değiştiriyor.
                                    readSetting.setisuseinsert();
                                  }
                                  print("");
                                },
                                items: moneyPrefix
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                    onTap: () {},
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: 40,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: renkler.arkaRenk, // Set border color
                        width: 1.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        Text(
                          translation(context).language,
                          style: TextStyle(
                            fontFamily: "Nexa3",
                              fontSize: 15,
                              height: 1
                          ),
                        ),
                        const Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 30,
                            width: 80,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            color: renkler.koyuuRenk,
                            child: DropdownButton(
                              dropdownColor: renkler.koyuuRenk,
                              borderRadius: BorderRadius.circular(20),
                              value: language,
                              elevation: 16,
                              style: TextStyle(color: renkler.sariRenk),
                              underline: Container(
                                height: 2,
                                color: renkler.koyuuRenk,
                              ),
                              onChanged: (newValue) {
                                if (newValue == "Türkçe") {
                                  /// database te Turkce yazılı olduğu için if koşulu kullandık.
                                  readSetting.setLanguage("Turkce");
                                } else {
                                  readSetting.setLanguage(newValue!);
                                }
                                readSetting.setisuseinsert();
                              },
                              items: dilDestegi.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                  onTap: () {},
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );

    /// Yedekleme durumu
    ///Dil seçeneği
  }
  /*
  Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(11)),
                    child: Container(
                      height: 40,
                      width: size.width,
                      color: renkler.arkaRenk,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    height: 40,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(10)
                      ),
                      border: Border.all(
                          color: renkler.arkaRenk, // Set border color
                          width: 1.0),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: const Duration(milliseconds: 1),
                              pageBuilder: (context, animation, nextanim) => const BackUp(),
                              reverseTransitionDuration: const Duration(milliseconds: 1),
                              transitionsBuilder: (context, animation, nexttanim, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Row(
                          children:  [
                            Text(
    translation(context).backupStatus,
    style: TextStyle(
    fontFamily: "Nexa3",
    ),
    ),
    const Spacer(),
   */

  /*


   */
/*
ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 80,
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                color: renkler.koyuuRenk,
                                child: DropdownButton(
                                  dropdownColor: renkler.koyuuRenk,
                                  borderRadius: BorderRadius.circular(20),
                                  value: Prefix,
                                  elevation: 16,
                                  style: TextStyle(color: renkler.sariRenk),
                                  underline: Container(
                                    height: 2,
                                    color: renkler.koyuuRenk,
                                  ),
                                  onChanged: (newValue) {
                                    if(readSetting.Prefix != newValue){
                                      readSetting.setPrefix(newValue!);
                                      currencyRiv.calculateAllSQLRealTime();//Bütün kayıtları hocam değiştiriyor.
                                      readSetting.setisuseinsert();
                                    }
                                    print("");
                                  },
                                  items: moneyPrefix.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                      onTap: () {
                                      },
                                    );
                                  }).toList(),
                            Icon(
                              Icons.arrow_forward_ios,
                            ),
                              isBackup  ? Text(translation(context).on, style: const TextStyle(fontFamily: "Nexa3"),)
                                : Text(translation(context).off, style: const TextStyle(fontFamily: "Nexa3"),),


 */
} /*
 Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    height: 40,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(10)
                      ),
                      border: Border.all(
                          color: renkler.arkaRenk, // Set border color
                          width: 1.0),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Text(
                            translation(context).currency,
                            style: TextStyle(
                              fontFamily: "Nexa3",
                            ),
                          ),
                          const Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 30,
                              width: 61,
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              color: renkler.koyuuRenk,
                              child: DropdownButton(
                                dropdownColor: renkler.koyuuRenk,
                                borderRadius: BorderRadius.circular(20),
                                value: dropdownshowitem,
                                elevation: 16,
                                style: TextStyle(color: renkler.sariRenk),
                                underline: Container(
                                  height: 2,
                                  color: renkler.koyuuRenk,
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    dropdownshowitem = newValue!;
                                  });
                                },
                                items: moneyPrefix
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),///Para Birimi
*/
