import 'package:flutter/material.dart';
import 'package:pokedex/data/api.dart';
import 'package:pokedex/ui/details/body/tabs/about_tab.dart';
import 'package:pokedex/ui/details/body/tabs/stats_tab.dart';

import '../../../model/pokemon_details.dart';

class RootBody extends StatefulWidget {
  const RootBody({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<RootBody> createState() => _RootBodyState();
}

class _RootBodyState extends State<RootBody>
    with SingleTickerProviderStateMixin {
  late Future<PokemonDetails> futurePokemonDetails;
  late TabController _tabController;

  _RootBodyState();

  @override
  Widget build(BuildContext context) {
    _tabController = TabController(length: 4, vsync: this);

    return FutureBuilder<PokemonDetails>(
      future: futurePokemonDetails,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var pokemonDetails = snapshot.data!;

          return Column(
            children: [
              contentTabBar(),
              getTabViews(pokemonDetails),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget contentTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      tabs: const [
        Tab(text: "About"),
        Tab(text: "Base Stats"),
        Tab(text: "Evolution"),
        Tab(text: "Moves"),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    futurePokemonDetails = getPokemonDetails(widget.index);
  }

  Widget getTabViews(PokemonDetails pokemonDetails) {
    return SizedBox(
      width: double.maxFinite,
      height: 300,
      child: TabBarView(controller: _tabController, children: [
        AboutTab(pokemonDetails: pokemonDetails),
        const StatusTab(),
        AboutTab(pokemonDetails: pokemonDetails),
        AboutTab(pokemonDetails: pokemonDetails),
      ]),
    );
  }
}
