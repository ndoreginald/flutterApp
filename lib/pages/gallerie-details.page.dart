import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GallerieDetailsPage extends StatefulWidget {
  final String keyword;
  GallerieDetailsPage(this.keyword);

  @override
  State<GallerieDetailsPage> createState() => _GallerieDetailsPageState();
}

class _GallerieDetailsPageState extends State<GallerieDetailsPage> {
  int currentPage = 1;
  int size = 10;
  int totalPages = 1;
  ScrollController _scrollController = ScrollController();
  List<dynamic> hits = [];
  var galleryData;

  @override
  void initState() {
    super.initState();
    getGalleryData(widget.keyword);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          getGalleryData(widget.keyword);
        }
      }
    });
  }

  void getGalleryData(String keyword) {
    print("Image de $keyword");
    String url =
        "https://pixabay.com/api/?key=15646595-375eb91b3408e352760ee72c8&q=$keyword&page=$currentPage&per_page=$size";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        galleryData = json.decode(resp.body);
        hits.addAll(galleryData['hits']);
        totalPages = (galleryData['totalHits'] / size).ceil();
        print(hits);
      });
    });
  }

  void goToPreviousPage() {
    if (currentPage > 1) {
      currentPage--;
      hits.clear();
      getGalleryData(widget.keyword);
    }
  }

  void goToNextPage() {
    if (currentPage < totalPages) {
      hits.clear();
      currentPage++;
      getGalleryData(widget.keyword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.keyword,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Text(
              "Page $currentPage/$totalPages",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: galleryData == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: hits.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.blueGrey,
                  elevation: 5,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        hits[index]['tags'],
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Image.network(
                      hits[index]['webformatURL'],
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (currentPage > 1)
              FloatingActionButton(
                onPressed: goToPreviousPage,
                child: Icon(Icons.arrow_back),
                backgroundColor: Colors.blue,
              ),
            SizedBox(width: 10),
            if (currentPage < totalPages)
              FloatingActionButton(
                onPressed: goToNextPage,
                child: Icon(Icons.arrow_forward),
                backgroundColor: Colors.blue,
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
