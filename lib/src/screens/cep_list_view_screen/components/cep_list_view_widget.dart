import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/models/cep_collection_model.dart';

import 'package:via_cep_dio/src/screens/main_screen/components/main_screen_body_content_widget/main_screen_body_content_widget/pagination_button_widget.dart';
import 'package:via_cep_dio/src/widgets/cep_card_widget.dart';

class CepListViewWidget extends StatelessWidget {
  const CepListViewWidget({
    super.key,
    required this.cepCollection,
    required this.skip,
    required this.limit,
    required this.updateSkip,
  });

  final CepCollectionModel cepCollection;
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
          children: cepCollection.results.map((basicCep) {
            return CepCardWidget(
              basicCep: basicCep,
            );
          }).toList(),
        ),
        if (cepCollection.count > limit)
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
                action: (skip + limit) < cepCollection.count
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
