import 'package:audioplayers/audioplayers.dart';
import 'package:e_islamic_quran/data/blocs/fetch_detail_ayat/fetch_detail_ayat_cubit.dart';
import 'package:e_islamic_quran/data/models/ayat.dart';
import 'package:e_islamic_quran/ui/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_islamic_quran/utils/typography.dart' as AppTypo;
import 'package:e_islamic_quran/utils/colors.dart' as AppColor;
import 'package:e_islamic_quran/utils/extensions.dart' as AppExt;

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

  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState playerState = PlayerState.PAUSED;

  FetchDetailAyatCubit _fetchDetailAyatCubit;

  @override
  void initState() {
    _fetchDetailAyatCubit = FetchDetailAyatCubit()
      ..fetchDetailAyat(
          surahNumber: widget.numberSurah, ayatNumber: widget.numberAyat);
    audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      setState(() {
        playerState = s;        
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _fetchDetailAyatCubit.close();
    audioPlayer.release();
    audioPlayer.dispose();  
    super.dispose();
  }

  playAyat(String url) async{
    await audioPlayer.play(url);
    AppExt.popScreen(context);
  }

  stopAyat() async{
    await audioPlayer.stop();
    AppExt.popScreen(context);
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
                                  children: [
                                    Expanded(
                                        child: Visibility(
                                      visible:
                                          detailAyatState.data.number.inSurah ==
                                                  detailAyatState
                                                      .data.surah.numberOfVerses
                                              ? false
                                              : true,
                                      child: RoundedButton.contained(
                                          label: "Next",
                                          isUpperCase: false,
                                          isSmall: true,
                                          onPressed: () {
                                            _fetchDetailAyatCubit
                                              ..fetchDetailAyat(
                                                  surahNumber:
                                                      widget.numberSurah,
                                                  ayatNumber: detailAyatState
                                                          .data.number.inSurah +
                                                      1);
                                          }),
                                    )),
                                    SizedBox(
                                      width:
                                          detailAyatState.data.number.inSurah ==
                                                  detailAyatState
                                                      .data.surah.numberOfVerses
                                              ? 0
                                              : 25,
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: RoundedButton.contained(
                                            label: "Menu Ayat",
                                            isUpperCase: false,
                                            onPressed: () {
                                              menuAyatBottomSheet(
                                                  context, _screenWidth,detailAyatState.data);
                                            })),
                                    SizedBox(
                                      width:
                                          detailAyatState.data.number.inSurah ==
                                                  1
                                              ? 0
                                              : 25,
                                    ),
                                    Visibility(
                                      visible:
                                          detailAyatState.data.number.inSurah ==
                                                  1
                                              ? false
                                              : true,
                                      child: Expanded(
                                          child: RoundedButton.contained(
                                              label: "Prev",
                                              isUpperCase: false,
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
                                              })),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          )
                        : SizedBox.shrink()),
      ),
    );
  }

  Future menuAyatBottomSheet(BuildContext context, double _screenWidth, Ayat ayat) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        )),
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext ctx,StateSetter setState ){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Center(
                  child: Container(
                    width: 150,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColor.textSecondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )),
                Expanded(
                    flex: 5,
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                          horizontal: _screenWidth * (5 / 100)),
                      children: [
                        InkWell(
                          onTap: (){
                            playerState == PlayerState.PLAYING ? 
                            stopAyat() : playAyat(ayat.audio.primary) ;
                          } ,
                          child: Text(playerState == PlayerState.PLAYING ? "Stop"  : "Play")
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Tandai sebagai terakhir dibaca"),
                      ],
                    )),
              ],
            );
          });

        });
  }
}
