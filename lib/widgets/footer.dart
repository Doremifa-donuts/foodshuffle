import 'package:flutter/material.dart';
import 'package:foodshuffle/common.dart';
import 'package:foodshuffle/screens/home_page.dart';
import 'package:foodshuffle/screens/archive_page.dart';
import 'package:foodshuffle/screens/my_page.dart';
import 'package:foodshuffle/screens/group_page.dart';
import 'package:foodshuffle/screens/review_page.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(unionImg), // 背景画像の指定
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _FooterIcon(
              icon: Icons.rate_review,
              label: 'Review',
              isActive: false, // 現在のページに応じて変更
              onPressed: () {
                Navigator.push(
                  context,
                  blackOut(const ReviewPage()),
                );
              }),
          _FooterIcon(
              icon: Icons.groups_2,
              label: 'Groups',
              isActive: false, // 現在のページに応じて変更
              onPressed: () {
                Navigator.push(
                  context,
                  flipTransition(const GroupPage()),
                );
              }),
          _FooterIcon(
              icon: Icons.home,
              label: 'Home',
              isActive: true, // アクティブなページ
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              }),
          _FooterIcon(
              icon: Icons.bookmark,
              label: 'Bookmarks',
              isActive: false,
              onPressed: () {
                Navigator.push(
                  context,
                  diagonalSlideTransition(const ArchivePage()),
                );
              }),
          _FooterIcon(
              icon: Icons.account_circle,
              label: 'Profile',
              isActive: false,
              onPressed: () {
                Navigator.push(
                  context,
                  verticalFlipTransition(const MyPage()),
                );
              }),
        ],
      ),
    );
  }
}

class _FooterIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  const _FooterIcon({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.blueAccent : Colors.white, // アクティブな場合の色変更
            size: 28.0, // アイコンサイズ
          ),
          const SizedBox(height: 4.0), // アイコンとラベルの間のスペース
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.blueAccent : Colors.white,
              fontSize: 12.0, // ラベルサイズ
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              width: 20.0,
              height: 3.0,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
        ],
      ),
    );
  }
}

// 画面遷移アニメーション　blackOut
PageRouteBuilder<Object?> blackOut(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionDuration: const Duration(seconds: 1),
    reverseTransitionDuration: const Duration(seconds: 1),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final color = ColorTween(
        begin: Colors.transparent,
        end: Colors.black,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(0, 0.5, curve: Curves.easeInOut),
        ),
      );
      final opacity = Tween<double>(
        begin: 0,
        end: 1,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(0.5, 1, curve: Curves.easeInOut),
        ),
      );
      return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Container(
            color: color.value,
            child: Opacity(
              opacity: opacity.value,
              child: child,
            ),
          );
        },
        child: child,
      );
    },
  );
}

// 画面遷移アニメーション　flip
PageRouteBuilder<Object?> flipTransition(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.linear),
          );
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(2 * 3.14 * flipAnimation.value),
            alignment: Alignment.center,
            child: child,
          );
        },
        child: child,
      );
    },
  );
}

// 画面遷移アニメーション　diagonal
PageRouteBuilder<Object?> diagonalSlideTransition(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final offsetAnimation = Tween<Offset>(
        begin: const Offset(-1.0, -1.0),
        end: Offset.zero,
      ).animate(animation);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

// 画面遷移アニメーション　flip
PageRouteBuilder<Object?> verticalFlipTransition(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.linear),
      );
      return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(2 * 3.14 * flipAnimation.value),
            child: child,
          );
        },
        child: child,
      );
    },
  );
}
