import 'package:e_islamic_quran/data/blocs/fetch_detail_surah/fetch_detail_surah_cubit.dart';
import 'package:e_islamic_quran/ui/screens/screens.dart';
import 'package:e_islamic_quran/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:e_islamic_quran/utils/typography.dart' as AppTypo;
import 'package:e_islamic_quran/utils/colors.dart' as AppColor;
import 'package:e_islamic_quran/utils/images.dart' as AppImage;
import 'package:e_islamic_quran/utils/extensions.dart' as AppExt;
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailSurahScreen extends StatefulWidget {
  const DetailSurahScreen({Key key, this.surahId, this.nameSurah}) : super(key: key);

  final int surahId;
  final String nameSurah;

  @override
  _DetailSurahScreenState createState() => _DetailSurahScreenState();
}

class _DetailSurahScreenState extends State<DetailSurahScreen> {
  FetchDetailSurahCubit _fetchDetailSurahCubit;

  @override
  void initState() {
    _fetchDetailSurahCubit = FetchDetailSurahCubit()
      ..fetchDetailSurah(id: widget.surahId);
    super.initState();
  }

  @override
  void dispose() {
    _fetchDetailSurahCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _fetchDetailSurahCubit,
        ),
      ],
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.nameSurah),
          ),
          body: BlocBuilder(
              cubit: _fetchDetailSurahCubit,
              builder: (context, fetchDetailSurahState) => fetchDetailSurahState
                      is FetchDetailSurahLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : fetchDetailSurahState is FetchDetailSurahFailure
                      ? Center(child: Text(fetchDetailSurahState.message))
                      : fetchDetailSurahState is FetchDetailSurahSuccess
                          ? ListView(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: _screenWidth * 5 / 100),
                                  child: BasicCard(
                                    height: 150,
                                      radius: 4,
                                      child: Stack(
                                        children: [
                                          Image(
                                              image: AssetImage(
                                                  AppImage.img_detail_surah),
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, object, stack) =>
                                                      Image.asset(
                                                        AppImage.img_error,
                                                        width: double.infinity,
                                                      ),
                                              frameBuilder: (context, child,
                                                  frame, wasSynchronouslyLoaded) {
                                                if (wasSynchronouslyLoaded) {
                                                  return child;
                                                } else {
                                                  return AnimatedSwitcher(
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    child: frame != null
                                                        ? child
                                                        : Container(
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: Colors
                                                                  .grey[200],
                                                            ),
                                                          ),
                                                  );
                                                }
                                              }),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(fetchDetailSurahState.detailSurah.nameSurah.transliteration.indo,style: AppTypo.body1.copyWith(color: AppColor.textPrimaryInverted)),
                                              Text(fetchDetailSurahState.detailSurah.nameSurah.short,style: AppTypo.body1.copyWith(color: AppColor.textPrimaryInverted)),
                                              Text(fetchDetailSurahState.detailSurah.nameSurah.translation.indo,style: AppTypo.body1.copyWith(color: AppColor.textPrimaryInverted)),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: _screenWidth * 5 / 100),
                                  child: BasicCard(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text("Surah ke"),
                                                  Text(fetchDetailSurahState.detailSurah.number.toString())
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text("Jumlah Ayat"),
                                                  Text(fetchDetailSurahState.detailSurah.numberOfVerses.toString())
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text("Jenis Surah"),
                                                  Text(fetchDetailSurahState.detailSurah.revelation.indo)
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Text("Tafsir"),
                                          Text(fetchDetailSurahState.detailSurah.tafsir.indo)
                                        ],
                                      ),
                                    )
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: _screenWidth * 5 / 100),
                                  child: RoundedButton.contained(
                                    label: "Baca Surah", 
                                    // isSmall: true,
                                    isUpperCase: false,
                                    onPressed: (){
                                     AppExt.pushScreen(context, DetailAyatScreen(numberSurah: fetchDetailSurahState.detailSurah.number, numberAyat: 1)); 
                                    }
                                  ),
                                )
                              ],
                            )
                          : SizedBox.shrink())),
    );
  }
}
