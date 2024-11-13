import 'package:domain/domain.dart';

/// Filtro para busca de texto
class TextSearchFilter extends AssetFilter {
  // #region Constructors

  /// Filtro para busca de texto
  TextSearchFilter({
    super.number = "TextFilter",
    super.description = "Filtro de texto",
    this.textSearch = "",
  });

  // #endregion

  // #region Members 'Filter' :: textSearch, hasFilter

  /// Texto de busca
  String textSearch;

  /// Possui filtro?
  bool get hasFilter => this.textSearch != "";

  // #endregion

  // #region Members 'Meets' :: meets()

  @override
  bool meets(TreeItem treeItem) {
    try {
      String textSearch = this.textSearch.toLowerCase();

      bool meets = treeItem.description.toLowerCase().contains(textSearch);

      return meets;
    } on Exception catch (exception) {
      throw Exception("Fail in meets(): $exception");
    }
  }

  // #endregion
}
