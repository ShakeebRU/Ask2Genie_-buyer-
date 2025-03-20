import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';

class ImageGallery extends StatefulWidget {
  final List<String> images;
  final bool isMemoryImage;
  final bool isOpen;
  final double imageHeight;
  final double imageWidth;
  final int lenght;
  final bool deleteable;

  const ImageGallery({
    required this.images,
    required this.isMemoryImage,
    this.isOpen = false,
    required this.deleteable,
    this.imageHeight = 100,
    this.imageWidth = 100,
    this.lenght = 4,
    Key? key,
  }) : super(key: key);

  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  void _deleteImage(String image) {
    widget.images.remove(image); // Remove the image from the list
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Determine the images to display based on the isOpen state
    final displayedImages = widget.isOpen
        ? widget.images
        : widget.images.length > widget.lenght
            ? widget.images.sublist(0, widget.lenght - 1) + ['VIEW_MORE']
            : widget.images;

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: displayedImages.map((image) {
        if (image == 'VIEW_MORE') {
          return _buildViewMore(context);
        } else {
          return _buildImageContainer(context, image);
        }
      }).toList(),
    );
  }

  Widget _buildImageContainer(BuildContext context, String image) {
    return GestureDetector(
      onTap: () {
        if (widget.isOpen) {
          // Open full-page view
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullImageView(
                images: widget.images,
                initialIndex: widget.images.indexOf(image),
                isMemoryImage: widget.isMemoryImage,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GalleryView(
                images: widget.images,
                isMemoryImage: widget.isMemoryImage,
                deleteable: widget.deleteable,
              ),
            ),
          );
        }
      },
      child: Container(
        height: widget.imageHeight,
        width: widget.imageWidth,
        decoration: BoxDecoration(
          border: BorderDirectional(
              bottom: BorderSide(
                  width: 2, color: const Color(0XFFDCDCDC).withOpacity(0.6))),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(0.0),
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8)),
          image: DecorationImage(
            image: widget.isMemoryImage
                ? MemoryImage(base64Decode(image))
                : NetworkImage(
                    image,
                  ),
            fit: BoxFit.cover,
          ),
        ),
        child: widget.isOpen && widget.deleteable
            ? Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _deleteImage(image); // Delete image on button click
                  },
                ),
              )
            : Container(),
      ),
    );
  }

  Widget _buildViewMore(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // Open the gallery when "View More" is tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GalleryView(
                images: widget.images,
                isMemoryImage: widget.isMemoryImage,
                deleteable: widget.deleteable,
              ),
            ),
          );
        });
      },
      child: Container(
        height: widget.imageHeight,
        width: widget.imageWidth,
        child: Center(
          child: Text(
            'View More',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontFamily: GoogleFonts.antic().fontFamily),
          ),
        ),
      ),
    );
  }
}

class GalleryView extends StatelessWidget {
  final bool deleteable;
  final List<String> images;
  final bool isMemoryImage;
  const GalleryView(
      {super.key,
      required this.images,
      required this.isMemoryImage,
      required this.deleteable});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Constants.secondaryColor,
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: height * 0.1,
            width: width * 0.8,
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              height: height * 0.1,
              width: width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 20,
                        width: 20,
                        // margin: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 3,
                                spreadRadius: 1,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(0.0),
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF333333),
                                  Color(0xFF747474)
                                ])),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 13,
                        )),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 2,
                      ),
                      Image.asset(
                        "assets/images/genieLamp.png",
                        height: 48,
                        width: 80,
                        fit: BoxFit.contain,
                      ),
                      const Text(
                        "Ask2Genie",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Jaro',
                            color: Color(0xFFFFC300),
                            height: -0.2,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                    width: 25,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: ImageGallery(
              images: images,
              isMemoryImage: isMemoryImage,
              isOpen: true,
              deleteable: deleteable,
              imageHeight: 100,
              imageWidth: 100,
            ),
          ),
        ],
      )),
    );
  }
}

class FullImageView extends StatelessWidget {
  final List<String> images;
  final int initialIndex;
  final bool isMemoryImage;

  const FullImageView({
    required this.images,
    required this.initialIndex,
    required this.isMemoryImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Constants.secondaryColor,
      // appBar: AppBar(
      //   title: const Text('Image Viewer'),
      // ),
      body: PageView.builder(
        controller: PageController(initialPage: initialIndex),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: height * 0.1,
                width: width * 0.8,
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                  height: height * 0.1,
                  width: width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            height: 20,
                            width: 20,
                            // margin: const EdgeInsets.only(left: 10),
                            decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(0.0),
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF333333),
                                      Color(0xFF747474)
                                    ])),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 13,
                            )),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 2,
                          ),
                          Image.asset(
                            "assets/images/genieLamp.png",
                            height: 48,
                            width: 80,
                            fit: BoxFit.contain,
                          ),
                          const Text(
                            "Ask2Genie",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Jaro',
                                color: Color(0xFFFFC300),
                                height: -0.2,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                        width: 25,
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: isMemoryImage
                    ? Image.memory(
                        base64Decode(image),
                        fit: BoxFit.contain,
                      )
                    : Image.network(
                        image,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 100),
                      ),
              ),
              Container(
                height: height * 0.09,
                width: width * 0.8,
              )
            ],
          );
        },
      ),
    );
  }
}
