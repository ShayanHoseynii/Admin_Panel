import 'package:admin_panel/bindings/general_bindings.dart';
import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/routes/app_routes.dart';
import 'package:admin_panel/routes/route_observer.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/constants/text_strings.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      initialRoute: TRoutes.dashboard,
      getPages: TAppRoutes.pages,
      navigatorObservers: [RouteObservers()],
      unknownRoute: GetPage(
          name: '/page-not-found',
          page: () => const Scaffold(
                body: Center(
                  child: Text('Page Not Found'),
                ),
              )),
      // home: const FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                "simple navigation: Default futter navigation vs getx navigation"),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SecondScreen()));
                  },
                  child: const Text('Default Navigation')),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/second-screen'),
                child: const Text('pushnamed')),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const SecondScreen());
                },
                child: const Text('getx navigation'),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const responsive_widget()),
                  );
                },
                child: const Text('MaterialRoute to Responsive Widget'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        centerTitle: true,
      ),
    );
  }
}

class responsive_widget extends StatelessWidget {
  const responsive_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: Expanded(child: Desktop()),
      tablet: Expanded(child: Tablet()),
      mobile: Mobile(),
    );
  }
}

class Desktop extends StatelessWidget {
  const Desktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    TRoundedContainer(
                      height: 450,
                      backgroundColor: Colors.blue.withOpacity(0.2),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    TRoundedContainer(
                      height: 215,
                      backgroundColor: Colors.green.withOpacity(0.2),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TRoundedContainer(
                          height: 215,
                          backgroundColor: Colors.orange.withOpacity(0.2),
                        )),
                        const SizedBox(width: 10),
                        Expanded(
                            child: TRoundedContainer(
                          height: 215,
                          backgroundColor: Colors.purple.withOpacity(0.2),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: TRoundedContainer(
                    height: 215,
                    backgroundColor: Colors.red.withOpacity(0.2),
                  )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: TRoundedContainer(
                height: 215,
                backgroundColor: Colors.teal.withOpacity(0.2),
              )),
            ],
          )
        ],
      ),
    );
  }
}

class Mobile extends StatelessWidget {
  const Mobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TRoundedContainer(
          height: 450,
          backgroundColor: Colors.blue.withOpacity(0.2),
        ),
        const SizedBox(height: 20),
        TRoundedContainer(
          height: 215,
          backgroundColor: Colors.green.withOpacity(0.2),
        ),
        const SizedBox(height: 10),
        TRoundedContainer(
          height: 215,
          backgroundColor: Colors.orange.withOpacity(0.2),
        ),
        const SizedBox(height: 10),
        TRoundedContainer(
          height: 215,
          backgroundColor: Colors.purple.withOpacity(0.2),
        ),
        const SizedBox(height: 20),
        TRoundedContainer(
          height: 215,
          backgroundColor: Colors.red.withOpacity(0.2),
        ),
      ],
    );
  }
}

class Tablet extends StatelessWidget {
  const Tablet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  TRoundedContainer(
                    height: 450,
                    backgroundColor: Colors.blue.withOpacity(0.2),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  TRoundedContainer(
                    height: 215,
                    backgroundColor: Colors.green.withOpacity(0.2),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TRoundedContainer(
                        height: 215,
                        backgroundColor: Colors.orange.withOpacity(0.2),
                      )),
                      const SizedBox(width: 10),
                      Expanded(
                          child: TRoundedContainer(
                        height: 215,
                        backgroundColor: Colors.purple.withOpacity(0.2),
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TRoundedContainer(
              height: 215,
              width: double.infinity,
              backgroundColor: Colors.red.withOpacity(0.2),
            ),
            const SizedBox(
              height: 20,
            ),
            TRoundedContainer(
              height: 215,
              width: double.infinity,
              backgroundColor: Colors.teal.withOpacity(0.2),
            ),
          ],
        )
      ],
    );
  }
}
