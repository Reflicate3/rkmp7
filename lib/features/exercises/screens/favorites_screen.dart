import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../widgets/exercise_card.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Exercise> items;
  final ValueChanged<String> onDelete;
  final ValueChanged<String> onToggleFavorite;
  final ValueChanged<String> onOpenDetail;

  const FavoritesScreen({
    super.key,
    required this.items,
    required this.onDelete,
    required this.onToggleFavorite,
    required this.onOpenDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Избранные упражнения')),
      body: items.isEmpty
          ? const _EmptyFavs()
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, i) {
          final ex = items[i];
          return Dismissible(
            key: ValueKey('fav_${ex.id}'),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) => onDelete(ex.id),
            child: ExerciseCard(
              item: ex,
              onToggleFavorite: () => onToggleFavorite(ex.id),
              onTap: () => onOpenDetail(ex.id),
            ),
          );
        },
      ),
    );
  }
}

class _EmptyFavs extends StatelessWidget {
  const _EmptyFavs();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.favorite_border, size: 56),
            const SizedBox(height: 8),
            Text('Пока пусто',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            const Text('Добавьте упражнения в избранное со списка.'),
          ],
        ),
      ),
    );
  }
}
