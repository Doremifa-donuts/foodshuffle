import 'package:flutter/material.dart';
import 'dart:developer'; // ログ出力用
import 'dart:io'; // プラットフォーム判別用 (Android, iOSの確認)
import 'package:qr_code_scanner/qr_code_scanner.dart'; // QRコードスキャナー用ライブラリ

import '../widgets/footer.dart'; // フッターを表示するウィジェット
import '../model/color.dart'; // カラーパス
import '../screens/qr_after.dart'; // QRコードスキャン後のページ

// 状態管理のためのステートを作成
class QrScanView extends StatefulWidget {
  const QrScanView({super.key}); // コンストラクタ

  @override
  QrScanViewState createState() => QrScanViewState();
}

// QrScanViewの状態を管理するクラス
class QrScanViewState extends State<QrScanView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR'); // QRコードビューを識別するキー
  QRViewController? controller; // QRコードスキャナーを制御するコントローラー

  // 再描画時のカメラ制御 (ホットリロード対応)
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera(); // Androidの場合はカメラを一時停止
    }
    controller?.resumeCamera(); // iOSの場合はカメラを再開
  }

  // ウィジェット破棄時の処理 (リソース解放)
  @override
  void dispose() {
    controller?.dispose(); // コントローラーを破棄してリソースを解放
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('QRコードを読み取ろう!'), // アプリバーのタイトル
          backgroundColor: const Color(mainColor), // 背景色 (カスタムテーマ)
          centerTitle: true, // タイトルを中央揃え
        ),
        body: Stack(
          children: [
            buildBackground(), // 背景画像を構築
            _buildQrView(context), // QRコードビューを構築
            // footer を表示
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Footer(),
            ),
          ],
        ));
  }

  // 背景画像の構築
  Widget buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/backimg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // QRコードビューの構築
  Widget _buildQrView(BuildContext context) {
    // デバイスサイズに応じてスキャン領域のサイズを調整
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 280.0 // 小さいデバイスの場合
        : 300.0; // 通常サイズのデバイスの場合

    return QRView(
      key: qrKey, // QRビューを識別するためのキー
      onQRViewCreated: _onQRViewCreated, // QRビュー作成時のコールバック
      overlay: QrScannerOverlayShape(
        // QRコードスキャナーのオーバーレイデザイン
        borderColor: const Color(mainColor), // 枠の色
        borderRadius: 10, // 枠の角の丸み
        borderLength: 30, // 枠の長さ
        borderWidth: 10, // 枠の幅
        cutOutSize: scanArea, // スキャン領域のサイズ
      ),
      onPermissionSet: (ctrl, p) =>
          _onPermissionSet(context, ctrl, p), // パーミッションの確認
    );
  }

  // QRビューが作成された際の処理
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller; // コントローラーを設定
    });
    controller.scannedDataStream.listen((scanData) async {
      // カメラを停止
      controller.stopCamera();

      // スキャン結果をログに出力
      print(scanData.code);

      // ArchivePageに遷移
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ArchivePage(),
        ),
      );
    });
  }

  // パーミッションの状態が変化したときの処理
  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p'); // ログにパーミッション状態を記録
    if (!p) {
      // パーミッションが拒否された場合
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')), // ユーザーに通知
      );
    }
  }
}
