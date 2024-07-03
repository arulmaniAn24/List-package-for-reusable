import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/list_bloc.dart';
import '../bloc/list_event.dart';

class DownloadWidget extends StatelessWidget {
  const DownloadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Download',
      child: PopupMenuButton<int>(
        offset: const Offset(0, 40),
        onSelected: (value) {
          if (value == 0) {
            BlocProvider.of<ListBloc>(context).add(DownloadCsv());
          } else if (value == 1) {
            BlocProvider.of<ListBloc>(context).add(PrintPdf());
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 0,
            child: Text('Download as CSV'),
          ),
          const PopupMenuItem(
            value: 1,
            child: Text('Print'),
          ),
        ],
        icon: SvgPicture.asset(
          'assets/images/download.svg',
          width: 20,
          height: 20,
          color: const Color(0xFF1F397A),
        ),
      ),
    );
  }
}
