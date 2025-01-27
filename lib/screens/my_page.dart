import 'package:flutter/material.dart';
// 動的に状態把握
import 'package:flutter_riverpod/flutter_riverpod.dart';
// footer 表示
import '../widgets/footer.dart';
// カラー、画像パス
import '../model/color.dart';
import '../model/images.dart';
// 表示するデータを受け取るclass
import '../model/data_list.dart';
// ログインページ
import 'login.dart';

// データベースを使用できるか
const bool useDatabase = false;

// プロバイダーを定義（ユーザーデータを非同期で取得）
final userProvider = FutureProvider<User>((ref) async {
  if (useDatabase) {
    // データベースからユーザー情報を取得
    return fetchUserFromDatabase();
  } else {
    // ダミーユーザーを取得
    return fetchDummyUser();
  }
});

// ダミーデータを返す関数（データベースを使用しない場合）
Future<User> fetchDummyUser() async {
  // 固定されたユーザー情報を返す
  return User(
    UserName: 'かれんこん', // ユーザー名
    Icon: 'images/icon/member_1.png', // ユーザーアイコン
    goods: 10, // 所持アイテム数
    range: 50, // 距離（例: 運送サービスなどのイメージ）
    store: 3, // 関連ストア数
  );
}

// データベースからユーザー情報を取得する関数
Future<User> fetchUserFromDatabase() async {
  await Future.delayed(const Duration(seconds: 2)); // 仮の遅延を追加
  // 本番環境ではデータベースから情報を取得して返す
  return User(
    UserName: 'ユーザー', // 仮のデータ
    Icon: 'images/icon/member_2.png',
    goods: 5,
    range: 30,
    store: 2,
  );
}

// マイページの画面
class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ユーザーデータをプロバイダーから非同期で取得
    final userAsyncValue = ref.watch(userProvider);

    return Scaffold(
      // header
      appBar: AppBar(
        title: const Text(
          'マイページ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(mainColor),
      ),
      body: userAsyncValue.when(
        data: (user) {
          // ユーザーデータが正常に取得できた場合のUI
          return Stack(
            children: [
              // 背景画像の設定
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backImg), // 背景画像
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Center(
                // ユーザー情報を表示する部分
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // ユーザーアイコン
                    CircleAvatar(
                      backgroundImage: AssetImage(user.Icon), // ユーザーアイコン画像
                      radius: 50, // アイコンの半径
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ユーザー名
                        Text(
                          user.UserName,
                          style: const TextStyle(
                            backgroundColor: Color(listColor),
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(width: 8),

                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                          color: Colors.black,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(16), // 全体の内側余白

                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const Icon(Icons.thumb_up,
                                      color: Colors.orange),
                                  const SizedBox(height: 4),
                                  const Text('いいね'),
                                  Text(user.goods.toString()),
                                ],
                              ),
                              const SizedBox(width: 40),
                              Column(
                                children: [
                                  const Icon(Icons.store, color: Colors.green),
                                  const SizedBox(height: 4),
                                  const Text('お店'),
                                  Text(user.store.toString()),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            leading:
                                const Icon(Icons.share, color: Colors.black),
                            title: const Text('共有するレビュー'),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(Icons.map, color: Colors.black),
                            title: const Text('行ったところマップ'),
                            onTap: () {},
                          ),
                          ListTile(
                            leading:
                                const Icon(Icons.thumb_up, color: Colors.black),
                            title: const Text('いいね'),
                            onTap: () {},
                          ),
                          ListTile(
                            leading:
                                const Icon(Icons.logout, color: Colors.black),
                            title: const Text('ログアウト'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // フッター部分
              const Positioned(
                bottom: -20, // 画面下に配置
                left: 0,
                right: 0,
                child: Footer(), // Footerウィジェットを表示
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(), // ローディング中の表示
        ),
        error: (error, stackTrace) => Center(
          child: Text('エラーが発生しました: $error'), // エラー時の表示
        ),
      ),
    );
  }
}


// TODO 未実装
// 真ん中寄せ
// 累計部分
  // icon
//　　名前変更icon
