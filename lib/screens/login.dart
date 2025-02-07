import 'package:flutter/material.dart';
import 'package:foodshuffle/api/request_handler.dart';
import 'package:foodshuffle/api/urls.dart';
import 'package:foodshuffle/api/websocket.dart';
import 'package:foodshuffle/utils/errors.dart';
import 'package:shared_preferences/shared_preferences.dart';
// アニメーションを挟む
import '../../screens/animation.dart';
// 画像パスを管理するクラス
import '../model/images.dart';
//httpリクエスト用のモジュール
// Jtiトークンを保持するためのモジュール
//envファイルを読み込むためのモジュール

Future<void> _saveJtiToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token); // 'oken'でJTIトークンを保存
}

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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // タイトル画像
                    const Image(
                      image: AssetImage(title),
                      width: 240,
                      height: 240,
                    ),
                    const SizedBox(height: 10),

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
                    const SizedBox(height: 10),

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
                    const SizedBox(height: 10),

                    // ログインボタン
                    ElevatedButton(
                      onPressed: () async {
                        // 入力されたメールアドレスとパスワードを取得
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        if (email.isNotEmpty && password.isNotEmpty) {
                          // ログイン処理
                          try {
                            debugPrint("0");
                            // HTTPリクエストを送信
                            final data = await RequestHandler.jsonWithOutAuth(
                                endpoint: Urls.login,
                                method: HttpMethod.post,
                                body: {
                                  'MailAddress': email,
                                  'Password': password,
                                });
                            debugPrint("1");

                            // トークンの保存
                            await _saveJtiToken(data['JtiToken']);
                            // websocketの接続確立
                            debugPrint(data['JtiToken']);
                            WebSocketService().connect(data['JtiToken']);

                            // ログイン処理成功時に遷移
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AnimationPage(),
                              ),
                              (route) => false,
                            );
                          } catch (e) {
                            if (e is Errors) {
                              switch (e.errorCode) {
                                case 400:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('メールアドレスとパスワードを入力してください。'),
                                    ),
                                  );
                                case 401:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('メールアドレスとパスワードが正しくありません。'),
                                    ),
                                  );
                                  break;
                                default:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('アカウントの認証に失敗しました。'),
                                    ),
                                  );
                                  break;
                              }
                            }
                            // 例外処理
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('通信エラー'),
                              ),
                            );
                            print(e);
                          }
                        } else {
                          // エラーメッセージを表示
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('メールアドレスとパスワードを入力してください。'),
                            ),
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
                                const AnimationPage(), // 適切なアカウント作成ページに変更
                          ),
                        );
                      },
                      child: const Text('アカウント作成'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
