import 'package:flutter/material.dart';
import '../models/exercise.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final Exercise item;
  final VoidCallback onToggleFavorite;

  const ExerciseDetailScreen({
    super.key,
    required this.item,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        actions: [
          IconButton(
            onPressed: onToggleFavorite,
            icon: Icon(item.isFavorite ? Icons.favorite : Icons.favorite_border),
            tooltip: item.isFavorite ? 'Убрать из избранного' : 'В избранное',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(spacing: 12, runSpacing: -8, children: [
              Chip(
                label: Text('Мышцы: ${muscleLabel(item.muscle)}'),
                avatar: const Icon(Icons.fitness_center),
              ),
              Chip(
                label: Text('Оборудование: ${equipmentLabel(item.equipment)}'),
                avatar: const Icon(Icons.handyman),
              ),
              Chip(
                label: Text('Сложность: ${difficultyLabel(item.difficulty)}'),
                avatar: const Icon(Icons.trending_up),
              ),
            ]),
            const SizedBox(height: 16),
            Text('Техника выполнения', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(item.description),
            const Spacer(),

          ],
        ),
      ),
    );
  }
}

String _formatDate(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
