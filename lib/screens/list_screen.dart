import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_udemy_flutter/stores/list_store/list_store.dart';
import 'package:mobx_udemy_flutter/stores/login_store/login_store.dart';
import 'package:mobx_udemy_flutter/widgets/custom_icon_button.dart';
import 'package:mobx_udemy_flutter/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  final TextEditingController controller = TextEditingController();

  final ListStore listStore = ListStore();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Tarefas',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 32),
                    ),
                    IconButton(
                      icon: const Icon(Icons.exit_to_app),
                      color: Colors.white,
                      onPressed: () {

                        Provider.of<LoginStore>(context, listen: false).logout();

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Observer(builder: (context) {
                          return CustomTextField(
                            controller: controller,
                            hint: 'Tarefa',
                            onChanged: listStore.setNewTodoTitle,
                            suffix: !listStore.isValidTitle
                                ? null
                                : CustomIconButton(
                                    radius: 32,
                                    iconData: Icons.add,
                                    onTap: () {
                                      listStore.addTodo();
                                      controller.clear();
                                    },
                                  ),
                          );
                        }),
                        const SizedBox(
                          height: 8,
                        ),
                        Observer(builder: (_) {
                          return Expanded(
                            child: ListView.separated(
                              itemCount: listStore.todoList.length,
                              itemBuilder: (_, index) {
                                var item = listStore.todoList[index];

                                return Observer(builder: (_) {
                                  return ListTile(
                                    title: Text(
                                      item.title,
                                      style: TextStyle(
                                        decoration: item.done
                                            ? TextDecoration.lineThrough
                                            : null,
                                        color: item.done
                                            ? Colors.grey
                                            : Colors.black
                                      ),
                                    ),
                                    onTap: item.toggleDone,
                                  );
                                });
                              },
                              separatorBuilder: (_, __) {
                                return const Divider();
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
