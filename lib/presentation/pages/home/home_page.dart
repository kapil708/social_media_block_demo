import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_block_demo/core/route/route_names.dart';
import 'package:social_media_block_demo/data/data_sources/local_data_source.dart';
import 'package:social_media_block_demo/injection_container.dart';

import '../../../core/enums/app_theme_mode.dart';
import '../../../core/enums/language.dart';
import '../../bloc/app/app_bloc.dart';

class HomePage extends StatelessWidget {
  final String id;
  final String userName;
  const HomePage({super.key, required this.id, required this.userName});

  @override
  Widget build(BuildContext context) {
    return HomeView(userName: userName, id: id);
  }
}

class HomeView extends StatelessWidget {
  final String id;
  final String userName;
  const HomeView({super.key, required this.id, required this.userName});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              await locator.get<LocalDataSource>().removeAuthToken();
              context.goNamed(RouteNames.login);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => context.goNamed(RouteNames.post),
              child: const Text("Go to post screen"),
            ),
            const SizedBox(height: 24),
            Text("Translation", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Text(
              l10n.onboarding,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: Language.values.length,
                  itemBuilder: (context, index) {
                    Language language = Language.values[index];

                    return ListTile(
                      leading: Image.asset(language.image, height: 32, width: 32),
                      title: Text(language.text),
                      trailing: language == state.selectedLanguage ? const Icon(Icons.check_circle_rounded) : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: language == state.selectedLanguage ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5) : BorderSide(color: Colors.grey[300]!),
                      ),
                      tileColor: language == state.selectedLanguage ? Theme.of(context).colorScheme.primary.withOpacity(0.05) : null,
                      onTap: () {
                        context.read<AppBloc>().add(ChangeLanguage(selectedLanguage: language));
                        //Future.delayed(const Duration(milliseconds: 300)).then((value) => Navigator.of(context).pop());
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16.0);
                  },
                );
              },
            ),
            const SizedBox(height: 24),
            Text("Theming", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: AppThemeMode.values.length,
                  itemBuilder: (context, index) {
                    AppThemeMode themeMode = AppThemeMode.values[index];

                    return ListTile(
                      leading: Icon(themeMode.iconData, size: 24),
                      title: Text(themeMode.name),
                      trailing: themeMode == state.selectedThemeMode ? const Icon(Icons.check_circle_rounded) : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: themeMode == state.selectedThemeMode ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5) : BorderSide(color: Colors.grey[300]!),
                      ),
                      tileColor: themeMode == state.selectedThemeMode ? Theme.of(context).colorScheme.primary.withOpacity(0.05) : null,
                      onTap: () {
                        context.read<AppBloc>().add(ChangeThemeMode(selectedThemeMode: themeMode));
                        //Future.delayed(const Duration(milliseconds: 300)).then((value) => Navigator.of(context).pop());
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16.0);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
