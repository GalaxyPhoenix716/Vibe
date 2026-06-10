import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/providers/current_song_notifier.dart';
import 'package:vibe/core/providers/current_user_notifier.dart';
import 'package:vibe/core/providers/recently_played_provider.dart';
import 'package:vibe/core/theme/app_colors.dart';
import 'package:vibe/core/widgets/home_appbar.dart';
import 'package:vibe/feature/home/model/song_model.dart';
import 'package:vibe/feature/music/viewmodel/upload_viewmodel.dart';
import 'package:vibe/feature/search/viewmodel/search_viewmodel.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Categories list matching tags in constants.dart
  final List<Map<String, dynamic>> _genreCategories = [
    {
      'title': 'Chill Vibes',
      'tag': 'chill',
      'colors': [VibeColors.deepBlue, VibeColors.brightPurple],
      'aspectRatio': 0.85,
    },
    {
      'title': 'EDM & Dance',
      'tag': 'edm',
      'colors': [VibeColors.cyan, VibeColors.electricBlue],
      'aspectRatio': 1.35,
    },
    {
      'title': 'Pop Hits',
      'tag': 'pop',
      'colors': [VibeColors.rosePink, VibeColors.pink],
      'aspectRatio': 1.35,
    },
    {
      'title': 'Workout Pulse',
      'tag': 'workout',
      'colors': [VibeColors.darkOrange, VibeColors.lightOrange],
      'aspectRatio': 0.85,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);
    final recentlyPlayed = ref.watch(recentlyPlayedProvider);
    final userFavourites = ref.watch(
      currentUserProvider.select((data) => data?.favSongs ?? []),
    );

    return Scaffold(
      backgroundColor: VibeColors.backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Global App Bar
          const HomeAppBar(),

          // Search Box Input
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: VibeColors.white.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: VibeColors.white.withValues(alpha: 0.05),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: VibeColors.white),
                      cursorColor: VibeColors.brightPurple,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          CupertinoIcons.search,
                          color: VibeColors.inactive,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (searchQuery.isNotEmpty)
                              IconButton(
                                icon: const Icon(
                                  CupertinoIcons.clear_circled_solid,
                                  color: VibeColors.inactive,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  ref.read(searchQueryProvider.notifier).clearQuery();
                                },
                              ),
                            const Icon(
                              CupertinoIcons.mic_fill,
                              color: VibeColors.inactive,
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                        hintText: "Search",
                        hintStyle: const TextStyle(
                          color: VibeColors.inactive,
                          fontFamily: 'SF Pro',
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onChanged: (val) {
                        ref.read(searchQueryProvider.notifier).updateQuery(val);
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),

          // Dynamic View States as Slivers
          if (searchQuery.isEmpty)
            ..._buildBrowseViewSlivers(recentlyPlayed, userFavourites)
          else
            _buildSearchResultsViewSliver(searchQuery, userFavourites),
        ],
      ),
    );
  }

  // Slivers for when search query is empty (Explore + Recently Played)
  List<Widget> _buildBrowseViewSlivers(List<SongModel> recentlyPlayed, List<dynamic> userFavourites) {
    return [
      // Explore section heading
      const SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              "Explore Genres & Moods",
              style: TextStyle(
                fontFamily: 'SF Pro',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: VibeColors.white,
              ),
            ),
          ),
        ),
      ),

      // Staggered Asymmetric Grid using standard Row/Column
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverToBoxAdapter(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column
              Expanded(
                child: Column(
                  children: [
                    _buildGenreCard(_genreCategories[0]),
                    const SizedBox(height: 12),
                    _buildGenreCard(_genreCategories[2]),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Right Column
              Expanded(
                child: Column(
                  children: [
                    _buildGenreCard(_genreCategories[1]),
                    const SizedBox(height: 12),
                    _buildGenreCard(_genreCategories[3]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      const SliverToBoxAdapter(child: SizedBox(height: 30)),

      // Recently Played Heading
      if (recentlyPlayed.isNotEmpty)
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recently Played",
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: VibeColors.white,
                    ),
                  ),
                  Text(
                    "View all",
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 14,
                      color: VibeColors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

      // Recently Played list
      if (recentlyPlayed.isNotEmpty)
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final song = recentlyPlayed[index];
                return _buildSongTile(song, recentlyPlayed, userFavourites);
              },
              childCount: recentlyPlayed.length > 5 ? 5 : recentlyPlayed.length,
            ),
          ),
        ),

      const SliverToBoxAdapter(child: SizedBox(height: 100)),
    ];
  }

  // Asymmetric Genre Card Builder
  Widget _buildGenreCard(Map<String, dynamic> category) {
    return AspectRatio(
      aspectRatio: category['aspectRatio'] as double,
      child: GestureDetector(
        onTap: () {
          _searchController.text = category['title'] as String;
          ref.read(searchQueryProvider.notifier).updateQuery(category['tag'] as String);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: category['colors'] as List<Color>,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: (category['colors'] as List<Color>).first.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Decorative concentric glass circle overlays
              Positioned(
                right: -20,
                bottom: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: VibeColors.white.withValues(alpha: 0.08),
                  ),
                ),
              ),
              Positioned(
                right: -5,
                bottom: -5,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: VibeColors.white.withValues(alpha: 0.08),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 12,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: VibeColors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    CupertinoIcons.music_note_2,
                    color: VibeColors.white,
                    size: 14,
                  ),
                ),
              ),

              // Text Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      category['title'] as String,
                      style: const TextStyle(
                        fontFamily: 'SF Pro',
                        color: VibeColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Explore tags",
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        color: VibeColors.white.withValues(alpha: 0.7),
                        fontSize: 12,
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
  }

  // Song List Tile matching user mockup
  Widget _buildSongTile(SongModel song, List<SongModel> queue, List<dynamic> userFavourites) {
    final isFav = userFavourites
        .where((fav) => fav.songId == song.id)
        .isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          ref.read(currentQueueProvider.notifier).setQueue(queue);
          ref.read(currentSongProvider.notifier).updateSong(song);
        },
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            // Artwork
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: song.thumbnail_url,
                width: 55,
                height: 55,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 55,
                  height: 55,
                  color: VibeColors.card,
                  child: const Icon(CupertinoIcons.music_note, color: VibeColors.inactive),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Track details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.song_name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'SF Pro',
                      color: VibeColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        song.artist,
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          color: VibeColors.white.withValues(alpha: 0.5),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 5),
                      // Small verified checkmark icon from the mockup
                      Icon(
                        Icons.check_circle,
                        color: VibeColors.white.withValues(alpha: 0.5),
                        size: 13,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Favorite (Heart) Action
            IconButton(
              icon: Icon(
                isFav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                color: isFav ? VibeColors.brightPurple : VibeColors.white.withValues(alpha: 0.5),
                size: 20,
              ),
              onPressed: () async {
                await ref
                    .read(uploadViewModelProvider.notifier)
                    .favSong(songId: song.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Active search query results state view (as a Sliver)
  Widget _buildSearchResultsViewSliver(String query, List<dynamic> userFavourites) {
    final resultsAsync = ref.watch(searchSongsProvider(query: query));

    return resultsAsync.when(
      data: (results) {
        if (results.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.music_note_list,
                    color: VibeColors.white.withValues(alpha: 0.2),
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No songs found for '$query'",
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      color: VibeColors.white.withValues(alpha: 0.4),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final song = results[index];
                return _buildSongTile(song, results, userFavourites);
              },
              childCount: results.length,
            ),
          ),
        );
      },
      loading: () => const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: CircularProgressIndicator(
            color: VibeColors.brightPurple,
          ),
        ),
      ),
      error: (err, stack) => SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            "Error loading results: $err",
            style: const TextStyle(color: VibeColors.error),
          ),
        ),
      ),
    );
  }
}
