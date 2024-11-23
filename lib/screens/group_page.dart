import 'package:flutter/material.dart';
// ランダム関数
import 'dart:math';
// 動的に状態把握
import 'package:flutter_riverpod/flutter_riverpod.dart';
// footer 表示
import 'package:foodshuffle/widgets/footer.dart';
// カラー、画像パス
import '../model/color.dart';
import '../model/images.dart';
// 表示するデータを受け取るclass
import '../model/data_list.dart';

// データベースを使用できるか
const bool useDatabase = false;
// ランダム関数
final Random _random = Random();

// プロバイダーの定義（データ取得を切り替え）
final groupProvider = FutureProvider<List<Group>>((ref) async {
  if (useDatabase) {
    return fetchGroupsFromDatabase();
  } else {
    return fetchDummyGroups();
  }
});

// ダミーデータ（データベースがない場合に使用する固定データ）
Future<List<Group>> fetchDummyGroups() async {
  return List.generate(
    10,
    (index) {
      // 1～12のランダムな画像を選択
      List<String> allIcons = List.generate(
        12,
        (iconIndex) => 'images/icon/member_${iconIndex + 1}.png', // アイコンのパスを生成
      );
      // ランダム人数のアイコンリストを生成（1～5個のランダムな数を取得）
      List<String> memberIcons = List.generate(
        _random.nextInt(5) + 1, // 1～5のランダムな人数
        (_) => allIcons[_random.nextInt(12)], // 12個の画像からランダム選択
      );

      // グループを返す
      return Group(
        name: "グループ ${index + 1}",
        deadline: "2024/12/${(index + 10) % 30 + 1}", // 期限日を設定
        memberIcons: memberIcons,
      );
    },
  );
}

// 本番用（データベースから取得する処理）
Future<List<Group>> fetchGroupsFromDatabase() async {
  await Future.delayed(const Duration(seconds: 2)); // 仮の遅延
  return []; // データベースの中身を受け取る
}

// グループページ
class GroupPage extends ConsumerWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsyncValue = ref.watch(groupProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'グループ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(mainColor), // アプリバーの背景色
      ),
      body: groupsAsyncValue.when(
        data: (groups) {
          return Stack(
            children: [
              // 背景画像
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backImg), // 背景画像のパス
                    fit: BoxFit.cover, // 大きく広げる
                  ),
                ),
              ),
              // スクロールバーを使ったリスト表示
              Scrollbar(
                thickness: 12, // スクロールバーの太さ
                radius: const Radius.circular(20), // スクロールバーの角の丸み
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  // リスト要素
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: groups.length, // グループの数
                  itemBuilder: (context, index) {
                    return _buildCard(groups[index]); // グループ情報を表示
                  },
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
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator()), // 読み込み中
        error: (err, stack) => Center(child: Text('エラーが発生しました: $err')), // エラー時
      ),
    );
  }

  // グループ情報を表示するカードウィジェット
  Widget _buildCard(Group group) {
    return Card(
      // カードのカラー
      color: const Color(listColor),
      // カードの縁指定
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color(allListColor), // 縁の色を指定
          width: 2, // 縁の太さ
        ),
        borderRadius: BorderRadius.circular(15), // カードの角を丸くする
      ),
      child: Padding(
        padding: const EdgeInsets.all(10), // カード内のパディング
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
                          radius: 20, // アイコンのサイズ
                          backgroundImage: AssetImage(iconPath), // アイコンの画像
                        ),
                      ))
                  .toList(), // メンバーアイコンをリストとして表示
            ),
          ],
        ),
      ),
    );
  }
}


// TODO: 未実装
// グループ作成ボタン
