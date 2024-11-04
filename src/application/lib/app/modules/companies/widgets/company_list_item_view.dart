import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

/// Componente de visualização para empresa
class CompanyListItemView extends StatefulWidget {
  // #region Constructors

  /// Componente de visualização para empresa
  const CompanyListItemView({
    super.key,
    required this.company,
    required this.onSelect,
  });

  // #endregion

  // #region Members 'Parameters' :: company, onSelect()

  /// Empresa
  final Company company;

  /// Ao selecionar
  final Future<void> Function(Company company) onSelect;

  // #endregion

  @override
  State<CompanyListItemView> createState() => _CompanyListItemViewState();
}

class _CompanyListItemViewState extends State<CompanyListItemView> {
  // #region Members 'Builds' :: build()

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await this.widget.onSelect(this.widget.company);
      },
      child: Container(
        height: 76,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        decoration: BoxDecoration(
          color: const Color(0xFF2188FF),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/images/company.png",
            ),
            const Padding(padding: EdgeInsets.only(right: 16)),
            Text(
              "${this.widget.company.name} Unit",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  // #endregion
}
