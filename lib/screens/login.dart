import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodshuffle/api/websocket.dart';
// アニメーションを挟む
import '../../screens/animation.dart';
// 画像パスを管理するクラス
import '../model/images.dart';
//httpリクエスト用のモジュール
import 'package:http/http.dart' as http;
// Jtiトークンを保持するためのモジュール
import 'package:shared_preferences/shared_preferences.dart';
//envファイルを読み込むためのモジュール
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
                            // HTTPリクエストを送信
                            final response = await http.post(
                              Uri.parse('http://M2.local:5678/v1/login'),
                              headers: {
                                'Content-Type': 'application/json',
                                'Accept': 'application/json',
                              },
                              // リクエストボディをJSON形式に変換し、emailとpasswordを含める
                              body: jsonEncode({
                                'MailAddress': email,
                                'Password': password,
                              }),
                            );
                            // レスポンスボディをJSON形式に変換 {Response: {Data: {JtiToken:~~~}, Status: ~~~}}
                            final responseBody = jsonDecode(response.body);
                            switch (responseBody['Response']['Status']) {
                              case 'OK': // ログイン成功(200)
                                //トークンを保存
                                final token = responseBody['Response']['Data']
                                    ['JtiToken'];
                                await _saveJtiToken(token);
                                // websocketの接続確立
                                debugPrint(responseBody['Response']['Data']
                                    ['JtiToken']);
                                WebSocketService().connect(
                                    responseBody['Response']['Data']
                                        ['JtiToken']);
                                // ログイン処理成功時に遷移
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AnimationPage(),
                                  ),
                                );
                                break;
                              case 'Bad Request': // ログイン失敗(400)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('メールアドレスまたはパスワードが正しくありません。'),
                                  ),
                                );
                                break;
                              case 'Unauthorized': // ログイン失敗(401)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('アカウントの認証に失敗しました。'),
                                  ),
                                );
                                break;
                              case 'Internal Server Error': // ログイン失敗(500)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('サーバーで問題が発生しました。'),
                                  ),
                                );
                                break;
                              default: //今のところログイン失敗するとerrorのみ返ってくるのでdefaultにたどり着く
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('メールアドレス、またはパスワードが正しくありません。'),
                                  ),
                                );
                                break;
                            }
                          } catch (e) {
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
