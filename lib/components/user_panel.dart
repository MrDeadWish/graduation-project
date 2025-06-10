import 'dart:io';

import 'package:binevir/data/repository/settings_repository.dart';
import 'package:binevir/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/image_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'overlay_container.dart';

class UserPanel extends StatefulWidget {
  final FocusNode? focusNode;
  final bool? edit;
  final ChangeImage? onTap;
  final String? photo;
  final String? name;
  const UserPanel({
    super.key,
    this.focusNode,
    this.edit,
    this.onTap,
    this.photo,
    this.name,
  });

  @override
  State<UserPanel> createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  bool _openInfo = false;

  late Box person;
  final settingsRepository = getIt<SettingsRepository>();

  @override
  void initState() {
    person = Hive.box('person_box');
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appUser = person.get('AppUser');

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 12.0,
          ),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(244, 244, 244, 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 34,
                            backgroundColor: Colors.white,
                            onBackgroundImageError: (exception, stackTrace) {},
                            backgroundImage: setPhoto(widget.photo ??
                                (appUser != null ? appUser.photo : '')),
                          ),
                          Material(
                            shape: const CircleBorder(),
                            clipBehavior: Clip.hardEdge,
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.black.withOpacity(0.1),
                              onTap: widget.onTap,
                              child: const CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 34,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (widget.edit == true)
                        const SizedBox(
                          height: 10,
                        ),
                      if (widget.edit == true)
                        Text(AppLocalizations.of(context)!.photo,
                            style: const TextStyle(
                              fontSize: 10,
                              height: 1.2,
                              fontWeight: FontWeight.w400,
                            )),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.name ??
                        (appUser != null
                            ? appUser.first_name +
                                (appUser.middle_name != ''
                                    ? '\n' + appUser.middle_name!
                                    : '')
                            : 'User'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              widget.edit == true
                  ? Material(
                      shape: CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: InkWell(
                        child: IconButton(
                          onPressed: () {
                            GoRouter.of(context).push('/profile/edit');
                          },
                          icon: SvgPicture.asset('assets/icons/edit.svg'),
                        ),
                      ),
                    )
                  : Material(
                      shape: const CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: InkWell(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _openInfo = _openInfo == true ? false : true;
                            });
                          },
                          icon: SvgPicture.asset('assets/icons/info.svg'),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        OverlayContainer(
          show: _openInfo == true ? true : false,
          asWideAsParent: true,
          position: const OverlayContainerPosition(
            0,
            -80,
          ),
          child: Container(
            padding: const EdgeInsets.all(30),
            margin: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(245, 245, 245, 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.contacts.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                if (settingsRepository.settings.siteUrl != '')
                  InkWell(
                    onTap: () => launchUrl(
                        Uri.parse(settingsRepository.settings.siteUrl)),
                    child: Text(
                      settingsRepository.settings.siteUrl,
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                if (settingsRepository.settings.siteUrl != '')
                  const SizedBox(
                    height: 15.0,
                  ),
                if (settingsRepository.settings.phone != '')
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Phone: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: settingsRepository.settings.phone,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (settingsRepository.settings.phone != '')
                  const SizedBox(
                    height: 15.0,
                  ),
                if (settingsRepository.settings.email != '')
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'E-mail: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: settingsRepository.settings.email,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

setPhoto(String path) {
  if (File(path).existsSync()) {
    return Image.file(File(path)).image;
  } else {
    return Image.asset(AppImages().userDefaultPhoto).image;
  }
}

typedef ChangeImage = void Function();
