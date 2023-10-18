import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/models/via_cep_cards_data_model.dart';

import 'package:via_cep_dio/src/screens/main_screen/components/main_screen_body_content_widget/main_screen_body_content_widget/pagination_button_widget.dart';
import 'package:via_cep_dio/src/screens/main_screen/components/main_screen_body_content_widget/via_cep_card_widget.dart';

class CEPListViewWidget extends StatelessWidget {
  const CEPListViewWidget({
    super.key,
    required this.viaCepCardsData,
    required this.skip,
    required this.limit,
    required this.updateSkip,
  });

  final ViaCepCardsDataModel viaCepCardsData;
  final int skip;
  final int limit;
  final void Function(int) updateSkip;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: viaCepCardsData.results.map((viaCep) {
            return ViaCepCardWidget(
              viaCep: viaCep,
            );
          }).toList(),
        ),
        if (viaCepCardsData.count > limit)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PaginationButtonWidget(
                icon: Icons.arrow_back_ios_rounded,
                action: skip >= limit
                    ? () {
                        updateSkip(
                          skip - limit,
                        );
                      }
                    : null,
              ),
              PaginationButtonWidget(
                icon: Icons.arrow_forward_ios_rounded,
                action: (skip + limit) < viaCepCardsData.count
                    ? () {
                        updateSkip(
                          skip + limit,
                        );
                      }
                    : null,
              ),
            ],
          ),
      ],
    );
  }
}
