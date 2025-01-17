import 'package:fcnui_base/fcnui_base.dart';
import 'package:flutter/material.dart';
import 'package:registry/pages/page_impl.dart';
import 'package:registry/ui/default_components/form.dart';
import 'package:registry/ui/default_components/input.dart';
import 'package:registry/ui/default_components/with_label.dart';
import 'package:registry/ui/snackbar.dart';

import '../ui/default_components/button.dart';

class InputPage extends PageImpl {
  final bool isDisabled;
  final bool withLabel;
  final bool withButton;
  final bool isForm;

  const InputPage({
    super.key,
    this.isDisabled = false,
    this.withLabel = false,
    this.withButton = false,
    this.isForm = false,
  });

  @override
  Widget preview(BuildContext context) {
    if (isDisabled) {
      return const _Disabled();
    }
    if (withLabel) {
      return const _WithLabel();
    }
    if (withButton) {
      return _WithButton();
    }
    if (isForm) {
      return _Form();
    }
    return const _Default();
  }

  @override
  String getCode() {
    String code = "";

    if (isDisabled) {
      code = '''
  class _Disabled extends StatelessWidget {
  const _Disabled();

  @override
  Widget build(BuildContext context) {
    return const DefaultInput(
      vm: InputModel(
        name: "emailDisabled",
        enabled: false,
        hintText: "Email",
      ),
    );
  }
}
''';
    } else if (withLabel) {
      code = '''
class _WithLabel extends StatelessWidget {
  const _WithLabel();

  @override
  Widget build(BuildContext context) {
    return const WithLabel(
        labelVm: LabelModel(text: "Email", enabled: true),
        child: DefaultInput(
            vm: InputModel(
          name: "emailWithLabel",
          hintText: "Email",
        )));
  }
} 
''';
    } else if (withButton) {
      code = '''
class _WithButton extends StatelessWidget {
  _WithButton();

  final formModel = FormModel();

  @override
  Widget build(BuildContext context) {
    return DefaultForm(
      vm: formModel,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: DefaultInput(
                vm: InputModel(
              maxLines: 1,
              name: "emailWithButton",
              hintText: "Email",
              validators: [
                FormBuilderValidators.required(
                    errorText: "Please enter your email address"),
                FormBuilderValidators.email(
                    errorText: "Please enter a valid email address"),
              ],
            )),
          ),
          SaveButton(text: "Subscribe", vm: formModel, onSave: print),
        ],
      ).spaced(10),
    );
  }
}
''';
    } else if (isForm) {
      code = '''
class _Form extends StatelessWidget {
  _Form();

  final formModel = FormModel();
  @override
  Widget build(BuildContext context) {
    return DefaultForm(
      vm: formModel,
      child: WithLabel(
        labelVm: const LabelModel(text: "Username"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultInput(
              vm: InputModel(
                name: "username",
                hintText: "Username",
                helperText: "This is your public display name",
                validators: [
                  FormBuilderValidators.minLength(2,
                      errorText: 'Username must be at least 2 characters.'),
                ],
              ),
            ),
            SaveButton(
                vm: formModel,
                onSave: (value) {
                  if (formModel.isValid) {
                    ScaffoldMessenger.of(themeVm).showSnackBar(SnackBar(
                        content: Text(formModel.getValues().toString())));
                  }
                },
                text: "Submit"),
          ],
        ).spaced(20),
      ),
    );
  }
}
''';
    } else {
      code = '''
class _Default extends StatelessWidget {
  const _Default();

  @override
  Widget build(BuildContext context) {
    return const DefaultInput(
      vm: InputModel(
        name: "email",
        hintText: "Email",
      ),
    );
  }
}
''';
    }
    return code;
  }
}

class _Default extends StatelessWidget {
  const _Default();

  @override
  Widget build(BuildContext context) {
    return DefaultInput(
        decorationBuilder: (themeVm) => InputDecor(themeVm,
            child: InputChild(themeVm, name: "email", hintText: "Email")));
  }
}

class _Disabled extends StatelessWidget {
  const _Disabled();

  @override
  Widget build(BuildContext context) {
    return DefaultInput(
        decorationBuilder: (themeVm) => InputDecor(themeVm,
            state: InputState(themeVm, isDisabled: true),
            child: InputChild(themeVm, name: "email", hintText: "Email")));
  }
}

class _WithLabel extends StatelessWidget {
  const _WithLabel();

  @override
  Widget build(BuildContext context) {
    return WithLabel(
        labelBuilder: (themeVm) => LabelDecoration(themeVm,
            child: LabelChild(themeVm, text: "Email"),
            state: LabelState(themeVm, isDisabled: false)),
        child: DefaultInput(
            decorationBuilder: (themeVm) => InputDecor(themeVm,
                child: InputChild(themeVm, name: "email", hintText: "Email"))));
  }
}

class _WithButton extends StatelessWidget {
  _WithButton();

  final formModel = FormModel();

  @override
  Widget build(BuildContext context) {
    return DefaultForm(
      vm: formModel,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: DefaultInput(
                  decorationBuilder: (themeVm) => InputDecor(themeVm,
                      child: InputChild(
                        themeVm,
                        maxLines: 1,
                        name: "emailWithButton",
                        hintText: "Email",
                      ),
                      value: InputValue(themeVm, validators: [
                        FormBuilderValidators.required(
                            errorText: "Please enter your email address"),
                        FormBuilderValidators.email(
                            errorText: "Please enter a valid email address")
                      ])))),
          DefaultButton(
              decorationBuilder: (themeVm, type) => ButtonDecoration(themeVm,
                  type: type,
                  action: ButtonAction(themeVm, onPressed: () {
                    if (formModel.isValid) {
                      showSnackbar(context, formModel.getValues().toString());
                    }
                  }),
                  child: ButtonChild(themeVm, text: "Subscribe")))
        ],
      ).spaced(10),
    );
  }
}

class _Form extends StatelessWidget {
  _Form();

  final formModel = FormModel();

  @override
  Widget build(BuildContext context) {
    return DefaultForm(
      vm: formModel,
      child: WithLabel(
        labelBuilder: (themeVm) => LabelDecoration(themeVm,
            child: LabelChild(themeVm, text: "Username")),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultInput(
                decorationBuilder: (themeVm) => InputDecor(themeVm,
                    child: InputChild(themeVm,
                        name: "username",
                        hintText: "Username",
                        helperText: "This is your public display name"),
                    value: InputValue(themeVm, validators: [
                      FormBuilderValidators.minLength(2,
                          errorText: 'Username must be at least 2 characters.')
                    ]))),
            DefaultButton(
                decorationBuilder: (themeVm, type) => ButtonDecoration(themeVm,
                    type: type,
                    action: ButtonAction(themeVm, onPressed: () {
                      if (formModel.isValid) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(formModel.getValues().toString())));
                      }
                    }),
                    child: ButtonChild(themeVm, text: "Submit")))
          ],
        ).spaced(20),
      ),
    );
  }
}
