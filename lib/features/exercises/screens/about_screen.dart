import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('О программе')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Справочник физических упражнений', style: textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              'Учебное приложение для демонстрации бизнес-логики: '
                  'поиск, фильтрация, добавление, удаление, избранное и просмотр деталей. '
                  'Состояние — примитивный setState в контейнере.',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Функции'),
              subtitle: const Text(
                '• Поиск и фильтры по мышцам/сложности/оборудованию\n'
                    '• Добавление своих упражнений\n'
                    '• Свайп-удаление с Undo\n'
                    '• Избранное\n'
                    '• Экран деталей с техниками выполнения',
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Технологии'),
              subtitle: const Text('Flutter (Material 3), архитектура feature-first, setState'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Практическая №5'),
              subtitle: const Text(
                  'Обработка пользовательского ввода, работа с данными, вывод информации, '
                      'базовые виджеты и примитивный контроль состояния.'),
            ),
          ],
        ),
      ),
    );
  }
}
