import 'package:flutter/material.dart';
import 'package:foodshuffle/screens/home_page.dart';
import 'package:foodshuffle/screens/store_info/archive_page.dart';
import 'package:foodshuffle/screens/my_page.dart';
import 'package:foodshuffle/screens/group_page.dart';
import 'package:foodshuffle/screens/review/review_able.dart';
import 'package:foodshuffle/screens/QR/qr_code.dart';

import '../model/color.dart';
import '../model/images.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 170.0,
        width: double.infinity, // 画面全体の幅に調整
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(unionImg), // 背景画像の指定
            fit: BoxFit.fill, // 画面全体の幅に調整
            alignment: Alignment.bottomCenter, // 画像を真ん中寄せ
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // 画像を真ん中寄せ
          mainAxisSize: MainAxisSize.max, // 画像を真ん中寄せ: ,
          children: [
            Center(
              child: _FooterIcon(
                  icon: Icons.store,
                  label: 'お店に着いたよ！',
                  isActive: false, // 現在のページに応じて変更
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QrScanView()),
                    );
                  }),
            ),

            const SizedBox(height: 16), // 余白調整
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _FooterIcon(
                      icon: Icons.rate_review,
                      label: 'review',
                      isActive: false, // 現在のページに応じて変更
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReviewBeforePage()),
                        );
                      }),
                  _FooterIcon(
                      icon: Icons.groups_2,
                      label: 'groups',
                      isActive: false, // 現在のページに応じて変更
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GroupPage()),
                        );
                      }),
                  _FooterIcon(
                      icon: Icons.home,
                      label: 'home',
                      isActive: true, // アクティブなページ
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      }),
                  _FooterIcon(
                      icon: Icons.bookmark,
                      label: 'archive',
                      isActive: false,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArchivePage()),
                        );
                      }),
                  _FooterIcon(
                      icon: Icons.account_circle,
                      label: 'my page',
                      isActive: false,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyPage()),
                        );
                      }),
                ],
              ),
            )
          ],
        ));
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
            color: isActive ? const Color(activeColor) : const Color(iconColor),
            size: 28.0, // アイコンサイズ
          ),
          const SizedBox(height: 4.0), // アイコンとラベルの間のスペース
          Text(
            label,
            style: TextStyle(
              color:
                  isActive ? const Color(activeColor) : const Color(iconColor),
              fontSize: 12.0, // ラベルサイズ
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              width: 20.0,
              height: 3.0,
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(activeColor)
                    : const Color(iconColor),
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
        begin: const Color.fromARGB(238, 255, 186, 157),
        end: const Color.fromARGB(238, 255, 186, 157),
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
