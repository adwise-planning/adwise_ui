import 'package:adwise/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class GlobalBackgroundWidget extends StatelessWidget {
  final Widget child;
  final String backgroundImagePath;

  const GlobalBackgroundWidget({
    required this.child,
    required this.backgroundImagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The background image
        Positioned.fill(
          child: Image.asset(
            backgroundImagePath,
            fit: BoxFit.cover,
            color: Colors.black,
            opacity: AlwaysStoppedAnimation(0.5), // Optional: dark overlay for text visibility
            colorBlendMode: BlendMode.darken, // Optional: blend image for readability
          ),
        ),
        // The main content
        Positioned.fill(child: child),
      ],
    );
  }
}


// class GlobalBackgroundWidget extends StatelessWidget {
//   final Widget child;

//   const GlobalBackgroundWidget({super.key, required this.child});


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(AppConstants.backgroundImagePath), // Path to your background image
//           fit: BoxFit.cover, // Adjust the fit as needed
//         ),
//       ),
//       child: child,
//     );
//   }
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Stack(
//   //     children: [
//   //       // Background Image
//   //       SizedBox.expand(
//   //         child: Image.asset(
//   //           AppConstants.backgroundImagePath,
//   //           fit: BoxFit.cover,
//   //           // opacity: AlwaysStoppedAnimation(0.9),
//   //           color: Colors.black,
//   //           // colorBlendMode: BlendMode.difference,
//   //           // colorBlendMode: BlendMode.luminosity,
//   //           // color: Colors.purpleAccent, // Semi-transparent overlay
//   //         ),
//   //       ),
//   //       // The content of the page
//   //       Positioned.fill(child: child),
//   //     ],
//   //   );
//   // }
// }
