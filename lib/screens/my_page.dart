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
import '../login.dart';

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
    name: 'かれんこん', // ユーザー名
    userIcon: 'images/icon/member_1.png', // ユーザーアイコン
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
    name: 'ユーザー', // 仮のデータ
    userIcon: 'images/icon/member_2.png',
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
                    // ユーザーアイコン
                    CircleAvatar(
                      backgroundImage: AssetImage(user.userIcon), // ユーザーアイコン画像
                      radius: 40, // アイコンの半径
                    ),

                    // ユーザー名
                    Text(
                      user.name,
                      style: const TextStyle(
                        backgroundColor: Color(listColor),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.all(4), // 全体の内側余白
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black, width: 2), // 外枠のボーダー
                        borderRadius: BorderRadius.circular(8), // 角丸
                      ),
                      child: Stack(
                        alignment: Alignment.center, // 中央揃え
                        children: [
                          Column(
                            children: [
                              const Text(
                                '累計',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 16), // 累計を重ねた部分の余白調整
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const Text('いいね'),
                                      Text(user.goods.toString()),
                                    ],
                                  ),
                                  const SizedBox(width: 40),
                                  Column(
                                    children: [
                                      const Text('共有距離（km）'),
                                      Text(user.store.toString()),
                                    ],
                                  ),
                                  const SizedBox(width: 40),
                                  Column(
                                    children: [
                                      const Text('お店'),
                                      Text(user.goods.toString()),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // サインアウトボタン
                    ElevatedButton(
                      onPressed: () {
                        // サインアウト後にログインページに遷移
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text('行ったところマップ'),
                    ),

                    // サインアウトボタン
                    ElevatedButton(
                      onPressed: () {
                        // サインアウト後にログインページに遷移
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text('いいね'),
                    ),

                    // サインアウトボタン
                    ElevatedButton(
                      onPressed: () {
                        // サインアウト後にログインページに遷移
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text('サインアウト'),
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
