import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:type_ahead/bloc/type_ahead_bloc.dart';

import 'package:type_ahead/core/ext.dart';
import 'package:type_ahead/generated/locale_keys.g.dart';
import 'package:type_ahead/model/type_ahead_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TypeAheadBloc>(context);

    return BlocBuilder<TypeAheadBloc, TypeAheadState>(
      bloc: bloc,
      builder: (context, state) {
        final event = state.selectedEvent;
        if (event == null) {
          return Center(child: Text(LocaleKeys.details_empty_event.tr()));
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(event.title, maxLines: 2),
          ),
          body: SafeArea(
            child: DetailWidget(eventModel: event),
          ),
        );
      },
    );
  }
}

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    Key? key,
    required this.eventModel,
  }) : super(key: key);

  final EventModel eventModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DetailEventImage(image: eventModel.image, id: eventModel.id),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(eventModel.date.toStr,
                style: Theme.of(context).textTheme.headlineSmall),
          ),
          Text(eventModel.venue, style: Theme.of(context).textTheme.caption),
        ],
      ),
    );
  }
}

class DetailEventImage extends StatelessWidget {
  const DetailEventImage({
    Key? key,
    required this.image,
    required this.id,
  }) : super(key: key);

  final String image;
  final String id;

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) {
      return const FlutterLogo();
    }
    return Hero(
      tag: 'image$id',
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image(
            image: NetworkImage(image),
            fit: BoxFit.fill,
          )),
    );
  }
}
