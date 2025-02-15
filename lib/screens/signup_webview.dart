import 'package:flutter/material.dart';
import 'package:foodshuffle/api/urls.dart';
import 'package:foodshuffle/api/websocket.dart';
import 'package:foodshuffle/screens/animation.dart';
import 'package:foodshuffle/utils/pref_helper.dart';
import 'package:foodshuffle/widgets/page_template.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SignupWebViewPage extends StatelessWidget {
  const SignupWebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WebViewController controller = WebViewController()
      ..loadRequest(Uri.parse(Urls.signup))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('JtiTokenChannel',
          onMessageReceived: (message) async {
        debugPrint("受け取ったメッセージ");
        debugPrint(message.message);
        await PrefHelper().SetJWT(message.message);
        WebSocketService().connect(message.message);
        // ログイン処理成功時に遷移
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const AnimationPage(),
          ),
          (route) => false,
        );
      })
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('progress: $progress');
          },
          onPageStarted: (String url) {
            debugPrint('page started: $url');
          },
          onPageFinished: (String url) {
            debugPrint('page finished: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('error: $error');
          },
          onNavigationRequest: (NavigationRequest request) {
            // 最初に開いたURL以外への遷移を防ぐ
            // if (request.url != Urls.signup) {
            //   return NavigationDecision.prevent; // 遷移を防ぐ
            // }
            return NavigationDecision.navigate; // 遷移を許可
          },
        ),
      );
    return PageTemplate(
      pageTitle: 'アカウント登録',
      onDispose: () async {
        await controller.clearCache();
      },
      displayFooter: false,
      child: Column(
        children: [
          Expanded(
            child: WebViewWidget(
              controller: controller,
            ),
          ),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: IconButton(
                //     onPressed: () {
                //       controller.goBack();
                //     },
                //     icon: const Icon(
                //       Icons.arrow_back_ios,
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: IconButton(
                //     onPressed: () {
                //       controller.goForward();
                //     },
                //     icon: const Icon(
                //       Icons.arrow_forward_ios,
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      controller.reload();
                    },
                    icon: const Icon(
                      Icons.replay,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
