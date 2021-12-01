import 'package:audioplayers/audioplayers.dart';
import 'package:e_islamic_quran/data/blocs/fetch_detail_ayat/fetch_detail_ayat_cubit.dart';
import 'package:e_islamic_quran/data/models/ayat.dart';
import 'package:e_islamic_quran/ui/widgets/alert_bottom_sheet.dart';
import 'package:e_islamic_quran/ui/widgets/edit_text.dart';
import 'package:e_islamic_quran/ui/widgets/rounded_button.dart';
import 'package:e_islamic_quran/utils/form_validations.dart';
import 'package:e_islamic_quran/utils/get_storage_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:e_islamic_quran/utils/typography.dart' as AppTypo;
import 'package:e_islamic_quran/utils/colors.dart' as AppColor;
import 'package:e_islamic_quran/utils/extensions.dart' as AppExt;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get_storage/get_storage.dart';

class DetailAyatScreen extends StatefulWidget {
  const DetailAyatScreen(
      {Key key, @required this.numberSurah, @required this.numberAyat})
      : super(key: key);

  final int numberSurah;
  final int numberAyat;

  @override
  _DetailAyatScreenState createState() => _DetailAyatScreenState();
}

class _DetailAyatScreenState extends State<DetailAyatScreen> {
  FormValidations formValidations = new FormValidations();
  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState playerState = PlayerState.PAUSED;

  FetchDetailAyatCubit _fetchDetailAyatCubit;

  TextEditingController ayatCtrl = TextEditingController();

  Map<String, dynamic> dataAyat;
  bool showAyatCtrl = false;

  // final box = GetStorage();

  @override
  void initState() {
    _fetchDetailAyatCubit = FetchDetailAyatCubit()
      ..fetchDetailAyat(
          surahNumber: widget.numberSurah, ayatNumber: widget.numberAyat);

    if (GetStorageExt().getStorageRead('keyDataAyat') != null) {
      print(GetStorageExt().getStorageRead('keyDataAyat').toString());
      dataAyat = GetStorageExt().getStorageRead('keyDataAyat');
    } else {
      print("KOSONG DATA");
    }

    audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      if (mounted) {
        setState(() {
          playerState = s;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _fetchDetailAyatCubit.close();
    ayatCtrl.dispose();
    // audioPlayer.release();
    audioPlayer.dispose();
  }

  playAyat(String url) async {
    await audioPlayer.play(url);
  }

  stopAyat() async {
    await audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _fetchDetailAyatCubit,
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: BlocBuilder(
            cubit: _fetchDetailAyatCubit,
            builder: (ctx, detailAyatState) => detailAyatState
                    is FetchDetailAyatLoading
                ? Center(child: CircularProgressIndicator())
                : detailAyatState is FetchDetailAyatFailure
                    ? Center(
                        child: Text(detailAyatState.message),
                      )
                    : detailAyatState is FetchDetailAyatSuccess
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: _screenWidth * (5 / 100)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "Juz - ${detailAyatState.data.meta.juz}"),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            "${detailAyatState.data.surah.nameSurah.transliteration.indo}"),
                                        Text(
                                            "${detailAyatState.data.surah.nameSurah.translation.indo}"),
                                      ],
                                    ),
                                    Text(
                                        "Ayat - ${detailAyatState.data.number.inSurah}"),
                                  ],
                                )),
                                Expanded(
                                    flex: 8,
                                    child: SingleChildScrollView(
                                      child: Container(
                                        color: Colors.amber,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              detailAyatState.data.text.arab,
                                              style: AppTypo.body1,
                                              textAlign: TextAlign.right,
                                            ),
                                            Text(
                                              detailAyatState
                                                  .data.text.transliteration.en,
                                              style: AppTypo.body1,
                                              textAlign: TextAlign.left,
                                            ),
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(detailAyatState
                                                    .data.translation.indo))
                                          ],
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    detailAyatState.data.number.inSurah ==
                                            detailAyatState
                                                .data.surah.numberOfVerses
                                        ? SizedBox()
                                        : Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                _fetchDetailAyatCubit
                                                  ..fetchDetailAyat(
                                                      surahNumber:
                                                          widget.numberSurah,
                                                      ayatNumber:
                                                          detailAyatState
                                                                  .data
                                                                  .number
                                                                  .inSurah +
                                                              1);
                                                // dataAyat = GetStorageExt().getStorageRead("keyDataAyat");
                                              },
                                              child: Icon(FlutterIcons.left_ant,
                                                  size: 30,
                                                  color: Colors.white),
                                              style: ElevatedButton.styleFrom(
                                                shape: CircleBorder(),
                                                fixedSize: Size(80, 80),
                                                primary: AppColor
                                                    .primaryApp, // <-- Button color
                                                onPrimary: AppColor
                                                    .primaryAppDark, // <-- Splash color
                                              ),
                                            ),
                                          ),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          playerState == PlayerState.PLAYING
                                              ? stopAyat()
                                              : playAyat(detailAyatState
                                                  .data.audio.primary);
                                        },
                                        child: Icon(
                                            playerState == PlayerState.PLAYING
                                                ? FlutterIcons.stop_mco
                                                : FlutterIcons.play_mco,
                                            size: 30,
                                            color: Colors.white),
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          fixedSize: Size(80, 80),
                                          primary: AppColor
                                              .primaryApp, // <-- Button color
                                          onPrimary: AppColor
                                              .primaryAppDark, // <-- Splash color
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          menuAyatBottomSheet(
                                              context,
                                              _screenWidth,
                                              detailAyatState.data);
                                        },
                                        child: Icon(FlutterIcons.menu_ent,
                                            size: 30, color: Colors.white),
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          fixedSize: Size(80, 80),
                                          primary: AppColor
                                              .primaryApp, // <-- Button color
                                          onPrimary: AppColor
                                              .primaryAppDark, // <-- Splash color
                                        ),
                                      ),
                                    ),
                                    detailAyatState.data.number.inSurah == 1
                                        ? SizedBox()
                                        : Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                _fetchDetailAyatCubit
                                                  ..fetchDetailAyat(
                                                      surahNumber:
                                                          widget.numberSurah,
                                                      ayatNumber:
                                                          detailAyatState
                                                                  .data
                                                                  .number
                                                                  .inSurah -
                                                              1);
                                                // dataAyat = GetStorageExt().getStorageRead("keyDataAyat");
                                              },
                                              child: Icon(
                                                  FlutterIcons.right_ant,
                                                  size: 30,
                                                  color: Colors.white),
                                              style: ElevatedButton.styleFrom(
                                                shape: CircleBorder(),
                                                fixedSize: Size(80, 80),
                                                primary: AppColor
                                                    .primaryApp, // <-- Button color
                                                onPrimary: AppColor
                                                    .primaryAppDark, // <-- Splash color
                                              ),
                                            ),
                                          )
                                  ],
                                )),
                              ],
                            ),
                          )
                        : SizedBox.shrink()),
      ),
    );
  }

  Future menuAyatBottomSheet(
      BuildContext context, double _screenWidth, Ayat ayat) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        )),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext ctx, StateSetter setState) {
            return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Stack(
                  children: [
                    ListView(
                      padding: EdgeInsets.only(
                          left: _screenWidth * (5 / 100),
                          right: _screenWidth * (5 / 100),
                          top: 60),
                      children: [
                        InkWell(
                          onTap: () {
                            GetStorageExt().saveLastRead({
                              'nameSurah':
                                  ayat.surah.nameSurah.transliteration.indo,
                              'numberSurah': ayat.surah.number,
                              'ayat': ayat.number.inSurah,
                              'juz': ayat.meta.juz
                            });
                            dataAyat =
                                GetStorageExt().getStorageRead("keyDataAyat");
                            AppExt.popScreen(context);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Tandai sebagai terakhir dibaca"),
                              dataAyat == null
                                  ? Text("Terakhir dibaca : -")
                                  : Text(
                                      "Terakhir dibaca : ${dataAyat['nameSurah']} - ayat ${dataAyat['ayat']}"),
                            ],
                          ),
                        ),
                        Divider(
                            thickness: 1,
                            indent: 3,
                            endIndent: 4,
                            color: Colors.grey),
                        InkWell(
                            onTap: () {
                              setState(() {
                                showAyatCtrl =
                                    showAyatCtrl != true ? true : false;
                              });
                            },
                            child: Text("Menuju atau loncat ke ayat")),
                        showAyatCtrl == true
                            ? EditText(
                                hintText: "Masukkan ayat",
                                keyboardType: TextInputType.number,
                                controller: ayatCtrl,
                                validator: formValidations.ayatInput,
                                autoValidateMode: AutovalidateMode.onUserInteraction,
                                onFieldSubmitted: (value) {
                                  AppExt.popScreen(context);
                                  if (int.parse(value) > ayat.surah.numberOfVerses){
                                    AlertBottomSheet.show(context,
                                    title: "Pencarian gagal",
                                    description: "Ayat tidak ditemukan",
                                    icon: Boxicons.bx_x_circle,
                                      color: AppColor.red,
);  
                                  } else{
                                    _fetchDetailAyatCubit
                                    ..fetchDetailAyat(
                                        surahNumber: widget.numberSurah,
                                        ayatNumber: int.parse(value));
                                  }
                                    
                                  
                                  
                                  
                                },
                              )
                            : SizedBox()
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          // horizontal: _screenWidth * (25 / 100), 
                          vertical: 20),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15))
                      ),
                      child: Center(
                        child: Container(
                          width: _screenWidth * (25 / 100),
                          decoration: BoxDecoration(
                            color: AppColor.textSecondary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Expanded(
                //         child: Center(
                //       child: Container(
                //         width: 150,
                //         height: 10,
                //         decoration: BoxDecoration(
                //           color: AppColor.textSecondary,
                //           borderRadius: BorderRadius.circular(20),
                //         ),
                //       ),
                //     )),
                //     Expanded(
                //         flex: 5,
                //         child: ListView(
                //           padding: EdgeInsets.symmetric(
                //               horizontal: _screenWidth * (5 / 100)),
                //           children: [
                //             InkWell(
                //               onTap: () {
                //                 GetStorageExt().saveLastRead({
                //                   'nameSurah':
                //                       ayat.surah.nameSurah.transliteration.indo,
                //                   'numberSurah': ayat.surah.number,
                //                   'ayat': ayat.number.inSurah,
                //                   'juz': ayat.meta.juz
                //                 });
                //                 dataAyat =
                //                     GetStorageExt().getStorageRead("keyDataAyat");
                //                 AppExt.popScreen(context);
                //               },
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text("Tandai sebagai terakhir dibaca"),
                //                   dataAyat == null
                //                       ? Text("Terakhir dibaca : -")
                //                       : Text(
                //                           "Terakhir dibaca : ${dataAyat['nameSurah']} - ayat ${dataAyat['ayat']}"),
                //                 ],
                //               ),
                //             ),
                //             Divider(
                //                 thickness: 1,
                //                 indent: 3,
                //                 endIndent: 4,
                //                 color: Colors.grey),
                //             InkWell(
                //                 onTap: () {
                //                   setState(() {
                //                     showAyatCtrl = showAyatCtrl != true ? true : false;
                //                   });
                //                 },
                //                 child: Text("Menuju atau loncat ke ayat")),
                //             showAyatCtrl == true ?
                //             EditText(hintText: "Masukkan ayat") : SizedBox()
                //           ],
                //         )),
                //   ],
                // ),
                );
          });
        });
  }
}
