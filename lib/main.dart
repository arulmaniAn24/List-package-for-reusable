// import 'package:first_app/Pages/Containterexample.dart';
// import 'package:first_app/Pages/alertdialogbox_example.dart';
// import 'package:first_app/Pages/barchart_example.dart';
// import 'package:first_app/Pages/bottombarexample.dart';
// import 'package:first_app/Pages/bottomsheetexample.dart';
// import 'package:first_app/Pages/camera_example.dart';
// import 'package:first_app/Pages/cardone_example.dart';
// import 'package:first_app/Pages/columnchart_example.dart';
// import 'package:first_app/Pages/dropdownbutton_example.dart';
// import 'package:first_app/Pages/example_richtext.dart';
// import 'package:first_app/Pages/examplesnackBar.dart';
// import 'package:first_app/Pages/exampletextformfield.dart';
// import 'package:first_app/Pages/barchart_example.dart';
// import 'package:first_app/Pages/error_page.dart';
// import 'package:first_app/Pages/dashboard.dart';
// import 'package:first_app/Pages/error_page.dart';
// import 'package:first_app/Pages/food_example.dart';
// import 'package:first_app/Pages/grid_example.dart';
// import 'package:first_app/Pages/lists_example.dart';
// import 'package:first_app/Pages/login.dart';
// import 'package:first_app/Pages/route_name.dart';
// import 'package:first_app/Pages/routes_example.dart';
// import 'package:first_app/Pages/workout_example.dart';
// import 'package:first_app/Pages/formexample.dart';
// import 'package:first_app/Pages/grid_example.dart';
// import 'package:first_app/Pages/gridbuilder_example.dart';
// import 'package:first_app/Pages/gridcount_example.dart';
// import 'package:first_app/Pages/lists_example.dart';
// import 'package:first_app/Pages/login.dart';
// import 'package:first_app/Pages/longlistexample.dart';
// import 'package:first_app/Pages/screen1.dart';
// import 'package:first_app/Pages/snackBar_example.dart';
// import 'package:first_app/Pages/splashscreen.dart';
// import 'package:first_app/Pages/tabbar_example.dart';
// import 'package:first_app/Pages/workout_example.dart';
// import 'package:first_app/Arestro/dashboard_screen.dart';
// import 'package:first_app/Arestro/forgot_screen.dart';
// import 'package:first_app/Arestro/reset_screen.dart';
// import 'package:first_app/Arestro/signup_screen.dart';
// import 'package:first_app/adaptive/mobile_screen.dart';
// import 'package:first_app/adaptive/responsive_layout.dart';
// import 'package:first_app/api/get_api.dart';
// import 'package:first_app/api/get_example.dart';
// import 'package:first_app/api/getdata_api.dart';
// import 'package:first_app/bloc/counter_bloc.dart';
// import 'package:first_app/bloc/counter_ui_page.dart';
// import 'package:first_app/bloc_api/user_bloc.dart';
// import 'package:first_app/bloc_api/user_ui_page.dart';
// import 'package:first_app/table_bloc/table_bloc.dart';
// import 'package:first_app/table_bloc/table_ul.dart';
import 'package:first_app/tabledata/tabledata_ui.dart';
import 'package:first_app/tabledata/usersdata_bloc.dart';
// import 'package:first_app/table_bloc/ui_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:go_router/go_router.dart';
// import 'package:first_app/Arestro/login_screen.dart';
// import 'package:first_app/Arestro/route_names.dart';
// import 'package:first_app/Arestro/start_screen.dart';

void main(){
  runApp(MyApp());
}
// final bool isLoggedIn = true;
class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: SplashScreen() ,
      // home:ContainerExample(),
      // home: ExampleTextFormField(),
      // home: RichTextExample(),
      // home: ListExample(),
      // home: LongListExample(),
      // home: GridExample(),
      // home:GridBuliderExample(),
      // home: GridCountExample(),
      // home: TabBarExample(),
      // home: BottomBarExample(),
      // home: BottomSheetExample(),
      // home: SnackBarExample(),
      // home: ExampleSnackBar(),
      // home: Login(),
      // home: FormExample(),
      // home: DropDownExample(),
      // home: AlertDialogboxExample(),
      // home: CardOneExample(),
      // home: FoodExample(),
      // home: WorkoutExample(),
      // home: BarChartExample(),
      // home: ColumnChartExample(),
      // home: CameraExample(),
      // home: GetExample(),
      // home: GetApi(),
        home: BlocProvider(
        create: (context)=> UsersDataBloc(),
        child: TableDataUi(),
      )
      // home: BlocProvider(
      //   create: (context)=> TableBloc(),
      //   child: TableUi(),
      // )
      // home: UiTable(),

      // home: BlocProvider(
      //     // create: (context) => CounterBloc(),
      //   create: (context) => UserBloc(),
      //   child: const UserUiPage(),
      // ),

     );
     // return MaterialApp(
     //   debugShowCheckedModeBanner: false,
     //   home: const MobileScreen(),
     // );


    //   return MaterialApp.router(
    //     routerConfig: _router,
    //   );
    // }
    //
    // final GoRouter _router = GoRouter(
    //   //initialLocation: "/reset-password",
    //     routes: [
    //       GoRoute(name: RouteNames.startup, path: "/", builder: ((context, state) => StartScreen()), routes: [
    //         GoRoute(name: RouteNames.login, path: "login", builder: ((context, state) => LoginScreen())),
    //         GoRoute(name: RouteNames.signup, path: "signup", builder: ((context, state) => SignUpScreen())),
    //         GoRoute(name: RouteNames.dashboard, path: "dashboard", builder: ((context, state) => DashboardScreen())),
    //         GoRoute(name: RouteNames.forgotPassword, path: "forgot-password", builder: ((context, state) => ForgotScreen())),
    //         GoRoute(name: RouteNames.resetPassword, path: "reset-password", builder: ((context, state) => ResetScreen()))
    //       ]),
    //     ]
    // );


    // final GoRouter _router = GoRouter(
    //   errorBuilder: (context,state) => ErrorPage(),
    //   // redirect: (context,state){
    //   //   if(isLoggedIn){
    //   //     return "/";
    //   //   }
    //   //   else{
    //   //     return "/login";
    //   //   }
    //   // },
    //
    //   //   initialLocation:"/google",
    //
    //     routes: [
    //       GoRoute(path: "/",builder: (context,state)=> const DashBoard(),
    //           routes:[
    //           //GoRoute(name: RouteNames.dashboard, path: "dashboard",builder: ((context,state)=> DashBoard())),
    //           // GoRoute(path: "routes-example",builder: ((context,state)=> RoutesExample())),
    //           // GoRoute(path: "routes-example/:param1",builder: ((context,state)=> RoutesExample(
    //           //   name: state.pathParametrs["param1"]!,
    //           // )))
    //           // GoRoute(name: RouteNames.routeExample, path: "routes-example",builder: ((context,state)=> RoutesExample())),
    //           // GoRoute(
    //           //     name: RouteNames.routeExample,
    //           //     path: "routes-example",
    //           //     builder: ((context,state)=> RoutesExample(
    //           //       name: state.uri.queryParameters["username"]!
    //           //     ))
    //           // ),
    //
    //           // GoRoute(
    //           //     name: RouteNames.login ,
    //           //     path: "/route-example",
    //           //     pageBuilder: (context,state){
    //           //       return CustomTransitionPage(
    //           //         transitionDuration: const Duration(seconds: 4),
    //           //         key: state.pageKey,
    //           //           child: const RoutesExample(),
    //           //           transitionsBuilder: (context, animation, secondaryAnimation, child)
    //           //           {
    //           //             return FadeTransition(
    //           //                 opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
    //           //               child: child,
    //           //             );
    //           //           },
    //           //       );
    //           //     }
    //           // ),
    //         ]
    //       ),
    //     ]
    // );
  }
}