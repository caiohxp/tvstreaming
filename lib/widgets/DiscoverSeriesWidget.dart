import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tvabertaflix/model/Multi_model.dart';
import 'package:tvabertaflix/pages/SerieDetailsPage.dart';

class DiscoverSeriesWidget extends HookWidget {
  final List<MultiModel> series;

  DiscoverSeriesWidget({required this.series});

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: series.length,
      itemBuilder: (context, index) {
        final item = series[index];
        final posterPath = item.posterPath != null
            ? '${item.posterPath}'
            : 'https://via.placeholder.com/150';
        final title = item.title ?? item.name ?? 'No title';
        final rating = item.voteAverage!.toStringAsFixed(1);
        final year = item.firstAirDate != null
            ? DateTime.parse(item.firstAirDate!).year.toString()
            : item.releaseDate != null
                ? DateTime.parse(item.releaseDate!).year.toString()
                : 'Unknown year';
        final overview = item.overview ?? 'No overview available';
        return MouseRegion(
          onEnter: (_) => isHovered.value = true,
          onExit: (_) => isHovered.value = false,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SerieDetailsPage(
                    serie: item,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10, left: 50, right: 50),
              child: Row(
                children: [
                  Image.network(
                    posterPath,
                    width: 125,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Text(
                              rating,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          year,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          width: 500,
                          child: Text(
                            overview,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
