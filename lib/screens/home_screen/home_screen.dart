import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/home_screen_bloc/counter_cubit.dart';
import 'package:hassanallamportalflutter/bloc/internet_connectivity_bloc/internet_cubit.dart';
import 'package:hassanallamportalflutter/constants/enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title, required this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext homeScreenContext) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Navigator.pushNamed(context, '/settings')),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
              builder: (internetCubitBuilderContext, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.wifi) {
                  return Text(
                    'Wi-Fi',
                    style: Theme.of(internetCubitBuilderContext)
                        .textTheme
                        .headline3
                        ?.copyWith(
                      color: Colors.green,
                    ),
                  );
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.mobile) {
                  return Text(
                    'Mobile',
                    style: Theme.of(internetCubitBuilderContext)
                        .textTheme
                        .headline3
                        ?.copyWith(
                      color: Colors.red,
                    ),
                  );
                } else if (state is InternetDisconnected) {
                  return Text(
                    'Disconnected',
                    style: Theme.of(internetCubitBuilderContext)
                        .textTheme
                        .headline3
                        ?.copyWith(
                      color: Colors.grey,
                    ),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            Divider(
              height: 5,
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (counterCubitListenerContext, state) {
                if (state.wasIncremented == true) {
                  Scaffold.of(counterCubitListenerContext).showSnackBar(
                    SnackBar(
                      content: Text('Incremented!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                } else if (state.wasIncremented == false) {
                  Scaffold.of(counterCubitListenerContext).showSnackBar(
                    SnackBar(
                      content: Text('Decremented!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
              },
              builder: (counterCubiBuilderContext, state) {
                if (state.counterValue < 0) {
                  return Text(
                    'BRR, NEGATIVE ' + state.counterValue.toString(),
                    style:
                    Theme.of(counterCubiBuilderContext).textTheme.headline4,
                  );
                } else if (state.counterValue % 2 == 0) {
                  return Text(
                    'YAAAY ' + state.counterValue.toString(),
                    style:
                    Theme.of(counterCubiBuilderContext).textTheme.headline4,
                  );
                } else if (state.counterValue == 5) {
                  return Text(
                    'HMM, NUMBER 5',
                    style:
                    Theme.of(counterCubiBuilderContext).textTheme.headline4,
                  );
                } else
                  return Text(
                    state.counterValue.toString(),
                    style:
                    Theme.of(counterCubiBuilderContext).textTheme.headline4,
                  );
              },
            ),
            SizedBox(
              height: 24,
            ),
            Builder(
              builder: (context) {
                final counterState = context.watch<CounterCubit>().state;
                final internetState = context.watch<InternetCubit>().state;

                if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.mobile) {
                  return Text(
                    'Counter: ' +
                        counterState.counterValue.toString() +
                        ' Internet: Mobile',
                    style: Theme.of(context).textTheme.headline6,
                  );
                } else if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.wifi) {
                  return Text(
                    'Counter: ' +
                        counterState.counterValue.toString() +
                        ' Internet: Wifi',
                    style: Theme.of(context).textTheme.headline6,
                  );
                } else {
                  return Text(
                    'Counter: ' +
                        counterState.counterValue.toString() +
                        ' Internet: Disconnected',
                    style: Theme.of(context).textTheme.headline6,
                  );
                }
              },
            ),
            SizedBox(
              height: 24,
            ),
            Builder(
              builder: (context) {
                final counterValue = context
                    .select((CounterCubit cubit) => cubit.state.counterValue);
                return Text(
                  'Counter: ' + counterValue.toString(),
                  style: Theme.of(context).textTheme.headline6,
                );
              },
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: Text('${widget.title}'),
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                    // context.bloc<CounterCubit>().decrement();
                  },
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: Text('${widget.title} 2nd'),
                  onPressed: () {
                    // BlocProvider.of<CounterCubit>(context).increment();
                    context.read<CounterCubit>().increment();
                  },
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Builder(
              builder: (materialButtonContext) => MaterialButton(
                color: Colors.redAccent,
                child: Text(
                  'Go to Second Screen',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(materialButtonContext).pushNamed(
                    '/second',
                  );
                },
              ),
            ),
            // SizedBox(
            //   height: 24,
            // ),
            MaterialButton(
              color: Colors.greenAccent,
              child: Text(
                'Go to Third Screen',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(homeScreenContext).pushNamed(
                  '/third',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}