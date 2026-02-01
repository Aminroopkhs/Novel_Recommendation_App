// import 'package:flutter/material.dart';
// import '../../services/api_service.dart';
// import '../home/home_screen.dart';
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

// // ─── Genre data model with icon + accent color ─────────────────────────────
// class _GenreItem {
//   final String name;
//   final IconData icon;
//   final Color accentColor;

//   const _GenreItem({
//     required this.name,
//     required this.icon,
//     required this.accentColor,
//   });
// }

// // ─── GENRE SELECTION SCREEN ─────────────────────────────────────────────────
// class GenreSelectionScreen extends StatefulWidget {
//   final int userId;

//   const GenreSelectionScreen({super.key, required this.userId});

//   @override
//   State<GenreSelectionScreen> createState() => _GenreSelectionScreenState();
// }

// class _GenreSelectionScreenState extends State<GenreSelectionScreen> {
//   final List<_GenreItem> genres = const [
//     _GenreItem(
//       name: "Romance",
//       icon: Icons.favorite,
//       accentColor: Color(0xFFE05A7A),
//     ),
//     _GenreItem(
//       name: "Comedy",
//       icon: Icons.mood,
//       accentColor: Color(0xFFFFA94D),
//     ),
//     _GenreItem(
//       name: "Horror",
//       icon: Icons.nightlight,
//       accentColor: Color(0xFF9B59B6),
//     ),
//     _GenreItem(
//       name: "Science Fiction",
//       icon: Icons.public,
//       accentColor: Color(0xFF52B4E0),
//     ),
//     _GenreItem(
//       name: "Mystery",
//       icon: Icons.search,
//       accentColor: Color(0xFF6BAF6B),
//     ),
//   ];

//   final Set<String> selectedGenres = {};

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
//             // ── Radial glow ───────────────────────────────────────────────
//             Positioned(
//               top: size.height * 0.15,
//               left: size.width * 0.5 - 180,
//               child: ImageFiltered(
//                   imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60), // ✅ moved here
//                   child: Container(
//                     width: 320,
//                     height: 320,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Color(0xFFFFD166).withOpacity(0.06),
//                     ),
//                   ),
//                 ),
//             ),

//             // ── Floating books ────────────────────────────────────────────
//             Positioned(
//               top: size.height * 0.06,
//               left: 20,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF8B5E3C),
//                 coverColor: const Color(0xFFB07040),
//                 width: 22,
//                 height: 34,
//                 rotation: -0.20,
//                 delay: const Duration(milliseconds: 0),
//               ),
//             ),
//             Positioned(
//               top: size.height * 0.09,
//               left: 50,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF5C3D6E),
//                 coverColor: const Color(0xFF7B5EA7),
//                 width: 18,
//                 height: 28,
//                 rotation: 0.14,
//                 delay: const Duration(milliseconds: 400),
//               ),
//             ),
//             Positioned(
//               top: size.height * 0.05,
//               right: 24,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF2E6B4F),
//                 coverColor: const Color(0xFF4A9B72),
//                 width: 24,
//                 height: 36,
//                 rotation: 0.22,
//                 delay: const Duration(milliseconds: 200),
//               ),
//             ),
//             Positioned(
//               top: size.height * 0.08,
//               right: 56,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF6E3A2E),
//                 coverColor: const Color(0xFFA05A45),
//                 width: 17,
//                 height: 26,
//                 rotation: -0.12,
//                 delay: const Duration(milliseconds: 600),
//               ),
//             ),
//             Positioned(
//               bottom: size.height * 0.08,
//               left: 28,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF5B7A3A),
//                 coverColor: const Color(0xFF82AD5A),
//                 width: 21,
//                 height: 33,
//                 rotation: 0.18,
//                 delay: const Duration(milliseconds: 500),
//               ),
//             ),
//             Positioned(
//               bottom: size.height * 0.11,
//               left: 58,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF7A4E2D),
//                 coverColor: const Color(0xFFB07848),
//                 width: 16,
//                 height: 25,
//                 rotation: -0.08,
//                 delay: const Duration(milliseconds: 800),
//               ),
//             ),
//             Positioned(
//               bottom: size.height * 0.07,
//               right: 22,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF5E3D73),
//                 coverColor: const Color(0xFF8562A3),
//                 width: 23,
//                 height: 35,
//                 rotation: -0.22,
//                 delay: const Duration(milliseconds: 100),
//               ),
//             ),
//             Positioned(
//               bottom: size.height * 0.12,
//               right: 54,
//               child: _FloatingBook(
//                 spineColor: const Color(0xFF3A6B55),
//                 coverColor: const Color(0xFF5AA088),
//                 width: 18,
//                 height: 27,
//                 rotation: 0.26,
//                 delay: const Duration(milliseconds: 700),
//               ),
//             ),

//             // ── Main content ──────────────────────────────────────────────
//             Column(
//               children: [
//                 // ── Custom AppBar ───────────────────────────────────────
//                 Container(
//                   padding: const EdgeInsets.only(
//                     top: 56,
//                     left: 24,
//                     right: 24,
//                     bottom: 16,
//                   ),
//                   child: Row(
//                     children: [
//                       // Back button (optional, keeps navigation consistent)
//                       IconButton(
//                         onPressed: () => Navigator.pop(context),
//                         icon: const Icon(
//                           Icons.arrow_back_ios_new_rounded,
//                           color: Colors.white70,
//                           size: 22,
//                         ),
//                         padding: EdgeInsets.zero,
//                         constraints: const BoxConstraints(),
//                       ),
//                       const SizedBox(width: 12),
//                       const Text(
//                         "Choose Genres",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           letterSpacing: 0.2,
//                         ),
//                       ),
//                       const Spacer(),
//                       // Small book decoration in appbar
//                       _MiniBook(
//                         spineColor: const Color(0xFF8B5E3C),
//                         coverColor: const Color(0xFFB07040),
//                         width: 16,
//                         height: 22,
//                         rotation: -0.1,
//                       ),
//                     ],
//                   ),
//                 ),

//                 // ── Header card ─────────────────────────────────────────
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.04),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.08),
//                         width: 1,
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         // Icon
//                         Container(
//                           width: 56,
//                           height: 56,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             gradient: const LinearGradient(
//                               colors: [Color(0xFFFFD166), Color(0xFFE8A832)],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: const Color(0xFFFFD166).withOpacity(0.3),
//                                 blurRadius: 16,
//                                 offset: const Offset(0, 3),
//                               ),
//                             ],
//                           ),
//                           child: const Icon(
//                             Icons.library_books_outlined,
//                             color: Color(0xFF1C1208),
//                             size: 26,
//                           ),
//                         ),
//                         const SizedBox(height: 14),
//                         const Text(
//                           "What do you love to read?",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             letterSpacing: 0.2,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 6),
//                         const Text(
//                           "Pick your favourites so we can personalise your recommendations",
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.white54,
//                             height: 1.5,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),

//                         // Decorative mini books
//                         const SizedBox(height: 16),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               height: 1,
//                               width: 30,
//                               color: Colors.white.withOpacity(0.10),
//                             ),
//                             const SizedBox(width: 8),
//                             _MiniBook(
//                               spineColor: const Color(0xFF6E3A2E),
//                               coverColor: const Color(0xFFA05A45),
//                               width: 12,
//                               height: 18,
//                             ),
//                             const SizedBox(width: 5),
//                             _MiniBook(
//                               spineColor: const Color(0xFF2E6B4F),
//                               coverColor: const Color(0xFF4A9B72),
//                               width: 10,
//                               height: 16,
//                               rotation: 0.05,
//                             ),
//                             const SizedBox(width: 5),
//                             _MiniBook(
//                               spineColor: const Color(0xFF5C3D6E),
//                               coverColor: const Color(0xFF7B5EA7),
//                               width: 12,
//                               height: 18,
//                               rotation: -0.04,
//                             ),
//                             const SizedBox(width: 8),
//                             Container(
//                               height: 1,
//                               width: 30,
//                               color: Colors.white.withOpacity(0.10),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 24),

//                 // ── Genre chips ─────────────────────────────────────────
//                 Expanded(
//                   child: SingleChildScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     padding: const EdgeInsets.symmetric(horizontal: 24),
//                     child: Wrap(
//                       spacing: 12,
//                       runSpacing: 12,
//                       children: genres.map((genre) {
//                         final isSelected = selectedGenres.contains(genre.name);
//                         return AnimatedContainer(
//                           duration: const Duration(milliseconds: 250),
//                           curve: Curves.easeOutCubic,
//                           decoration: BoxDecoration(
//                             color: isSelected
//                                 ? genre.accentColor.withOpacity(0.18)
//                                 : Colors.white.withOpacity(0.05),
//                             borderRadius: BorderRadius.circular(50),
//                             border: Border.all(
//                               color: isSelected
//                                   ? genre.accentColor.withOpacity(0.6)
//                                   : Colors.white.withOpacity(0.10),
//                               width: 1.5,
//                             ),
//                             boxShadow: isSelected
//                                 ? [
//                                     BoxShadow(
//                                       color: genre.accentColor.withOpacity(0.2),
//                                       blurRadius: 12,
//                                       offset: const Offset(0, 2),
//                                     ),
//                                   ]
//                                 : [],
//                           ),
//                           child: InkWell(
//                             onTap: () {
//                               setState(() {
//                                 if (isSelected) {
//                                   selectedGenres.remove(genre.name);
//                                 } else {
//                                   selectedGenres.add(genre.name);
//                                 }
//                               });
//                             },
//                             borderRadius: BorderRadius.circular(50),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 20,
//                                 vertical: 12,
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   AnimatedContainer(
//                                     duration: const Duration(milliseconds: 250),
//                                     curve: Curves.easeOutCubic,
//                                     child: Icon(
//                                       genre.icon,
//                                       size: 18,
//                                       color: isSelected
//                                           ? genre.accentColor
//                                           : Colors.white38,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     genre.name,
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: isSelected
//                                           ? FontWeight.w600
//                                           : FontWeight.w400,
//                                       color: isSelected
//                                           ? Colors.white
//                                           : Colors.white60,
//                                       letterSpacing: 0.2,
//                                     ),
//                                   ),
//                                   if (isSelected) ...[
//                                     const SizedBox(width: 8),
//                                     Icon(
//                                       Icons.check_rounded,
//                                       size: 16,
//                                       color: genre.accentColor,
//                                     ),
//                                   ],
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),

//                 // ── Continue Button ───────────────────────────────────
//                 Padding(
//                   padding: const EdgeInsets.all(24),
//                   child: AnimatedOpacity(
//                     opacity: selectedGenres.isNotEmpty ? 1.0 : 0.4,
//                     duration: const Duration(milliseconds: 300),
//                     child: Container(
//                       width: double.infinity,
//                       height: 54,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         gradient: selectedGenres.isNotEmpty
//                             ? const LinearGradient(
//                                 colors: [Color(0xFFFFD166), Color(0xFFE8A832)],
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.centerRight,
//                               )
//                             : null,
//                         color: selectedGenres.isEmpty
//                             ? Colors.white.withOpacity(0.08)
//                             : null,
//                         boxShadow: selectedGenres.isNotEmpty
//                             ? [
//                                 BoxShadow(
//                                   color: const Color(
//                                     0xFFFFD166,
//                                   ).withOpacity(0.3),
//                                   blurRadius: 18,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ]
//                             : [],
//                       ),
//                       child: InkWell(
//                         onTap: selectedGenres.isEmpty
//                             ? null
//                             : () async {
//                                 await ApiService.saveUserGenres(
//                                   widget.userId,
//                                   selectedGenres.toList(),
//                                 );

//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => const HomeScreen(),
//                                   ),
//                                 );
//                               },
//                         borderRadius: BorderRadius.circular(16),
//                         child: Center(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Continue",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: selectedGenres.isNotEmpty
//                                       ? const Color(0xFF1C1208)
//                                       : Colors.white38,
//                                   letterSpacing: 0.5,
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               Icon(
//                                 Icons.arrow_forward_rounded,
//                                 size: 20,
//                                 color: selectedGenres.isNotEmpty
//                                     ? const Color(0xFF1C1208)
//                                     : Colors.white38,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'dart:ui';
import '../../services/api_service.dart';
import '../home/home_screen.dart';

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
  static const Color sky         = Color(0xFF9DC4E0);
  static const Color skySoft     = Color(0xFFDCECF5);
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

// ─── Genre data model ───────────────────────────────────────────────────────
class _GenreItem {
  final String   name;
  final IconData icon;
  final Color    accent;     // pastel accent (stronger)
  final Color    accentSoft; // pastel accent (very light bg fill)

  const _GenreItem({ required this.name, required this.icon, required this.accent, required this.accentSoft });
}

// ─── GENRE SELECTION SCREEN ─────────────────────────────────────────────────
class GenreSelectionScreen extends StatefulWidget {
  final int userId;
  const GenreSelectionScreen({super.key, required this.userId});

  @override
  State<GenreSelectionScreen> createState() => _GenreSelectionScreenState();
}

class _GenreSelectionScreenState extends State<GenreSelectionScreen> {
  final List<_GenreItem> genres = const [
    _GenreItem(name: "Romance",        icon: Icons.favorite,          accent: _P.rose,      accentSoft: _P.roseSoft),
    _GenreItem(name: "Comedy",         icon: Icons.mood,              accent: _P.peach,     accentSoft: _P.peachSoft),
    _GenreItem(name: "Horror",         icon: Icons.nightlight,        accent: _P.lavender,  accentSoft: _P.lavenderSoft),
    _GenreItem(name: "Science Fiction",icon: Icons.public,            accent: _P.sky,       accentSoft: _P.skySoft),
    _GenreItem(name: "Mystery",        icon: Icons.search,            accent: _P.mint,      accentSoft: _P.mintSoft),
  ];

  final Set<String> selectedGenres = {};

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
            // ── Blobs ───────────────────────────────────────────────────
            Positioned(top: -60,  left: size.width * 0.3,             child: _Blob(color: _P.skySoft,      size: 230)),
            Positioned(top: size.height * 0.35, left: -75,            child: _Blob(color: _P.roseSoft,     size: 210)),
            Positioned(bottom: -70, right: -60,                       child: _Blob(color: _P.mintSoft,     size: 250)),
            Positioned(bottom: size.height * 0.3, left: size.width * 0.5, child: _Blob(color: _P.peachSoft, size: 180)),

            // ── Floating books ──────────────────────────────────────────
            Positioned(top: size.height * 0.03,  left: 22,  child: _FloatingBook(spineColor: _P.rose,     coverColor: _P.roseSoft,     width: 22, height: 34, rotation: -0.18, delay: const Duration(milliseconds: 0))),
            Positioned(top: size.height * 0.07,  left: 52,  child: _FloatingBook(spineColor: _P.sky,      coverColor: _P.skySoft,      width: 17, height: 27, rotation:  0.15, delay: const Duration(milliseconds: 400))),
            Positioned(top: size.height * 0.02,  right: 26, child: _FloatingBook(spineColor: _P.mint,     coverColor: _P.mintSoft,     width: 23, height: 35, rotation:  0.20, delay: const Duration(milliseconds: 200))),
            Positioned(top: size.height * 0.06,  right: 58, child: _FloatingBook(spineColor: _P.peach,    coverColor: _P.peachSoft,    width: 16, height: 26, rotation: -0.12, delay: const Duration(milliseconds: 600))),
            Positioned(bottom: size.height * 0.07, left: 30,  child: _FloatingBook(spineColor: _P.lavender, coverColor: _P.lavenderSoft, width: 21, height: 33, rotation:  0.18, delay: const Duration(milliseconds: 500))),
            Positioned(bottom: size.height * 0.11, left: 60,  child: _FloatingBook(spineColor: _P.peach,    coverColor: _P.peachSoft,    width: 15, height: 24, rotation: -0.08, delay: const Duration(milliseconds: 800))),
            Positioned(bottom: size.height * 0.06, right: 24, child: _FloatingBook(spineColor: _P.rose,     coverColor: _P.roseSoft,     width: 22, height: 34, rotation: -0.22, delay: const Duration(milliseconds: 100))),
            Positioned(bottom: size.height * 0.10, right: 56, child: _FloatingBook(spineColor: _P.sky,      coverColor: _P.skySoft,      width: 17, height: 27, rotation:  0.25, delay: const Duration(milliseconds: 700))),

            // ── Main layout ─────────────────────────────────────────────
            Column(
              children: [
                // ── Top bar ───────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.only(top: 58, left: 24, right: 24, bottom: 12),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios_new_rounded, color: _P.textPrimary, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 10),
                      Text("Choose Genres", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _P.textPrimary, letterSpacing: -0.2)),
                      const Spacer(),
                      _MiniBook(spineColor: _P.rose, coverColor: _P.roseSoft, width: 15, height: 21, rotation: -0.08),
                    ],
                  ),
                ),

                // ── Header card ───────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: _P.card,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 4))],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 56, height: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [_P.mintSoft, _P.skySoft], begin: Alignment.topLeft, end: Alignment.bottomRight),
                            boxShadow: [BoxShadow(color: _P.mint.withOpacity(0.2), blurRadius: 14, offset: const Offset(0, 3))],
                          ),
                          child: Icon(Icons.library_books_outlined, color: _P.mint, size: 26),
                        ),
                        const SizedBox(height: 14),
                        Text("What do you love to read?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _P.textPrimary, letterSpacing: -0.2), textAlign: TextAlign.center),
                        const SizedBox(height: 6),
                        Text("Pick your favourites so we can personalise\nyour recommendations",
                          style: TextStyle(fontSize: 13, color: _P.textHint, height: 1.55), textAlign: TextAlign.center),

                        // Mini book row
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(height: 1, width: 28, color: _P.textHint.withOpacity(0.3)),
                            const SizedBox(width: 8),
                            _MiniBook(spineColor: _P.peach,    coverColor: _P.peachSoft,    width: 11, height: 17),
                            const SizedBox(width: 5),
                            _MiniBook(spineColor: _P.mint,     coverColor: _P.mintSoft,     width: 10, height: 16, rotation:  0.05),
                            const SizedBox(width: 5),
                            _MiniBook(spineColor: _P.lavender, coverColor: _P.lavenderSoft, width: 11, height: 17, rotation: -0.04),
                            const SizedBox(width: 8),
                            Container(height: 1, width: 28, color: _P.textHint.withOpacity(0.3)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // ── Genre chips ─────────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: genres.map((genre) {
                        final bool sel = selectedGenres.contains(genre.name);
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutCubic,
                          decoration: BoxDecoration(
                            color: sel ? genre.accentSoft : _P.card,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: sel ? genre.accent.withOpacity(0.5) : _P.textHint.withOpacity(0.2),
                              width: 1.5,
                            ),
                            boxShadow: sel
                                ? [BoxShadow(color: genre.accent.withOpacity(0.18), blurRadius: 10, offset: const Offset(0, 2))]
                                : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (sel) selectedGenres.remove(genre.name);
                                else     selectedGenres.add(genre.name);
                              });
                            },
                            borderRadius: BorderRadius.circular(50),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(genre.icon, size: 18, color: sel ? genre.accent : _P.textHint),
                                  const SizedBox(width: 8),
                                  Text(genre.name, style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: sel ? FontWeight.w600 : FontWeight.w400,
                                    color: sel ? _P.textPrimary : _P.textHint,
                                    letterSpacing: 0.1,
                                  )),
                                  if (sel) ...[
                                    const SizedBox(width: 8),
                                    Icon(Icons.check_rounded, size: 16, color: genre.accent),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // ── Continue button ───────────────────────────────────
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: AnimatedOpacity(
                    opacity: selectedGenres.isNotEmpty ? 1.0 : 0.45,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: selectedGenres.isNotEmpty
                            ? LinearGradient(colors: [_P.rose, _P.lavender], begin: Alignment.centerLeft, end: Alignment.centerRight)
                            : null,
                        color: selectedGenres.isEmpty ? _P.textHint.withOpacity(0.15) : null,
                        boxShadow: selectedGenres.isNotEmpty
                            ? [BoxShadow(color: _P.rose.withOpacity(0.28), blurRadius: 18, offset: const Offset(0, 5))]
                            : [],
                      ),
                      child: InkWell(
                        onTap: selectedGenres.isEmpty ? null : () async {
                          await ApiService.saveUserGenres(widget.userId, selectedGenres.toList());
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Continue", style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: selectedGenres.isNotEmpty ? Colors.white : _P.textHint,
                                letterSpacing: 0.4,
                              )),
                              const SizedBox(width: 8),
                              Icon(Icons.arrow_forward_rounded, size: 20,
                                color: selectedGenres.isNotEmpty ? Colors.white : _P.textHint),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}