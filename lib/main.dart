import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_store/firebase_options.dart';
import 'package:grocery_store/logic/bloc/grocery_items/grocery_items_bloc.dart';
import 'package:grocery_store/logic/cubit/auth/auth_cubit.dart';
import 'package:grocery_store/logic/cubit/cart/add_to_cart_cubit.dart';
import 'package:grocery_store/presentation/ui/mannual_product_add.dart';
import 'package:grocery_store/presentation/ui/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GroceryItemsBloc>(
          create: (context) => GroceryItemsBloc(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<AddToCartCubit>(
          create: (context) => AddToCartCubit(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(103, 58, 183, 1)),
            useMaterial3: true,
          ),
          home:SplashScreen(),
    ));
  }
}
