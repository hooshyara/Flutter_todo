import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/task.dart';
import 'model/task_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvier(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool checkBox = false;
  late final TextEditingController _titleController;
  late final TextEditingController _textController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _textController = TextEditingController();
    super.initState;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watchProvider = context.watch<TaskProvier>();
    final Provider = context.watch<TaskProvier>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFECECEC),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green.shade900,
          onPressed: () async {
            final add = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    'add Task',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.green.shade900,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                            label: Text(
                              'title',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.green.shade800,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green.shade500,
                              ),
                            )),
                        cursorColor: Colors.green.shade800,
                        style: TextStyle(
                          color: Colors.green.shade800,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                            label: Text(
                              'Text',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.green.shade800,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green.shade500,
                              ),
                            )),
                        cursorColor: Colors.green.shade800,
                        style: TextStyle(
                          color: Colors.green.shade800,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade500,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
            if (add != null && add) {
              final task = Task(
                title: _titleController.text,
                text: _textController.text,
                is_done: false,
              );
              context.read<TaskProvier>().create(task: task);
            }
            _textController.clear();
            _titleController.clear();
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.green.shade900,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(120.0),
                            bottomRight: Radius.circular(120.0),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Lets\ s do !',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontFamily: 'josefinB',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 200,
                      left: 550,
                      child: SizedBox(
                        height: 90,
                        width: 140,
                        child: Card(
                          elevation: 20,
                          child: Column(
                            children: [
                              Text(
                                'Tasks',
                                style: TextStyle(
                                    color: Colors.green.shade800,
                                    fontSize: 40,
                                    fontFamily: 'josefinB'),
                              ),
                              Text(
                                Provider.tasks.length.toString(),
                                style: TextStyle(
                                    color: Colors.green.shade800,
                                    fontSize: 30,
                                    fontFamily: 'josefinB'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: watchProvider.tasks.length,
                  itemBuilder: (context, index) {
                    final task = watchProvider.tasks[index];
                    return Dismissible(
                      key: Key(task.id),
                      background: const Card(
                        color: Colors.red,
                        child: Icon(
                          Icons.delete,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        context.read<TaskProvier>().delete(id: task.id);
                      },
                      confirmDismiss: (direction) async {
                        return showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Delete Task',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green.shade500,
                                ),
                              ),
                              content: Text(
                                'Are you Sure ?',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.green.shade500),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: Text(
                                    'yes',
                                    style: TextStyle(
                                      color: Colors.green.shade500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: Text(
                                    'no',
                                    style: TextStyle(
                                      color: Colors.green.shade500,
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(
                            task.title,
                            style: TextStyle(
                              color: Colors.green.shade800,
                              fontSize: 30,
                            ),
                          ),
                          subtitle: Text(
                            task.text,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          leading: Checkbox(
                            value: task.is_done,
                            onChanged: (value) {
                              setState(() {
                                task.is_done = value ?? false;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
