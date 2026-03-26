import 'package:flutter/material.dart';

void main() {
  runApp(BhaktiApp());
}

class BhaktiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bhakti Rasamruta Sara",
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class Song {
  final String title;
  final String lyrics;
  final String composer;
  final String singer;
  final String category;
  final String? audio;

  Song({
    required this.title,
    required this.lyrics,
    required this.composer,
    required this.singer,
    required this.category,
    this.audio,
  });
}

List<Song> songs = [
  Song(
    title: "ಜಗದೋಧ್ಧಾರಣ",
    lyrics: "ಜಗದೋಧ್ಧಾರಣ ಆದಿಸಿದಳೆ ಯಶೋದೆ...",
    composer: "ಪುರಂದರ ದಾಸರು",
    singer: "",
    category: "Krishna",
  ),
  Song(
    title: "ರಾಮನಾಮ",
    lyrics: "ರಾಮ ರಾಮ ಜಪಿಸು...",
    composer: "ಕನಕ ದಾಸರು",
    singer: "",
    category: "Rama",
  ),
];

class HomeScreen extends StatelessWidget {
  final categories = ["Krishna", "Rama"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ಭಕ್ತಿ ರಸಾಮೃತ ಸಾರ")),
      body: ListView(
        children: categories.map((cat) {
          return ListTile(
            title: Text(cat),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SongListScreen(category: cat),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class SongListScreen extends StatelessWidget {
  final String category;

  SongListScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    final filtered =
        songs.where((s) => s.category == category).toList();

    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final song = filtered[index];
          return ListTile(
            title: Text(song.title),
            subtitle: Text(song.composer),
            trailing: song.audio != null
                ? Icon(Icons.music_note, color: Colors.orange)
                : null,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailScreen(song: song),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Song song;

  DetailScreen({required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(song.title)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(song.title, style: TextStyle(fontSize: 20)),
            SizedBox(height: 5),
            Text("Composer: ${song.composer}"),
            if (song.singer.isNotEmpty)
              Text("Singer: ${song.singer}"),
            SizedBox(height: 10),

            if (song.audio != null)
              ElevatedButton(
                onPressed: () {},
                child: Text("▶ Play"),
              )
            else
              Text("🎵 Audio not available"),

            SizedBox(height: 10),

            Expanded(
              child: SingleChildScrollView(
                child: Text(song.lyrics),
              ),
            )
          ],
        ),
      ),
    );
  }
}