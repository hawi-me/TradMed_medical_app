// // lib/presentation/pages/home_page.dart
// import 'package:flutter/material.dart';

// class BlogUi extends StatelessWidget {
//   final BlogController controller = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Herbal Products Blog'),
//       ),
//       body: Obx(() {
//         if (controller.blogPosts.isEmpty) {
//           return Center(child: CircularProgressIndicator());
//         }

//         return ListView.builder(
//           itemCount: controller.blogPosts.length,
//           itemBuilder: (context, index) {
//             final post = controller.blogPosts[index];
//             return Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(post.title, style: TextStyle(fontWeight: FontWeight.bold)),
//                     SizedBox(height: 8),
//                     Image.network(post.imageUrl),
//                     SizedBox(height: 8),
//                     Text(post.content),
//                     SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             // Call reactToPost method
//                           },
//                           child: Text('Like'),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             // Navigate to comment input
//                           },
//                           child: Text('Comment'),
//                         ),
//                       ],
//                     ),
//                     // Display comments
//                     ListView.builder(
//                       itemCount: post.comments.length,
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, commentIndex) {
//                         final comment = post.comments[commentIndex];
//                         return ListTile(
//                           title: Text(comment.content),
//                           subtitle: Text('By: ${comment.userId}'),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
