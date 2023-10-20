import 'package:flutter/material.dart';

import 'package:cep_dio/src/core/helpers/number_format_brazil_helper.dart';

import 'package:cep_dio/src/models/cep_model.dart';

class CepCardDetailsWidget extends StatelessWidget {
  const CepCardDetailsWidget({
    super.key,
    required this.cep,
  });

  final CepModel cep;

  BorderRadiusGeometry get borderRadius => BorderRadius.circular(28.0);

  @override
  Widget build(BuildContext context) {
    final String ibge = numberFormatBrazilHelper(cep.ibge);

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.8,
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: borderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12.0),
            Container(
              height: 4.0,
              width: 28.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade800.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            const SizedBox(height: 16.0),
            const Icon(
              Icons.map,
              color: Colors.white,
              size: 24.0,
            ),
            const SizedBox(height: 16.0),
            Text(
              cep.cep,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (cep.bairro != null || cep.complemento != null) ...[
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (cep.bairro != null)
                    Text(
                      cep.bairro!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (cep.bairro != null && cep.complemento != null)
                    const Text(
                      ' - ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (cep.complemento != null)
                    Text(
                      cep.complemento!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ],
            if (cep.logradouro != null) ...[
              const SizedBox(height: 12.0),
              Text(
                cep.logradouro!,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
            const SizedBox(height: 12.0),
            Text(
              '${cep.localidade} - ${cep.uf}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              'DDD ${cep.ddd}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              'Quandidade de habitantes: $ibge',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 4.0,
              margin: const EdgeInsets.symmetric(
                horizontal: 50.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
