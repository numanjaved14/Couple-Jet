
import 'package:form_field_validator/form_field_validator.dart';

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'password is required'),
  MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
]);
final emailValidator=MultiValidator([
  EmailValidator(errorText: 'enter a valid email address'),
  RequiredValidator(errorText: 'email is required'),
]);
