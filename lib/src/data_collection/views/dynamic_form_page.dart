import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proxima/src/data_collection/data_collection.dart';

class DynamicFormPage extends StatelessWidget {
  const DynamicFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DataCollectionBloc(
        dataCollectionRepository: context.read<DataCollectionRepository>(),
      )..add(const GetJsonFormData()),
      child: const DynamicFormView(),
    );
  }
}

class DynamicFormView extends StatefulWidget {
  const DynamicFormView({super.key});
  @override
  DynamicFormViewState createState() => DynamicFormViewState();
}

class DynamicFormViewState extends State<DynamicFormView> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: const Text('DataCollection')),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DataCollectionBloc, DataCollectionState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == DataCollectionStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        '${state.message})',
                      ),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<DataCollectionBloc, DataCollectionState>(
          builder: (context, state) {
            if (kDebugMode) {
              print('>> dashboard data ${state.status} ||  ${state.formData}');
            }
            if (state.formData != null) {
              final formData = state.formData;
              const currentLanguage = 'en';
              List<Step> stepData = [];
              final labelText = formData?.form?.labels
                  ?.firstWhere((x) => x.language == currentLanguage);
              if (state.status == DataCollectionStatus.loading) {
                return const Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.blue,
                    animating: true,
                    radius: 20,
                  ),
                );
              } else {
                var data = formData!.formData?.fold([[]], (list, x) {
                  return list.last.length == 4
                      ? (list..add([x]))
                      : (list..last.add(x));
                });

                if (data?.isNotEmpty == true && data!.length > 1) {
                  for (var (index, item) in data.indexed) {
                    stepData.add(Step(
                      state: currentStep > index
                          ? StepState.complete
                          : StepState.indexed,
                      isActive: currentStep >= index,
                      title: const Text(""),
                      content: SizedBox(
                        height: MediaQuery.sizeOf(context).height / 50 * 32,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: item.length,
                          itemBuilder: (context, index) {
                            return DynamicFormWidget(
                              currentLanguage: currentLanguage,
                              data: item[index],
                              islast: item.length == index,
                            );
                          },
                        ),
                      ),
                    ));
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          '${labelText?.value}',
                          style: Styles.heading_1,
                        ),
                      ),
                      Expanded(
                        child: Stepper(
                          type: StepperType.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          currentStep: currentStep,
                          elevation: 0,
                          onStepCancel: () => currentStep == 0
                              ? null
                              : setState(() {
                                  currentStep -= 1;
                                }),
                          onStepContinue: () {
                            bool isLastStep =
                                (currentStep == stepData.length - 1);
                            if (isLastStep) {
                              //Do something with this information
                            } else {
                              setState(() {
                                currentStep += 1;
                              });
                            }
                          },
                          steps: stepData,
                          controlsBuilder: (context, details) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5.0,
                                horizontal: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  currentStep != 0
                                      ? TextButton(
                                          onPressed: details.onStepCancel,
                                          child: const Text('Previous'),
                                        )
                                      : const SizedBox(),
                                  currentStep != stepData.length - 1
                                      ? TextButton(
                                          onPressed: details.onStepContinue,
                                          child: const Text('Next'),
                                        )
                                      : TextButton(
                                          onPressed: details.onStepContinue,
                                          child: const Text('Submit'),
                                        )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else if (data?.isNotEmpty == true) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          '${labelText?.value}',
                          style: Styles.heading_1,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: formData.formData!.length,
                          itemBuilder: (context, index) {
                            return DynamicFormWidget(
                              currentLanguage: currentLanguage,
                              data: formData.formData![index],
                              islast: formData.formData!.length == index,
                            );
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Submit'),
                      )
                    ],
                  );
                } else {
                  return Text(
                    'No data found',
                    style: Theme.of(context).textTheme.bodySmall,
                  );
                }
              }
            } else {
              return Center(
                child: Text(
                  'No data found',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
