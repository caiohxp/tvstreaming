import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_modulo_4/bloc/Serie_Bloc.dart';
import 'package:projeto_modulo_4/model/Multi_model.dart';
import 'package:projeto_modulo_4/pages/SerieDetailsPage.dart';
import 'package:projeto_modulo_4/widgets/NewMoviesWidget.dart';
import 'package:projeto_modulo_4/widgets/SerieItem.dart';

class NewSeriesWidget extends HookWidget {
  final List<MultiModel> series;

  NewSeriesWidget({required this.series});

  @override
  Widget build(BuildContext context) {
    final _scrollController = useScrollController();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "Séries recentes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 370,
          child: RawScrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: series.length,
              itemBuilder: (context, index) {
                return SerieItem(serie: series[index]);
              },
            ),
            thumbColor: Color(0xFF00A470),
            radius: Radius.circular(8.0),
            thickness: 8.0,
          ),
        ),
      ],
    );
  }
}
