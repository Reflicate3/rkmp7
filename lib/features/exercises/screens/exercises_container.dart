import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../data/exercises_seed.dart';
import 'exercises_list_screen.dart';
import 'add_exercise_screen.dart';
import 'exercise_detail_screen.dart';
import 'favorites_screen.dart';
import 'about_screen.dart';
import 'gallery_screen.dart';

class ExercisesContainer extends StatefulWidget {
  const ExercisesContainer({super.key});

  @override
  State<ExercisesContainer> createState() => _ExercisesContainerState();
}

class _ExercisesContainerState extends State<ExercisesContainer> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  // Данные
  final List<Exercise> _all = [...seedExercises];

  // Фильтры/поиск
  String _query = '';
  Set<Difficulty> _diff = {};
  Set<Equipment> _equip = {};
  MuscleGroup? _muscle;

  // UI
  bool _filtersExpanded = true;

  String get _q => _query.trim().toLowerCase();

  List<Exercise> get _visible {
    return _all.where((e) {
      final byQuery = _q.isEmpty ||
          e.title.toLowerCase().contains(_q) ||
          e.description.toLowerCase().contains(_q);
      final byDiff = _diff.isEmpty || _diff.contains(e.difficulty);
      final byEquip = _equip.isEmpty || _equip.contains(e.equipment);
      final byMuscle = _muscle == null || e.muscle == _muscle;
      return byQuery && byDiff && byEquip && byMuscle;
    }).toList()
      ..sort((a, b) => a.title.compareTo(b.title));
  }

  // Навигация
  void _openAdd() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => AddExerciseScreen(onSave: _createExercise),
    ));
  }

  void _openDetail(String id) {
    final ex = _all.firstWhere((e) => e.id == id);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ExerciseDetailScreen(
        item: ex,
        onToggleFavorite: () => _toggleFavorite(id),
      ),
    ));
  }

  void _openFavorites() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => FavoritesScreen(
        items: _all.where((e) => e.isFavorite).toList()
          ..sort((a, b) => a.title.compareTo(b.title)),
        onDelete: _delete,
        onToggleFavorite: _toggleFavorite,
        onOpenDetail: _openDetail,
      ),
    ));
  }

  void _openAbout() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AboutScreen()),
    );
  }

  void _openGallery() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const GalleryScreen()),
    );
  }

  // Бизнес-операции
  void _createExercise({
    required String title,
    required String description,
    required MuscleGroup muscle,
    required Equipment equipment,
    required Difficulty difficulty,
  }) {
    final ex = Exercise(
      id: nextId(),
      title: title,
      description: description,
      muscle: muscle,
      equipment: equipment,
      difficulty: difficulty,
      createdAt: DateTime.now(),
    );
    setState(() => _all.add(ex));
    _showSnack('Упражнение «$title» добавлено');
  }

  void _toggleFavorite(String id) {
    final i = _all.indexWhere((e) => e.id == id);
    if (i == -1) return;
    final ex = _all[i];
    setState(() => _all[i] = ex.copyWith(isFavorite: !ex.isFavorite));
  }

  void _delete(String id) {
    final i = _all.indexWhere((e) => e.id == id);
    if (i == -1) return;
    final removed = _all[i];
    setState(() => _all.removeAt(i));
    _scaffoldMessengerKey.currentState?.clearSnackBars();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text('Удалено: ${removed.title}'),
        action: SnackBarAction(
          label: 'ОТМЕНИТЬ',
          onPressed: () => setState(() => _all.insert(i, removed)),
        ),
      ),
    );
  }

  void _showSnack(String msg) {
    _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: ExercisesListScreen(
        items: _visible,
        query: _query,
        selectedDifficulties: _diff,
        selectedEquipment: _equip,
        selectedMuscle: _muscle,
        onSearch: (v) => setState(() => _query = v),
        onToggleDifficulty: (d) => setState(() => _diff.toggle(d)),
        onToggleEquipment: (e) => setState(() => _equip.toggle(e)),
        onSelectMuscle: (m) => setState(() => _muscle = m),
        onAddTap: _openAdd,
        onDelete: _delete,
        onToggleFavorite: _toggleFavorite,
        onOpenDetail: _openDetail,
        filtersExpanded: _filtersExpanded,
        onToggleFilters: () => setState(() => _filtersExpanded = !_filtersExpanded),
        onOpenFavorites: _openFavorites,
        onOpenAbout: _openAbout,

        onOpenGallery: _openGallery,

      ),
    );
  }
}

extension _ToggleSet<T> on Set<T> {
  void toggle(T v) => contains(v) ? remove(v) : add(v);
}
