import 'package:e_islamic_quran/data/blocs/fetch_all_surah/fetch_all_surah_cubit.dart';
import 'package:e_islamic_quran/data/models/models.dart';
import 'package:e_islamic_quran/ui/screens/detail_surah_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:e_islamic_quran/utils/typography.dart' as AppTypo;
import 'package:e_islamic_quran/utils/colors.dart' as AppColor;
import 'package:e_islamic_quran/utils/images.dart' as AppImage;
import 'package:e_islamic_quran/utils/extensions.dart' as AppExt;

class ListSurahScreen extends StatefulWidget {
  const ListSurahScreen({Key key}) : super(key: key);

  @override
  _ListSurahScreenState createState() => _ListSurahScreenState();
}

class _ListSurahScreenState extends State<ListSurahScreen> {
  FetchAllSurahCubit _fetchAllSurahCubit;

  @override
  void initState() {
    _fetchAllSurahCubit = FetchAllSurahCubit()..fetchAllSurah();
    super.initState();
  }

  @override
  void dispose() {
    _fetchAllSurahCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => _fetchAllSurahCubit,
          ),
        ],
        child: Scaffold(
          appBar: AppBar(),
          body: BlocBuilder(
              cubit: _fetchAllSurahCubit,
              builder: (ctx, fetchSurahState) {
                return fetchSurahState is FetchAllSurahLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : fetchSurahState is FetchAllSurahFailure
                        ? Center(child: Text(fetchSurahState.message))
                        : fetchSurahState is FetchAllSurahSuccess
                            ? ListView.separated(
                                itemCount: fetchSurahState.surah.length,
                                separatorBuilder: (ctx, idx) {
                                  return Divider(
                                      thickness: 1,
                                      indent: 3,
                                      endIndent: 4,
                                      color: Colors.grey);
                                },
                                itemBuilder: (ctx, idx) {
                                  Surah surah = fetchSurahState.surah[idx];
                                  return ListSurahItem(
                                    surah: surah,
                                  );
                                },
                              )
                            : SizedBox.shrink();
              }),
        ));
  }
}

class ListSurahItem extends StatelessWidget {
  const ListSurahItem({Key key, this.surah}) : super(key: key);

  final Surah surah;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        AppExt.pushScreen(context, DetailSurahScreen(surahId: surah.number,nameSurah: surah.nameSurah.transliteration.indo,));
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(surah.nameSurah.transliteration.indo),
                Text(surah.nameSurah.short),
                Text(surah.nameSurah.translation.indo)
              ],
            ),
            Icon(FlutterIcons.chevron_right_mco)

          ],
        ),
      ),
    );
  }
}
