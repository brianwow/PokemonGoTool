import 'package:flutter/material.dart';

import '../models/pokemon.dart';

class PokemonCard extends StatefulWidget {
  final Pokemon pokemon;
  final VoidCallback onCardChange;
  const PokemonCard(this.pokemon, this.onCardChange, {super.key});
  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  bool isCurrentGenderMale = true;
  Icon capturedIcon = const Icon(Icons.radio_button_checked_sharp);
  Icon shinyCapturedIcon = const Icon(Icons.star);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Colors if the icons depending of the sexe
    if (isCurrentGenderMale) {
      if (widget.pokemon.isMaleCaptured) {
        capturedIcon =
            const Icon(Icons.radio_button_checked_sharp, color: Colors.blue);
      } else {
        capturedIcon = const Icon(Icons.radio_button_checked_sharp);
      }
      if (widget.pokemon.isMaleShinyCaptured) {
        shinyCapturedIcon =
            const Icon(Icons.star, color: Color.fromARGB(255, 236, 163, 4));
      } else {
        shinyCapturedIcon = const Icon(Icons.star);
      }
    } else {
      if (widget.pokemon.isFemaleCaptured) {
        capturedIcon =
            const Icon(Icons.radio_button_checked_sharp, color: Colors.blue);
      } else {
        capturedIcon = const Icon(Icons.radio_button_checked_sharp);
      }
      if (widget.pokemon.isFemaleShinyCaptured) {
        shinyCapturedIcon =
            const Icon(Icons.star, color: Color.fromARGB(255, 236, 163, 4));
      } else {
        shinyCapturedIcon = const Icon(Icons.star);
      }
    }

    return Card(
      surfaceTintColor: Colors.blueGrey,
      shadowColor: Colors.black,
      elevation: 5,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10.0, right: 10.0, top: 5, bottom: 5),
        child: Column(children: [
          Row(children: [
            Text("${widget.pokemon.name} - #${widget.pokemon.id.toString()}",
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Bahnschrift")),
            const Spacer(),
            Switch(
              thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return const Icon(Icons.male_outlined);
                  }
                  return const Icon(Icons.female_outlined);
                },
              ),
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.pink,
              activeTrackColor: const Color.fromARGB(255, 209, 207, 207),
              inactiveTrackColor: const Color.fromARGB(255, 209, 207, 207),
              value: isCurrentGenderMale,
              onChanged: (bool value) {
                setState(() {
                  isCurrentGenderMale = value;
                });
              },
            ),
          ]),
          Expanded(
            child: Image.network(widget.pokemon.artwork,
                scale: 1,
                isAntiAlias: true,
                filterQuality: FilterQuality.medium),
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (isCurrentGenderMale) {
                          widget.pokemon.isMaleCaptured =
                              !widget.pokemon.isMaleCaptured;
                        } else {
                          widget.pokemon.isFemaleCaptured =
                              !widget.pokemon.isFemaleCaptured;
                        }
                      });
                      widget.onCardChange();
                    },
                    icon: capturedIcon),
                if (widget.pokemon.hasShinyVersion)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (isCurrentGenderMale) {
                          widget.pokemon.isMaleShinyCaptured =
                              !widget.pokemon.isMaleShinyCaptured;
                        } else {
                          widget.pokemon.isFemaleShinyCaptured =
                              !widget.pokemon.isFemaleShinyCaptured;
                        }
                      });
                      widget.onCardChange();
                    },
                    icon: shinyCapturedIcon,
                  ),
                const Spacer(),
                if (widget.pokemon.category != "Mythic")
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.pokemon.isLuckyCaptured =
                            !widget.pokemon.isLuckyCaptured;
                      });
                      widget.onCardChange();
                    },
                    icon: widget.pokemon.isLuckyCaptured
                        ? const Icon(
                            Icons.bubble_chart_rounded,
                            color: Colors.pink,
                          )
                        : const Icon(Icons.bubble_chart_rounded),
                  ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
