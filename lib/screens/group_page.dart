import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodshuffle/widgets/footer.dart';
import 'package:foodshuffle/common.dart';

// グループデータクラス
class Group {
  final String name;
  final String deadline;
  final List<String> memberIcons;

  Group({
    required this.name,
    required this.deadline,
    required this.memberIcons,
  });
}

class GroupPage extends ConsumerStatefulWidget {
  const GroupPage({super.key});

  @override
  ConsumerState<GroupPage> createState() => _GroupPage();
}

class _GroupPage extends ConsumerState<GroupPage> {
  final Random _random = Random(); // ランダム生成用

  // ダミーデータ（12個の画像を使用しランダム生成）
  late final List<Group> groups = List.generate(
    10,
    (index) {
      // 1～12のランダムな画像を選択
      List<String> allIcons = List.generate(
        12,
        (iconIndex) => 'images/icon/member_${iconIndex + 1}.png',
      );
      // ランダム人数のアイコンリストを生成（1～5個のランダムな数を取得）
      List<String> memberIcons = List.generate(
        _random.nextInt(5) + 1, // 1～5のランダムな人数
        (_) => allIcons[_random.nextInt(12)], // 12個の画像からランダム選択
      );

      return Group(
        name: "グループ ${index + 1}",
        deadline: "2024/12/${(index + 10) % 30 + 1}",
        memberIcons: memberIcons,
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'グループ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(mainColor)),
      body: Stack(
        children: [
          // 背景画像
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backImg), // 背景画像のパス
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scrollbar(
            thickness: 12,
            radius: const Radius.circular(20),
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemCount: groups.length,
              itemBuilder: (context, index) => _buildCard(groups[index]),
            ),
          ),

          // フッター部分
          const Positioned(
            bottom: -20,
            left: 0,
            right: 0,
            child: Footer(), // Footerウィジェットを表示
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Group group) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              // グループ名
              Text(
                group.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              // グループの期限日
              Text(
                '期限日: ${group.deadline}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ]),
            const SizedBox(height: 8),
            // メンバーアイコン
            Row(
              children: group.memberIcons
                  .map((iconPath) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(iconPath), // 修正されたパスを使用
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
