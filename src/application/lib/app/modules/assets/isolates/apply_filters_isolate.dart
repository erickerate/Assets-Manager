import 'dart:isolate';
import 'package:darq/darq.dart';
import 'package:domain/domain.dart';

class IsolateModel {
  final List<AssetFilter> filters;
  final List<TreeItem> treeItems;
  final SendPort sendPort;
  IsolateModel(this.treeItems, this.filters, this.sendPort);
}

/// Executar tarefas de filtros
void executeFiltersTask(IsolateModel model) {
  try {
    for (TreeItem treeItem in model.treeItems) {
      bool visible = treeItemMeetsAnyFilter(treeItem, model.filters);

      if (visible) {
        setDescendantsVisible(treeItem);
      }
    }

    List<TreeItem> filteredTreeItems =
        model.treeItems.where((w) => w.visible).toList();

    model.sendPort.send(filteredTreeItems);
  } catch (exception) {
    throw Exception("Fail in executeFiltersTask(): $exception");
  }
}

/// Item atende a algum filtro?
bool treeItemMeetsAnyFilter(TreeItem treeItem, List<AssetFilter> filters) {
  try {
    bool meets =
        filters.isEmpty || filters.all((filter) => filter.meets(treeItem));

    return meets;
  } on Exception catch (exception) {
    throw Exception("Fail in treeItemMeetsAnyFilter(): $exception");
  }
}

/// Aplicar filtro bottom-up para definir visibilidade
void setDescendantsVisible(TreeItem treeItem) {
  try {
    if (treeItem.visible) return;

    treeItem.visible = true;

    TreeItem? parentTreeItem = treeItem.parent;
    if (parentTreeItem != null) {
      setDescendantsVisible(parentTreeItem);
    }
  } on Exception catch (exception) {
    throw Exception("Fail in setDescendantsVisible(): $exception");
  }
}
