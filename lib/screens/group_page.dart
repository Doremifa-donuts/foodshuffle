import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodshuffle/widgets/footer.dart';

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
  // ダミーデータ
  final List<Group> groups = List.generate(
    10,
    (index) => Group(
      name: "グループ ${index + 1}",
      deadline: "2024/12/${(index + 10) % 30 + 1}",
      memberIcons: List.generate(
        5,
        (iconIndex) => 'images/icon/member_${(index + iconIndex) % 5 + 1}.png',
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('グループ'),
      ),
      body: Stack(
        children: [
          // 背景画像
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
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
            bottom: 0,
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
            // グループ名
            Text(
              group.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // グループの期限日
            Text(
              '期限日: ${group.deadline}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            // メンバーアイコン
            Row(
              children: group.memberIcons
                  .map((iconPath) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(iconPath),
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
