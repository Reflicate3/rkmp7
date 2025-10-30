import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  // 5 прямых HTTPS-ссылок c static.photos (тематика — sport)
  static const urls = <String>[
    'https://static.photos/sport/640x360/139',
    'https://static.photos/sport/640x360/140',
    'https://static.photos/sport/640x360/141',
    'https://static.photos/sport/640x360/142',
    'https://static.photos/sport/640x360/143',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Галерея')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: urls.length,
          itemBuilder: (context, index) {
            final url = urls[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 120),
                placeholderFadeInDuration: Duration.zero,
                progressIndicatorBuilder: (_, __, ___) => Container(
                  color: Colors.black12,
                  alignment: Alignment.center,
                  child: const SizedBox(
                    width: 24, height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (_, __, ___) => GestureDetector(
                  onTap: () => (context as Element).markNeedsBuild(), // тап = ретрай
                  child: Container(
                    color: Colors.black12,
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image, size: 48),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
