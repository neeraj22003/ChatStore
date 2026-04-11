import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/search/data/search_repo.dart';
import 'package:flutter_experiments/features/search/domain/search_item_domain.dart';

import 'package:flutter_experiments/features/search/ui/provider/bottomsheet_provider.dart';
import 'package:flutter_experiments/features/search/ui/widgets/+-button.dart';

import 'package:provider/provider.dart';

import 'package:html/parser.dart' as parserhtml;

class CustomBottommodalSheet {
  String truncateword(String title) {
    return title.split(" ").take(3).join(" ");
  }

  Future<void> sheet(
    BuildContext context,
    SearchDomain items,
    BottomsheetProvider provider,
  ) {
    final fetchitem = SearchRepo().getdetails(items.itemId);

    Widget image(String image) {
      return Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(image)),
        ),
      );
    }

    Widget titletext(String title) {
      return Center(
        child: Text(
          truncateword(title),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    String htmlparsing(String? description) {
      final htmlparser = parserhtml.parse(description);
      return htmlparser.body!.text.trim();
    }

    Widget description(String? description) {
      final htmlparse = htmlparsing(description);

      return AnimatedCrossFade(
        firstChild: Text(htmlparse, maxLines: 3),
        secondChild: Text(htmlparse),
        crossFadeState: provider.expanded
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 200),
      );
    }

    Widget readmore(String? descript) {
      return Consumer<BottomsheetProvider>(
        builder: (context, provide, child) {
          return Column(
            children: [
              description(descript),
              Align(
                alignment: Alignment(-1.05, 1),
                child: TextButton(
                  onPressed: provide.onpress,
                  child: provider.expanded == false
                      ? Text('Read more')
                      : Text("Read less"),
                ),
              ),
            ],
          );
        },
      );
    }

    Widget reactivebox() {
      if (Platform.isAndroid || Platform.isIOS) {
        return const SizedBox(height: 100);
      }
      return const SizedBox(height: 0);
    }

    Widget sheet(SearchDomain detail) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            alignment: WrapAlignment.start,
            children: [
              titletext(detail.title),
              readmore(detail.description),
              image(detail.imageUrl),
              Additionbuttonlist(item: detail),
              reactivebox(),
            ],
          ),
        ),
      );
    }

    return showModalBottomSheet(
      clipBehavior: Clip.hardEdge,
      context: context,
      builder: (context) {
        final media = MediaQuery.of(context).size.width;

        provider.addwidth(media, context);

        return FutureBuilder(
          future: fetchitem,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              final item = snapshot.data;
              if (item != null) {
                return sheet(item);
              }
            }
            return Text(snapshot.error.toString());
          },
        );
      },
    );
  }
}
