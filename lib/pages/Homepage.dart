import 'package:flutter/material.dart';
import 'package:newsmvc/models/newsinfo.dart';
import 'package:newsmvc/services/api_manager.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<NewsModel> _newsModel;
  @override
  void initState() {
    // TODO: implement initState
    _newsModel = API_Manager().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News MVC app"),
      ),
      body: Container(
        child:FutureBuilder<NewsModel>(
          future: _newsModel,
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.articles.length,
                  itemBuilder: (context, index) {
                    var arcticle=snapshot.data.articles[index];

                    return Container(
                    height: 100,
                    child: Row(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                         child: AspectRatio(
                           aspectRatio: 1,
                           child: Image.network(
                             arcticle.urlToImage,
                           ),

                         ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                arcticle.title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                arcticle.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        )
                      ],
                    ));
              });
            }else {
              return Center(child:   new CircularProgressIndicator());
            }

          },
        ),
      ),
    );
  }
}
