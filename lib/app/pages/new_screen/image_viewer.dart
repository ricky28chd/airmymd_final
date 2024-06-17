import 'dart:io';

import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  final List imageUrls;

  const ImageViewer({super.key, required this.imageUrls});

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Viewer'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.imageUrls.length,
        onPageChanged: (index) {
          print(
            'https://login.airmymd.com/${widget.imageUrls[index].toString().trim()}',
          );
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          return FadeInImage(
            fit: BoxFit.fitWidth,
            placeholder: const AssetImage(
              'assets/images/default_image.png',
            ),
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.file(
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/default_image.png',
                  );
                },
                File(
                  widget.imageUrls[index],
                ),
                fit: BoxFit.fitWidth,
              );
            },
            image: NetworkImage(
              widget.imageUrls[index].toString().startsWith('https:')
                  ? widget.imageUrls[index].toString()
                  : 'https://login.airmymd.com/${widget.imageUrls[index].toString()}',
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < widget.imageUrls.length; i++) {
      indicators.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == i ? Colors.blueAccent : Colors.grey,
          ),
        ),
      );
    }
    return indicators;
  }
}
