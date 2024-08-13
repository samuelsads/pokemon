import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon/domain/entities/home/pokemon_entity.dart';
import 'package:pokemon/utils/formats.dart';

class InformationPage extends StatefulWidget {
  static const name = "information-page";
  const InformationPage({required this.pokemon, super.key});
  final PokemonEntity pokemon;

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
                color: widget.pokemon.color),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: SvgPicture.network(
                      widget.pokemon.image,
                    ),
                  ),
                ),
                Positioned(
                    top: 40,
                    child: IconButton(
                        onPressed: () {
                          GoRouter.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )))
              ],
            ),
          ),
          Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: Text(
                    widget.pokemon.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  )),
              Text(
                "#${Formats().formatId(widget.pokemon.id)}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.grey[400]),
                child: Text(
                  widget.pokemon.type,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text("${widget.pokemon.height}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const Text("Height",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text("${widget.pokemon.weight}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const Text("Weight",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600))
                      ],
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 12, top: 16),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "Stats",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
              ..._generateStats()
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _generateStats() {
    List<Stats> stats = widget.pokemon.stats;
    List<Widget> elements = [];
    for (var stat in stats) {
      elements.add(Container(
        margin: const EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 12),
              child: Text(Formats().formatText(stat.name).toUpperCase()),
            ),
            Container(
              margin: const EdgeInsets.only(right: 12),
              width: MediaQuery.of(context).size.width * 0.8,
              height: 25,
              child: Stack(
                children: [
                  Container(
                    height: 25,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.grey[400]),
                  ),
                  Container(
                    height: 25,
                    width: ((stat.stat *
                            (MediaQuery.of(context).size.width * 0.8)) /
                        100),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: widget.pokemon.color),
                  ),
                  Container(
                    height: 25,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${stat.stat}%",
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ));
    }
    return elements;
  }
}
