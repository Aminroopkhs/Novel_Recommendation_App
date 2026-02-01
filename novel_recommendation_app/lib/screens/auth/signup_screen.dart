// import 'package:flutter/material.dart';
// import '../../widgets/custom_textfield.dart';
// import '../../widgets/custom_button.dart';
// import '../../services/api_service.dart';
// import '../onboarding/genre_selection_screen.dart';
// import 'dart:ui';

// // ─── Decorative static mini-book ────────────────────────────────────────────
// class _MiniBook extends StatelessWidget {
//   final Color spineColor;
//   final Color coverColor;
//   final double width;
//   final double height;
//   final double rotation;

//   const _MiniBook({
//     required this.spineColor,
//     required this.coverColor,
//     this.width = 28,
//     this.height = 40,
//     this.rotation = 0,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Transform.rotate(
//       angle: rotation,
//       child: Container(
//         width: width,
//         height: height,
//         decoration: BoxDecoration(
//           color: coverColor,
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(3),
//             bottomRight: Radius.circular(3),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.35),
//               blurRadius: 4,
//               offset: const Offset(2, 3),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 5,
//               decoration: BoxDecoration(
//                 color: spineColor,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(3),
//                   bottomLeft: Radius.circular(3),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 1.5,
//                       width: double.infinity,
//                       color: Colors.white.withOpacity(0.25),
//                     ),
//                     const SizedBox(height: 3),
//                     Container(
//                       height: 1.5,
//                       width: width * 0.55,
//                       color: Colors.white.withOpacity(0.18),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ─── Animated floating book ─────────────────────────────────────────────────
// class _FloatingBook extends StatefulWidget {
//   final Color spineColor;
//   final Color coverColor;
//   final double width;
//   final double height;
//   final double rotation;
//   final Duration delay;

//   const _FloatingBook({
//     required this.spineColor,
//     required this.coverColor,
//     this.width = 28,
//     this.height = 40,
//     this.rotation = 0,
//     this.delay = Duration.zero,
//   });

//   @override
//   State<_FloatingBook> createState() => _FloatingBookState();
// }

// class _FloatingBookState extends State<_FloatingBook>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _bobAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 2400),
//     );
//     _bobAnimation = Tween<double>(begin: 0, end: -6).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
//     );
//     Future.delayed(widget.delay, () {
//       if (mounted) _controller.repeat(reverse: true);
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _bobAnimation,
//       builder: (_, child) => Transform.translate(
//         offset: Offset(0, _bobAnimation.value),
//         child: child,
//       ),
//       child: _MiniBook(
//         spineColor: widget.spineColor,
//         coverColor: widget.coverColor,
//         width: widget.width,
//         height: widget.height,
//         rotation: widget.rotation,
//       ),
//     );
//   }
// }

// // ─── SIGNUP SCREEN ──────────────────────────────────────────────────────────
// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF1A0F05), Color(0xFF2B1D0E), Color(0xFF1C1208)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Stack(
//           children: [
//             // ── Subtle radial glow ──────────────────────────────────────────
//             Positioned(
//               top: size.height * 0.22,
//               left: size.width * 0.5 - 160,
//               child: ImageFiltered(
//                 imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60), // ✅ moved here
//                 child: Container(
//                   width: 320,
//                   height: 320,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color(0xFFFFD166).withOpacity(0.06),
//                   ),
//                 ),
//               ),
//             ),

//             // ── Floating books ──────────────────────────────────────────────
//             // Top-left
//             Positioned(
//               top: size.height * 0.07,
//               left: 18,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF5C3D6E),
//                 coverColor: const Color(0xFF7B5EA7),
//                 width: 22,
//                 height: 34,
//                 rotation: -0.18,
//                 delay: const Duration(milliseconds: 100),
//               ),
//             ),
//             Positioned(
//               top: size.height * 0.10,
//               left: 48,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF2E6B4F),
//                 coverColor: const Color(0xFF4A9B72),
//                 width: 18,
//                 height: 28,
//                 rotation: 0.22,
//                 delay: const Duration(milliseconds: 500),
//               ),
//             ),

//             // Top-right
//             Positioned(
//               top: size.height * 0.05,
//               right: 22,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF8B5E3C),
//                 coverColor: const Color(0xFFB07040),
//                 width: 24,
//                 height: 36,
//                 rotation: 0.20,
//                 delay: const Duration(milliseconds: 300),
//               ),
//             ),
//             Positioned(
//               top: size.height * 0.09,
//               right: 54,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF6E3A2E),
//                 coverColor: const Color(0xFFA05A45),
//                 width: 17,
//                 height: 26,
//                 rotation: -0.14,
//                 delay: const Duration(milliseconds: 700),
//               ),
//             ),

//             // Mid-left
//             Positioned(
//               top: size.height * 0.40,
//               left: 12,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF6B4E71),
//                 coverColor: const Color(0xFF9176A0),
//                 width: 20,
//                 height: 30,
//                 rotation: -0.25,
//                 delay: const Duration(milliseconds: 200),
//               ),
//             ),

//             // Mid-right
//             Positioned(
//               top: size.height * 0.44,
//               right: 16,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF4A6741),
//                 coverColor: const Color(0xFF6B9E5D),
//                 width: 21,
//                 height: 32,
//                 rotation: 0.16,
//                 delay: const Duration(milliseconds: 900),
//               ),
//             ),

//             // Bottom-left
//             Positioned(
//               bottom: size.height * 0.09,
//               left: 26,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF3A6B55),
//                 coverColor: const Color(0xFF5AA088),
//                 width: 23,
//                 height: 35,
//                 rotation: 0.18,
//                 delay: const Duration(milliseconds: 600),
//               ),
//             ),
//             Positioned(
//               bottom: size.height * 0.12,
//               left: 56,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF7A4E2D),
//                 coverColor: const Color(0xFFB07848),
//                 width: 16,
//                 height: 25,
//                 rotation: -0.10,
//                 delay: const Duration(milliseconds: 400),
//               ),
//             ),

//             // Bottom-right
//             Positioned(
//               bottom: size.height * 0.07,
//               right: 20,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF5E3D73),
//                 coverColor: const Color(0xFF8562A3),
//                 width: 22,
//                 height: 34,
//                 rotation: -0.20,
//                 delay: const Duration(milliseconds: 800),
//               ),
//             ),
//             Positioned(
//               bottom: size.height * 0.11,
//               right: 52,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF5B7A3A),
//                 coverColor: const Color(0xFF82AD5A),
//                 width: 18,
//                 height: 27,
//                 rotation: 0.24,
//                 delay: const Duration(milliseconds: 150),
//               ),
//             ),

//             // ── Main content ────────────────────────────────────────────────
//             Center(
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Container(
//                     width: 380,
//                     padding: const EdgeInsets.all(32),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.04),
//                       borderRadius: BorderRadius.circular(28),
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.08),
//                         width: 1,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.5),
//                           blurRadius: 40,
//                           offset: const Offset(0, 8),
//                         ),
//                         BoxShadow(
//                           color: const Color(0xFFFFD166).withOpacity(0.04),
//                           blurRadius: 60,
//                           offset: const Offset(0, -10),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         // ── Icon ────────────────────────────────────────
//                         Container(
//                           width: 72,
//                           height: 72,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             gradient: const LinearGradient(
//                               colors: [Color(0xFFFFD166), Color(0xFFE8A832)],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: const Color(
//                                   0xFFFFD166,
//                                 ).withOpacity(0.35),
//                                 blurRadius: 20,
//                                 offset: const Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: const Icon(
//                             Icons.person_add_alt_1,
//                             color: Color(0xFF1C1208),
//                             size: 32,
//                           ),
//                         ),
//                         const SizedBox(height: 20),

//                         // ── Title ───────────────────────────────────────
//                         const Text(
//                           "Create Account",
//                           style: TextStyle(
//                             fontSize: 26,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             letterSpacing: 0.3,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 6),
//                         const Text(
//                           "Start your reading journey today",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.white54,
//                             letterSpacing: 0.2,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),

//                         // ── Decorative divider ──────────────────────────
//                         const SizedBox(height: 24),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               height: 1,
//                               width: 40,
//                               color: Colors.white.withOpacity(0.10),
//                             ),
//                             const SizedBox(width: 10),
//                             _MiniBook(
//                               spineColor: const Color(0xFF2E6B4F),
//                               coverColor: const Color(0xFF4A9B72),
//                               width: 14,
//                               height: 20,
//                               rotation: 0.0,
//                             ),
//                             const SizedBox(width: 6),
//                             _MiniBook(
//                               spineColor: const Color(0xFF8B5E3C),
//                               coverColor: const Color(0xFFB07040),
//                               width: 12,
//                               height: 18,
//                               rotation: -0.06,
//                             ),
//                             const SizedBox(width: 6),
//                             _MiniBook(
//                               spineColor: const Color(0xFF5C3D6E),
//                               coverColor: const Color(0xFF7B5EA7),
//                               width: 14,
//                               height: 20,
//                               rotation: 0.07,
//                             ),
//                             const SizedBox(width: 10),
//                             Container(
//                               height: 1,
//                               width: 40,
//                               color: Colors.white.withOpacity(0.10),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 28),

//                         // ── Name field ──────────────────────────────────
//                         CustomTextField(
//                           hint: "Name",
//                           icon: Icons.person_outline,
//                           controller: nameController,
//                         ),
//                         const SizedBox(height: 14),

//                         // ── Email field ─────────────────────────────────
//                         CustomTextField(
//                           hint: "Email",
//                           icon: Icons.email_outlined,
//                           controller: emailController,
//                         ),
//                         const SizedBox(height: 14),

//                         // ── Password field ──────────────────────────────
//                         CustomTextField(
//                           hint: "Password",
//                           icon: Icons.lock_outline,
//                           obscure: true,
//                           controller: passwordController,
//                         ),
//                         const SizedBox(height: 28),

//                         // ── Sign Up Button ──────────────────────────────
//                         CustomButton(
//                           text: "Sign Up",
//                           onTap: () async {
//                             try {
//                               final result = await ApiService.signup(
//                                 name: nameController.text.trim(),
//                                 email: emailController.text.trim(),
//                                 password: passwordController.text.trim(),
//                               );

//                               final int userId = result["user_id"];

//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) =>
//                                       GenreSelectionScreen(userId: userId),
//                                 ),
//                               );
//                             } catch (e) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text(e.toString())),
//                               );
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'dart:ui';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_button.dart';
import '../../services/api_service.dart';
import '../onboarding/genre_selection_screen.dart';

// ─── PASTEL PALETTE ──────────────────────────────────────────────────────────
class _P {
  static const Color bg          = Color(0xFFF7F3EF);
  static const Color card        = Color(0xFFFFFFFF);
  static const Color rose        = Color(0xFFD4899A);
  static const Color roseSoft    = Color(0xFFF2D5DC);
  static const Color lavender    = Color(0xFFB8A9D9);
  static const Color lavenderSoft= Color(0xFFEDE8F5);
  static const Color mint        = Color(0xFFA3C9B8);
  static const Color mintSoft    = Color(0xFFDCEDE6);
  static const Color peach       = Color(0xFFE8B99A);
  static const Color peachSoft   = Color(0xFFF5E4DA);
  static const Color textPrimary = Color(0xFF3D3047);
  static const Color textHint    = Color(0xFFA89BB5);
}

// ─── Mini book ───────────────────────────────────────────────────────────────
class _MiniBook extends StatelessWidget {
  final Color spineColor;
  final Color coverColor;
  final double width;
  final double height;
  final double rotation;

  const _MiniBook({
    required this.spineColor,
    required this.coverColor,
    this.width = 28,
    this.height = 40,
    this.rotation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: coverColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(3), bottomRight: Radius.circular(3)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 4, offset: const Offset(1.5, 2.5))],
        ),
        child: Row(
          children: [
            Container(
              width: 5,
              decoration: BoxDecoration(
                color: spineColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(3), bottomLeft: Radius.circular(3)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 1.5, width: double.infinity, color: Colors.white.withOpacity(0.55)),
                    const SizedBox(height: 3),
                    Container(height: 1.5, width: width * 0.55, color: Colors.white.withOpacity(0.4)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Animated floating book ─────────────────────────────────────────────────
class _FloatingBook extends StatefulWidget {
  final Color spineColor;
  final Color coverColor;
  final double width;
  final double height;
  final double rotation;
  final Duration delay;

  const _FloatingBook({
    required this.spineColor,
    required this.coverColor,
    this.width = 28,
    this.height = 40,
    this.rotation = 0,
    this.delay = const Duration(),
  });

  @override
  State<_FloatingBook> createState() => _FloatingBookState();
}

class _FloatingBookState extends State<_FloatingBook>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bob;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2800));
    _bob = Tween<double>(begin: 0, end: -5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
    Future.delayed(widget.delay, () { if (mounted) _controller.repeat(reverse: true); });
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bob,
      builder: (_, child) => Transform.translate(offset: Offset(0, _bob.value), child: child),
      child: _MiniBook(
        spineColor: widget.spineColor, coverColor: widget.coverColor,
        width: widget.width, height: widget.height, rotation: widget.rotation,
      ),
    );
  }
}

// ─── Blurred atmosphere blob ────────────────────────────────────────────────
class _Blob extends StatelessWidget {
  final Color color;
  final double size;
  const _Blob({required this.color, this.size = 220});

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 55, sigmaY: 55),
      child: Container(
        width: size, height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(0.38)),
      ),
    );
  }
}

// ─── SIGNUP SCREEN ──────────────────────────────────────────────────────────
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController     = TextEditingController();
  final TextEditingController emailController    = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: _P.bg,
        child: Stack(
          children: [
            // ── Background blobs ──────────────────────────────────────────
            Positioned(top: -65,  right: -65,                         child: _Blob(color: _P.lavenderSoft, size: 240)),
            Positioned(top: size.height * 0.30, left: -85,            child: _Blob(color: _P.roseSoft,     size: 220)),
            Positioned(bottom: -75, right: size.width * 0.2,          child: _Blob(color: _P.peachSoft,    size: 260)),
            Positioned(bottom: size.height * 0.20, right: -50,        child: _Blob(color: _P.mintSoft,     size: 195)),

            // ── Floating books ────────────────────────────────────────────
            Positioned(top: size.height * 0.06,  left: 20,  child: _FloatingBook(spineColor: _P.lavender, coverColor: _P.lavenderSoft, width: 22, height: 34, rotation: -0.18, delay: const Duration(milliseconds: 100))),
            Positioned(top: size.height * 0.10,  left: 50,  child: _FloatingBook(spineColor: _P.mint,     coverColor: _P.mintSoft,     width: 18, height: 28, rotation:  0.22, delay: const Duration(milliseconds: 500))),
            Positioned(top: size.height * 0.04,  right: 24, child: _FloatingBook(spineColor: _P.rose,     coverColor: _P.roseSoft,     width: 24, height: 36, rotation:  0.20, delay: const Duration(milliseconds: 300))),
            Positioned(top: size.height * 0.08,  right: 56, child: _FloatingBook(spineColor: _P.peach,    coverColor: _P.peachSoft,    width: 17, height: 26, rotation: -0.14, delay: const Duration(milliseconds: 700))),
            Positioned(top: size.height * 0.42,  left: 14,  child: _FloatingBook(spineColor: _P.peach,    coverColor: _P.peachSoft,    width: 20, height: 30, rotation: -0.25, delay: const Duration(milliseconds: 200))),
            Positioned(top: size.height * 0.45,  right: 18, child: _FloatingBook(spineColor: _P.mint,     coverColor: _P.mintSoft,     width: 21, height: 32, rotation:  0.16, delay: const Duration(milliseconds: 900))),
            Positioned(bottom: size.height * 0.08, left: 28,  child: _FloatingBook(spineColor: _P.rose,     coverColor: _P.roseSoft,     width: 23, height: 35, rotation:  0.18, delay: const Duration(milliseconds: 600))),
            Positioned(bottom: size.height * 0.12, left: 58,  child: _FloatingBook(spineColor: _P.lavender, coverColor: _P.lavenderSoft, width: 16, height: 25, rotation: -0.10, delay: const Duration(milliseconds: 400))),
            Positioned(bottom: size.height * 0.06, right: 22, child: _FloatingBook(spineColor: _P.peach,    coverColor: _P.peachSoft,    width: 22, height: 34, rotation: -0.20, delay: const Duration(milliseconds: 800))),
            Positioned(bottom: size.height * 0.11, right: 54, child: _FloatingBook(spineColor: _P.mint,     coverColor: _P.mintSoft,     width: 18, height: 27, rotation:  0.24, delay: const Duration(milliseconds: 150))),

            // ── Card ──────────────────────────────────────────────────────
            Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: 380,
                    padding: const EdgeInsets.all(34),
                    decoration: BoxDecoration(
                      color: _P.card,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 30, offset: const Offset(0, 8)),
                        BoxShadow(color: _P.lavender.withOpacity(0.08), blurRadius: 40, offset: const Offset(0, -4)),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo
                        Container(
                          width: 74, height: 74,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [_P.lavenderSoft, _P.mintSoft], begin: Alignment.topLeft, end: Alignment.bottomRight),
                            boxShadow: [BoxShadow(color: _P.lavender.withOpacity(0.22), blurRadius: 16, offset: const Offset(0, 4))],
                          ),
                          child: Icon(Icons.person_add_alt_1, color: _P.lavender, size: 32),
                        ),
                        const SizedBox(height: 20),

                        // Title
                        Text("Create Account", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: _P.textPrimary, letterSpacing: -0.3), textAlign: TextAlign.center),
                        const SizedBox(height: 6),
                        Text("Start your reading journey today", style: TextStyle(fontSize: 14, color: _P.textHint, letterSpacing: 0.1), textAlign: TextAlign.center),

                        // Book divider
                        const SizedBox(height: 22),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(height: 1, width: 36, color: _P.textHint.withOpacity(0.3)),
                            const SizedBox(width: 10),
                            _MiniBook(spineColor: _P.mint,     coverColor: _P.mintSoft,     width: 13, height: 19),
                            const SizedBox(width: 5),
                            _MiniBook(spineColor: _P.rose,     coverColor: _P.roseSoft,     width: 11, height: 17, rotation: -0.06),
                            const SizedBox(width: 5),
                            _MiniBook(spineColor: _P.lavender, coverColor: _P.lavenderSoft, width: 13, height: 19, rotation:  0.07),
                            const SizedBox(width: 10),
                            Container(height: 1, width: 36, color: _P.textHint.withOpacity(0.3)),
                          ],
                        ),
                        const SizedBox(height: 28),

                        // Fields
                        CustomTextField(hint: "Name",     icon: Icons.person_outline,  controller: nameController),
                        const SizedBox(height: 14),
                        CustomTextField(hint: "Email",    icon: Icons.email_outlined,  controller: emailController),
                        const SizedBox(height: 14),
                        CustomTextField(hint: "Password", icon: Icons.lock_outline,    controller: passwordController, obscure: true),
                        const SizedBox(height: 28),

                        // Sign Up button
                        CustomButton(
                          text: "Sign Up",
                          onTap: () async {
                            try {
                              final result = await ApiService.signup(
                                name:     nameController.text.trim(),
                                email:    emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                              final int userId = result["user_id"];
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (_) => GenreSelectionScreen(userId: userId),
                              ));
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
