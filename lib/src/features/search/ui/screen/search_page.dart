import 'package:chat_shop/src/core/widgets/itembuilder.dart';
import 'package:chat_shop/src/features/search/bloc/detail_cubit/detail_cubit.dart';
import 'package:chat_shop/src/features/search/ui/screen/product_detail_view.dart';
import 'package:chat_shop/src/features/search/ui/widgets/daily_deal.dart';
import 'package:chat_shop/src/features/search/ui/widgets/product_card.dart';
import 'package:chat_shop/src/core/widgets/searchbar.dart';
import 'package:chat_shop/src/features/search/bloc/searc_bloc/search_bloc.dart';
import 'package:chat_shop/src/features/search/bloc/searc_bloc/search_event.dart';
import 'package:chat_shop/src/features/search/bloc/searc_bloc/search_state.dart';
import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';
import 'package:chat_shop/src/features/search/ui/constants/ebay_category.dart';
import 'package:chat_shop/src/features/search/ui/constants/search_hints.dart';

import 'package:chat_shop/src/features/search/ui/widgets/horizontal_category.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();

  ValueNotifier<int?> selectedindex = ValueNotifier<int?>(null);
  ValueNotifier<String>? iscategoractive = ValueNotifier<String>('');
  Widget homesearchbar() {
    return SliverToBoxAdapter(
      child: CustomSearchbar(
        onSearch: () {
          context.read<SearchBloc>().add(OnSearchSumbmit(_controller.text));
        },
        animatedHints: hints,
        textFieldcontroller: _controller,

        onremove: () {
          selectedindex.value = null;
          iscategoractive?.value = '';
          context.read<SearchBloc>().add(OnClear());
          _controller.clear();
        },
        iscategory: iscategoractive,
        hintText: 'Search for',
      ),
    );
  }

  Widget horizontalCategory() {
    return HorizontalCategory(
      list: EbayCategory.list,
      selectedindex: selectedindex,
      onSelect: (value) {
        final category = EbayCategory.list[value];
        selectedindex.value = value;
        iscategoractive?.value = category.name;

        context.read<SearchBloc>().add(
          OnCategorySubmit(category.id, category.name),
        );
      },
    );
  }

  Widget searchresults() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.isloading) {
          return SliverToBoxAdapter(
            child: Itembuilder(
              isloading: true,
              mincount: 3,
              truncatedevidecountvalue: 90,
              waitingWidget: ProductCard(isloading: true),
              itemBuilder: (context, data) {
                return const SizedBox.shrink();
              },
            ),
          );
        } else if (state.error != null) {
          return SliverToBoxAdapter(child: Center(child: Text(state.error!)));
        } else if (state.results!.isNotEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Itembuilder(
                mincount: 3,
                truncatedevidecountvalue: 90,
                physics: const NeverScrollableScrollPhysics(),
                items: state.results as List<SearchDomain>,
                itemBuilder: (context, data) => ProductCard(
                  isloading: false,
                  title: data.title,
                  imageUrl: data.imageUrl,
                  price: data.inrprice,
                  onTap: () async {
                   
                    if (context.mounted) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ProductDetailView();
                        },
                      );
                    }
                      context.read<DetailCubit>().getdetail(data.itemId);
                  },
                ),
              ),
            ),
          );
        } else if (state.isdailydeals) {
          return DailyDeals(list: state.results as List<SearchDomain>);
        } else {
          return SliverToBoxAdapter(child: const SizedBox.shrink());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [homesearchbar(), horizontalCategory(), searchresults()],
    );
  }
}
