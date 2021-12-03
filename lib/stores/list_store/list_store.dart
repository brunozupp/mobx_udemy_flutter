import 'package:mobx/mobx.dart';
import 'package:mobx_udemy_flutter/stores/todo_store/todo_store.dart';
part 'list_store.g.dart';

class ListStore = _ListStoreBase with _$ListStore;

abstract class _ListStoreBase with Store {
  
  @observable
  String newTodoTitle = "";

  // Utiliza ObservableList para ele enxengar as mudanças ao adicionar/remover
  // os valores da lista. Se fosse uma lista normal eu deveria criar uma outra
  // instância, pois ele enxergaria o objeto como um todo e não as partes que o compoem
  @observable
  ObservableList<TodoStore> todoList = ObservableList.of([]);

  @action
  void setNewTodoTitle(String value) => newTodoTitle = value;

  @action
  void addTodo() {
    todoList.insert(0, TodoStore(newTodoTitle));
    newTodoTitle = "";
  }

  @computed
  bool get isValidTitle => newTodoTitle.isNotEmpty;
}