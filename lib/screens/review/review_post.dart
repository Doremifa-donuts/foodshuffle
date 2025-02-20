// import 'package:flutter/material.dart';
// import 'package:foodshuffle/api/urls.dart';
// import 'package:foodshuffle/model/visited_store/visited_store.dart';
// import 'package:foodshuffle/utils/pref_helper.dart';
// // httpリクエスト用のモジュール
// import 'package:http/http.dart' as http;
// // jsonDecodeを有効化
// import 'dart:convert';
// //画像を複数選択するためのモジュール
// import 'package:image_picker/image_picker.dart';

// class ReviewWritePage extends StatefulWidget {
//   final VisitedStore store;
//   const ReviewWritePage({required this.store, super.key});

//   @override
//   createState() => _ReviewWritePageState();
// }

// // レビュー書き込み画面
// class _ReviewWritePageState extends State<ReviewWritePage> {
//   final TextEditingController _reviewController = TextEditingController();
//   final List<XFile> _selectedImages = [];

//   Future<void> pickImages() async {
//     final ImagePicker picker = ImagePicker();
//     final List<XFile> images = await picker.pickMultiImage();
//     if (images.isEmpty) {
//       setState(() {
//         _selectedImages.addAll(images);
//       });
//     }
//   }

//   // レビュー書き込み画面を表示
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // ページタイトルに店舗名を表示
//         title: Text('レビューを書く: ${widget.store.RestaurantName}'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0), // 余白を設定
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 店舗名を表示
//             Text(
//               '店舗名: ${widget.store.RestaurantName}',
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8), // 縦方向の余白
//             // 店舗住所を表示
//             Text('住所: ${widget.store.Address}'),
//             const SizedBox(height: 16),
//             // レビュー入力用のテキストフィールド
//             TextField(
//               controller: _reviewController,
//               decoration: const InputDecoration(
//                 labelText: 'レビュー内容', // ラベルテキスト
//                 border: OutlineInputBorder(), // 枠線を設定
//               ),
//               maxLines: 5, // 複数行入力
//             ),
//             const SizedBox(height: 16),
//             // 保存ボタン
//             ElevatedButton(
//               onPressed: () async {
//                 // 保存処理（後で実装）をここに記述
//                 if (_reviewController.text.isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('レビュー内容を入力してください'),
//                     ),
//                   );
//                   return;
//                 }
//                 try {
//                   final token = await PrefHelper().GetJWT();

//                   if (token == null) {
//                     throw Exception('token is null');
//                   } else {
//                     // httpリクエストでレビューを書き込む
//                     final request = http.MultipartRequest(
//                         'POST', Uri.parse(Urls.postReview));

//                     // リクエストヘッダー
//                     request.headers.addAll({
//                       'Authorization': 'Bearer $token',
//                       'Accept': 'application/json',
//                     });

//                     // リクエストボディ
//                     final Map<String, dynamic> data = {
//                       'RestaurantUuid': widget.store.RestaurantUuid,
//                       'Comment': _reviewController.text,
//                     };
//                     request.fields['data'] = jsonEncode(data);
//                     // 画像を追加
//                     for (XFile image in _selectedImages) {
//                       request.files.add(await http.MultipartFile.fromPath(
//                         'images[]',
//                         image.path,
//                       ));
//                     }
//                     // リクエストを送信
//                     final response = await request.send();

//                     // レスポンスを処理(JSONに変換)
//                     final responseBody = await response.stream.bytesToString();
//                     final responseJson = jsonDecode(responseBody);

//                     switch (responseJson['Response']['Status']) {
//                       case 'OK':
//                         //共有するレビューを指定(今回は投稿したレビューを指定)
//                         final shareReviewResponse = await http.put(
//                           Uri.parse(Urls.setReview),
//                           headers: {
//                             'Content-Type': 'application/json',
//                             'Accept': 'application/json',
//                             'Authorization': 'Bearer $token',
//                           },
//                           body: jsonEncode({
//                             'FirstReviewUuid': responseJson['Response']['Data']
//                                 ['ReviewUuid'],
//                           }),
//                         );
//                         final shareReviewResponseBody =
//                             jsonDecode(shareReviewResponse.body);
//                         if (shareReviewResponseBody['Response']['Status'] ==
//                             'OK') {
//                           Navigator.pop(context); // 保存後、前のページに戻る
//                           break;
//                         }
//                       default: //接続に失敗した場合
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('通信エラー'),
//                           ),
//                         );
//                         break;
//                     }
//                   }
//                 } catch (e) {
//                   debugPrint(e.toString());
//                 }
//               },
//               child: const Text('保存'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
