import 'package:comida/model/model.dart' as model;
import 'package:comida/network/repositories/repositories.dart';
import 'package:comida/states/bloc/page_bloc.dart';
import 'package:comida/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

part 'social_auth_service.dart';
part 'dynamic_link_service.dart';