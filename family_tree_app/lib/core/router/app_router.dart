// lib/core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/export_import/presentation/screens/export_import_screen.dart';
import '../../features/member/presentation/screens/add_edit_member_screen.dart';
import '../../features/member/presentation/screens/member_list_screen.dart';
import '../../features/member/presentation/screens/member_profile_screen.dart';
import '../../features/relationship/presentation/screens/add_relationship_screen.dart';
import '../../features/search/presentation/screens/search_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/tree/presentation/screens/home_screen.dart';
import '../../features/visualization/presentation/screens/tree_visualization_screen.dart';
import '../../shared/widgets/main_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    routes: [
      // ── Shell: Bottom Nav ────────────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/members',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MemberListScreen(),
            ),
          ),
          GoRoute(
            path: '/data',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ExportImportScreen(),
            ),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsScreen(),
            ),
          ),
        ],
      ),

      // ── Full-Screen Routes ───────────────────────────────────────────────

      GoRoute(
        path: '/tree',
        builder: (context, state) => const TreeVisualizationScreen(),
      ),

      // Add member — extra: {'treeId': String}
      GoRoute(
        path: '/member/add',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return AddEditMemberScreen(treeId: extra?['treeId'] as String?);
        },
      ),

      // View member profile — path param: id
      GoRoute(
        path: '/member/:id',
        builder: (context, state) => MemberProfileScreen(
          personId: state.pathParameters['id']!,
        ),
      ),

      // Edit member — path param: id
      GoRoute(
        path: '/member/:id/edit',
        builder: (context, state) => AddEditMemberScreen(
          personId: state.pathParameters['id'],
        ),
      ),

      // Add relationship — extra: {'personId': String, 'treeId': String}
      GoRoute(
        path: '/relationship/add',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return AddRelationshipScreen(
            personId: extra['personId'] as String,
            treeId: extra['treeId'] as String,
          );
        },
      ),

      // Search — extra: {'treeId': String}
      GoRoute(
        path: '/search',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return SearchScreen(treeId: extra['treeId'] as String);
        },
      ),
    ],

    // Global error page
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.broken_image_outlined, size: 64),
            const SizedBox(height: 16),
            Text('Route not found: ${state.uri}'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});
