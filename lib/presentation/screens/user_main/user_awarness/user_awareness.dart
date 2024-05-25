// // ignore_for_file: use_build_context_synchronously
//

import 'package:finalyear/widgets/appBarWithDrawer/user_appbarWithDrawer.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class UserAwareness extends StatefulWidget {
//   const UserAwareness({super.key});

//   @override
//   State<UserAwareness> createState() => _UserAwarenessState();
// }

// class _UserAwarenessState extends State<UserAwareness> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //double screenHeight = MediaQuery.of(context).size.height;
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: UserAppBarWithDrawer(
//         title: 'USER',
//         body: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(top: 10.h, bottom: 16.h),
//                   child: Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       "Today's Awareness",
//                       style: kBodyText2.copyWith(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.bold,
//                         color: const Color(0xFF365307),
//                         letterSpacing: 1,
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Add some text here
//                 Text(
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed condimentum ultricies felis, et blandit nisi fermentum in.",
//                   style: TextStyle(fontSize: 16.sp),
//                 ),
//                 SizedBox(height: 10.h),
//                 Image.asset(
//                   'assets/images/awareness.jpeg',
//                   width: double.infinity,
//                   height: 200.h,
//                   fit: BoxFit.cover,
//                 ),
//                 SizedBox(height: 25.h),
//                 Text(
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed condimentum ultricies felis, et blandit nisi fermentum in.",
//                   style: TextStyle(fontSize: 16.sp),
//                 ),
//                 Text(
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed condimentum ultricies felis, et blandit nisi fermentum in.",
//                   style: TextStyle(fontSize: 16.sp),
//                 ),

//                 Text(
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed condimentum ultricies felis, et blandit nisi fermentum in.",
//                   style: TextStyle(fontSize: 16.sp),
//                 ),
//                 Text(
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed condimentum ultricies felis, et blandit nisi fermentum in.",
//                   style: TextStyle(fontSize: 16.sp),
//                 ),
//                 Text(
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed condimentum ultricies felis, et blandit nisi fermentum in.",
//                   style: TextStyle(fontSize: 16.sp),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class UserAwareness extends StatefulWidget {
  const UserAwareness({super.key});

  @override
  State<UserAwareness> createState() => _UserAwarenessState();
}

class _UserAwarenessState extends State<UserAwareness> {
  Map<String, dynamic> selectedArticle = {};

  final List<Map<String, dynamic>> articles = [
    {
      "title": "Plastic Waste Found in Remote Arctic Wilderness",
      "image": "assets/images/awareness1.jpeg",
      "description":
          "Researchers conducting an expedition in the Arctic wilderness have made a troubling discovery...",
      "published_date": "2024-04-16"
    },
    {
      "title": "New Recycling Program Reduces Landfill Waste by 30%",
      "image": "assets/images/awareness2.png",
      "description":
          "In a significant win for sustainability efforts, a new recycling program implemented in a major urban center has achieved remarkable success...",
      "published_date": "2024-04-15"
    },
    {
      "title": "Air Quality Index Reaches Hazardous Levels in Urban Areas",
      "image": "assets/images/awareness3.jpg",
      "description":
          "Residents of several urban areas are facing a dire health crisis as air quality plummets to hazardous levels. Factors such as vehicle emissions, industrial pollutants, and unfavorable weather patterns have combined to create a toxic smog that poses significant risks to public health. Authorities are urging vulnerable populations, such as children, the elderly, and those with respiratory conditions, to remain indoors and avoid exposure to the hazardous air. Efforts to mitigate the pollution crisis include temporary restrictions on vehicle use, increased enforcement of emissions standards, and public awareness campaigns to encourage sustainable transportation alternatives.",
      "published_date": "2024-04-14"
    },
    {
      "title": "Ocean Cleanup Initiative Removes Tonnes of Plastic Debris",
      "image": "assets/images/awareness4.jpg",
      "description":
          "A large-scale ocean cleanup initiative has achieved a major milestone in the fight against marine plastic pollution. Using innovative technology, including floating barriers and autonomous drones, the project has successfully removed thousands of tonnes of plastic debris from the world's oceans. This significant progress represents a crucial step forward in addressing the widespread environmental damage caused by plastic waste, which threatens marine life, ecosystems, and human health. While challenges remain, including the need for continued funding and global cooperation, initiatives like this offer hope for a cleaner and more sustainable future for our oceans.",
      "published_date": "2024-04-13"
    },
    {
      "title":
          "Study Links Air Pollution to Increased Risk of Respiratory Illness",
      "image": "assets/images/awareness5.jpg",
      "description":
          "A comprehensive study examining the health effects of air pollution has revealed troubling findings regarding its impact on respiratory health. Researchers have established a clear link between exposure to polluted air and an increased risk of respiratory illnesses such as asthma, bronchitis, and chronic obstructive pulmonary disease (COPD). Vulnerable populations, including children, the elderly, and individuals living in urban areas with high levels of pollution, are particularly at risk. Urgent action is needed to address this public health crisis, including stricter regulations on industrial emissions, investment in clean energy alternatives, and improved access to healthcare for affected communities.",
      "published_date": "2024-04-12"
    },
  ];

  @override
  void initState() {
    super.initState();
    selectRandomArticle();
  }

  void selectRandomArticle() {
    final random = Random();
    setState(() {
      selectedArticle = articles[random.nextInt(articles.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: UserAppBarWithDrawer(
        title: 'USER',
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 16.h),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Today's Awareness",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF365307),
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedArticle['title'] ?? '',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Image.asset(
                      selectedArticle['image'] ?? '',
                      width: double.infinity,
                      height: 200.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      selectedArticle['description'] ?? '',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Published Date: ${selectedArticle['published_date'] ?? ''}",
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
