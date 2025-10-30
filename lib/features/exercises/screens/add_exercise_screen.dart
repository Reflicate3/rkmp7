import 'package:flutter/material.dart';
import '../models/exercise.dart';

class AddExerciseScreen extends StatefulWidget {
  final void Function({
  required String title,
  required String description,
  required MuscleGroup muscle,
  required Equipment equipment,
  required Difficulty difficulty,
  }) onSave;

  const AddExerciseScreen({super.key, required this.onSave});

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  MuscleGroup _muscle = MuscleGroup.fullBody;
  Equipment _equipment = Equipment.bodyweight;
  Difficulty _difficulty = Difficulty.beginner;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;
    widget.onSave(
      title: _titleCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      muscle: _muscle,
      equipment: _equipment,
      difficulty: _difficulty,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Новое упражнение')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: 'Название'),
                textInputAction: TextInputAction.next,
                validator: (v) {
                  final t = v?.trim() ?? '';
                  if (t.length < 2) return 'Минимум 2 символа';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<MuscleGroup>(
                value: _muscle,
                decoration: const InputDecoration(labelText: 'Группа мышц'),
                items: MuscleGroup.values
                    .map((m) => DropdownMenuItem(
                  value: m,
                  child: Text(muscleLabel(m)),
                ))
                    .toList(),
                onChanged: (m) => setState(() => _muscle = m ?? _muscle),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Equipment>(
                value: _equipment,
                decoration: const InputDecoration(labelText: 'Оборудование'),
                items: Equipment.values
                    .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(equipmentLabel(e)),
                ))
                    .toList(),
                onChanged: (e) => setState(() => _equipment = e ?? _equipment),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Difficulty>(
                value: _difficulty,
                decoration: const InputDecoration(labelText: 'Сложность'),
                items: Difficulty.values
                    .map((d) => DropdownMenuItem(
                  value: d,
                  child: Text(difficultyLabel(d)),
                ))
                    .toList(),
                onChanged: (d) => setState(() => _difficulty = d ?? _difficulty),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descCtrl,
                minLines: 3,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Техника/подсказки',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.save),
                  label: const Text('Сохранить'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
