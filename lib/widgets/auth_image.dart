import 'package:flutter/material.dart';
import 'package:foodshuffle/api/urls.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// 画像キャッシュを保持する
class ImageCache {
  static final Map<String, Uint8List> _cache = {};

  static void addToCache(String key, Uint8List data) {
    _cache[key] = data;
  }

  static Uint8List? getFromCache(String key) {
    return _cache[key];
  }

  static bool hasInCache(String key) {
    return _cache.containsKey(key);
  }
}

class AuthImage extends StatefulWidget {
  final String imagePath;
  final double height;
  final double width;

  const AuthImage({
    super.key,
    required this.imagePath,
    required this.height,
    required this.width,
  });

  @override
  createState() => _AuthImageState();
}

class _AuthImageState extends State<AuthImage>
    with AutomaticKeepAliveClientMixin {
  Uint8List? imageData;
  bool isLoading = false;

  @override
  bool get wantKeepAlive => true; // StateをKeepAliveに設定

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    if (!mounted) return;

    // まずキャッシュをチェック
    final cachedImage = ImageCache.getFromCache(widget.imagePath);
    if (cachedImage != null) {
      setState(() {
        imageData = cachedImage;
      });
      return;
    }

    // キャッシュになければ取得
    if (!isLoading) {
      await _fetchImage(widget.imagePath);
    }
  }

  Future<void> _fetchImage(String imagePath) async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString('token');
      final response = await http.get(
        Uri.parse('${Urls.images}$imagePath'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 && mounted) {
        final imageBytes = response.bodyBytes;
        ImageCache.addToCache(imagePath, imageBytes); // キャッシュに追加

        setState(() {
          imageData = imageBytes;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load image. Status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching image: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixinのため必要

    return imageData != null
        ? Image.memory(
            imageData!,
            height: widget.height,
            width: widget.width,
            fit: BoxFit.cover,
            // キーを追加してウィジェットの識別を確実に
            key: ValueKey('image_${widget.imagePath}'),
          )
        : const SizedBox(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
