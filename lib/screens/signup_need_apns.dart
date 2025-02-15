import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// アニメーションを挟む
// 画像パスを管理するクラス
import '../model/images.dart';

Future<void> verifyPhone(String phone) async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: '+81$phone',
    verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException e) {
      String errText;
    },
    codeSent: (String verificationId, int? resendToken) {},
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}

// テキスト入力フォームのプリセット
Widget customController(
        {required TextEditingController controller,
        TextInputType keyboardType = TextInputType.text,
        bool obscureText = false,
        String? labelText,
        String? hintText}) =>
    TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: "*",
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
    );

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    // コントローラーの解放
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Scaffold(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // タイトル画像
                        const Image(
                          image: AssetImage(title),
                          width: 240,
                          height: 150,
                        ),
                        const SizedBox(height: 10),

                        // メールアドレス入力フィールド
                        customController(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            labelText: "メールアドレス",
                            hintText: "example@example.com"),
                        const SizedBox(height: 10),
                        // ユーザー名
                        customController(
                            controller: _userNameController,
                            labelText: "ユーザー名",
                            hintText: "food"),
                        const SizedBox(height: 10),
                        // パスワード
                        customController(
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            labelText: "パスワード",
                            hintText: "********"),
                        const SizedBox(height: 10),
                        // 再入力
                        customController(
                            controller: _confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            labelText: "パスワードの確認",
                            hintText: "********"),
                        const SizedBox(height: 10),
                        // 電話番号
                        customController(
                            controller: _phoneNumberController,
                            keyboardType: TextInputType.number,
                            labelText: "電話番号",
                            hintText: "08012345678"),
                        const SizedBox(height: 10),

                        // ログインボタン
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('次へ'),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
