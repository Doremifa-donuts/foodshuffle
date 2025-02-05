import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/footer.dart';
import '../model/color.dart';
import '../model/images.dart';
import '../model/data_list.dart';
import 'login.dart';

// レビュー済みのページに飛ばす
import '../screens/review/review_able.dart';
// 行ったところマップに飛ばす
import '../screens/map.dart';

const bool useDatabase = false;

// ユーザーデータの状態管理
class UserNotifier extends StateNotifier<User> {
  UserNotifier(User initialState) : super(initialState);

  void updateUserName(String newName) {
    state = User(
      UserName: newName,
      Icon: state.Icon,
      goods: state.goods,
      range: state.range,
      store: state.store,
    );
  }
}

// プロバイダー
final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  if (useDatabase) {
    return UserNotifier(
      User(
        UserName: 'ユーザー',
        Icon: 'images/icon/member_2.png',
        goods: 5,
        range: 30,
        store: 2,
      ),
    );
  } else {
    return UserNotifier(
      User(
        UserName: 'かれんこん',
        Icon: 'images/icon/member_1.png',
        goods: 10,
        range: 50,
        store: 3,
      ),
    );
  }
});

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final userNotifier = ref.read(userProvider.notifier);

    void showEditNameDialog() {
      final TextEditingController controller = TextEditingController(
        text: user.UserName,
      );

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('名前を編集'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: '新しい名前',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                userNotifier.updateUserName(controller.text);
                Navigator.pop(context);
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ).whenComplete(() => controller.dispose());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'マイページ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(mainColor),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                backgroundImage: AssetImage(user.Icon),
                radius: 50,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    onPressed: showEditNameDialog,
                    icon: const Icon(Icons.edit),
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Icon(Icons.thumb_up, color: Colors.orange),
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
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.share, color: Colors.black),
                      title: const Text(
                        '共有するレビュー',
                        style: TextStyle(fontSize: 24),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewBeforePage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.map, color: Colors.black),
                      title: const Text(
                        '行ったところマップ',
                        style: TextStyle(fontSize: 24),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.black),
                      title: const Text(
                        'ログアウト',
                        style: TextStyle(fontSize: 24),
                      ),
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
          const Positioned(
            bottom: -20,
            left: 0,
            right: 0,
            child: Footer(),
          ),
        ],
      ),
    );
  }
}
