import 'package:e_islamic_quran/data/blocs/fetch_detail_ayat/fetch_detail_ayat_cubit.dart';
import 'package:e_islamic_quran/ui/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_islamic_quran/utils/typography.dart' as AppTypo;

class DetailAyatScreen extends StatefulWidget {
  const DetailAyatScreen({ Key key, @required this.numberSurah, @required this.numberAyat }) : super(key: key);

  final int numberSurah;
  final int numberAyat;

  @override
  _DetailAyatScreenState createState() => _DetailAyatScreenState();
}

class _DetailAyatScreenState extends State<DetailAyatScreen> {

  FetchDetailAyatCubit _fetchDetailAyatCubit;

  @override
    void initState() {
      _fetchDetailAyatCubit = FetchDetailAyatCubit()..fetchDetailAyat(surahNumber: widget.numberSurah, ayatNumber: widget.numberAyat);
      super.initState();
  }

  @override
    void dispose() {
      _fetchDetailAyatCubit.close();
      super.dispose();
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
          builder: (ctx,detailAyatState) =>
          detailAyatState is FetchDetailAyatLoading ?
          Center(child: CircularProgressIndicator()) :
          detailAyatState is FetchDetailAyatFailure ?
          Center(child: Text(detailAyatState.message),)
          :
          detailAyatState is FetchDetailAyatSuccess ?
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _screenWidth * (5/100)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text("QS. ${detailAyatState.data.surah.nameSurah.transliteration.indo}")
                ),
                Expanded(
                  flex: 8,
                  child: SingleChildScrollView(
                    child: Container(
                      color: Colors.amber,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(detailAyatState.data.text.arab,style: AppTypo.body1,textAlign: TextAlign.right,),
                          Text(detailAyatState.data.text.transliteration.en,style: AppTypo.body1,textAlign: TextAlign.left,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(detailAyatState.data.translation.indo))
                        ],
                      ),
                    ),
                  )
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Visibility(
                          visible: detailAyatState.data.number.inSurah == detailAyatState.data.surah.numberOfVerses ? false : true,
                          child: RoundedButton.contained(
                            label: "Next", 
                            isUpperCase: false,
                            isSmall: true,
                            onPressed: (){
                              _fetchDetailAyatCubit..fetchDetailAyat(surahNumber: widget.numberSurah, ayatNumber: detailAyatState.data.number.inSurah + 1);
                            }
                          ),
                        )
                      ),
                      SizedBox(width: detailAyatState.data.number.inSurah == detailAyatState.data.surah.numberOfVerses ? 0 : 25,),
                      Expanded(
                        flex: 2,
                        child: RoundedButton.contained(
                          label: "Menu Ayat", 
                          isUpperCase: false,
                          onPressed: (){
                            //
                          }
                        )
                      ),
                      SizedBox(width: detailAyatState.data.number.inSurah == 1 ? 0 : 25,),
                      Visibility(
                        visible: detailAyatState.data.number.inSurah == 1 ? false : true,
                        child: Expanded(
                          child: RoundedButton.contained(
                            label: "Prev", 
                            isUpperCase: false,
                            onPressed: (){
                              _fetchDetailAyatCubit..fetchDetailAyat(surahNumber: widget.numberSurah, ayatNumber: detailAyatState.data.number.inSurah - 1);
                            }
                          )
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ) : SizedBox.shrink()
        ),
      ),
    );
  }
}