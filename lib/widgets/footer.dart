import 'package:flutter/material.dart';
import 'package:foodshuffle/common.dart';
import 'package:foodshuffle/screens/home_page.dart';
import 'package:foodshuffle/screens/archive_page.dart';

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
            onPressed: () => Navigator.pushNamed(context, '/home'),
          ),
          _FooterIcon(
            icon: Icons.groups_2,
            label: 'Groups',
            isActive: false, // 現在のページに応じて変更
            onPressed: () => Navigator.pushNamed(context, '/home'),
          ),
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
                  MaterialPageRoute(builder: (context) => const ArchivePage()),
                );
              }),
          _FooterIcon(
            icon: Icons.account_circle,
            label: 'Profile',
            isActive: false,
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
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
