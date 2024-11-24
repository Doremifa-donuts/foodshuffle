import 'package:flutter/material.dart';
// アニメーションを挟む
import '../../screens/animation.dart';
// 画像パスを管理するクラス
import '../model/images.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // メールアドレスとパスワードの入力コントローラー
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // コントローラーの解放
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ユーザーアイコンの表示
                  const CircleAvatar(
                    radius: 50, // アイコンの半径
                    backgroundImage:
                        AssetImage('images/icon/member_1.png'), // アイコン画像
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 20),

                  // メールアドレス入力フィールド
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'メールアドレス',
                      hintText: 'example@example.com',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // パスワード入力フィールド
                  TextField(
                    controller: _passwordController,
                    obscureText: true, // パスワードは隠す
                    decoration: const InputDecoration(
                      labelText: 'パスワード',
                      hintText: '********',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ログインボタン
                  ElevatedButton(
                    onPressed: () {
                      // ここにログイン処理を書く

                      final email = _emailController.text;
                      final password = _passwordController.text;

                      // ここにログイン情報の処理（例: APIリクエストや認証処理）

                      if (email.isNotEmpty && password.isNotEmpty) {
                        // ログイン処理成功時に遷移
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AnimationPage(),
                          ),
                        );
                      } else {
                        // エラーメッセージを表示
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('メールアドレスとパスワードを入力してください。')),
                        );
                      }
                    },
                    child: const Text('ログイン'),
                  ),
                  const SizedBox(height: 10),

                  // アカウント作成ボタン
                  ElevatedButton(
                    onPressed: () {
                      // アカウント作成画面に遷移
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AnimationPage(), // アカウント作成ページに変更
                        ),
                      );
                    },
                    child: const Text('アカウント作成'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
