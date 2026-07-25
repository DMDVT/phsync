import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/gallery/gallery_grid_screen.dart';
import '../screens/albums/albums_list_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/people/people_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/settings/storage_screen.dart';
import '../screens/sharing/sharing_hub_screen.dart';
import '../screens/sharing/notifications_screen.dart';
import '../screens/vault/vault_screen.dart';
import '../screens/memories/memories_screen.dart';
import 'theme.dart';

class PhotoSyncApp extends StatelessWidget {
  const PhotoSyncApp({super.key});
  static final router = GoRouter(routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => AppShell(shell: shell),
      branches: [
        StatefulShellBranch(routes: [GoRoute(path: '/', builder: (_, __) => const GalleryGridScreen())]),
        StatefulShellBranch(routes: [GoRoute(path: '/albums', builder: (_, __) => const AlbumsListScreen())]),
        StatefulShellBranch(routes: [GoRoute(path: '/search', builder: (_, __) => const SearchScreen())]),
        StatefulShellBranch(routes: [GoRoute(path: '/people', builder: (_, __) => const PeopleScreen())]),
        StatefulShellBranch(routes: [GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen())]),
      ],
    ),
    GoRoute(path:'/sharing',builder:(_,__)=>const SharingHubScreen()),
    GoRoute(path:'/notifications',builder:(_,__)=>const NotificationsScreen()),
    GoRoute(path:'/vault',builder:(_,__)=>const VaultScreen()),
    GoRoute(path:'/storage',builder:(_,__)=>const StorageScreen()),
    GoRoute(path:'/memories',builder:(_,__)=>const MemoriesScreen()),
  ]);
  @override Widget build(BuildContext context) => MaterialApp.router(title:'PhotoSync',theme:AppTheme.light,darkTheme:AppTheme.dark,themeMode:ThemeMode.system,routerConfig:router);
}
class AppShell extends StatelessWidget {
  const AppShell({required this.shell, super.key}); final StatefulNavigationShell shell;
  @override Widget build(BuildContext context) => Scaffold(body:shell,bottomNavigationBar:NavigationBar(selectedIndex:shell.currentIndex,onDestinationSelected:shell.goBranch,destinations:const [
    NavigationDestination(icon:Icon(Icons.photo_library_outlined),selectedIcon:Icon(Icons.photo_library),label:'Photos'),
    NavigationDestination(icon:Icon(Icons.photo_album_outlined),selectedIcon:Icon(Icons.photo_album),label:'Albums'),
    NavigationDestination(icon:Icon(Icons.search),label:'Search'),
    NavigationDestination(icon:Icon(Icons.people_outline),selectedIcon:Icon(Icons.people),label:'People'),
    NavigationDestination(icon:Icon(Icons.settings_outlined),selectedIcon:Icon(Icons.settings),label:'Settings'),
  ]));
}
