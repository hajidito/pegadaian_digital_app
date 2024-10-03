import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pegadaian_digital/data/model/response/history_response.dart';
import 'package:pegadaian_digital/presentation/feature/history/bloc/history_bloc.dart';
import 'package:pegadaian_digital/presentation/feature/history/widgets/list_history.dart';
import 'package:pegadaian_digital/presentation/widgets/loading_dialog.dart';

import '../../../helpers/colors_custom.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  BuildContext? _dialogContext;

  static const failedSnackbar = SnackBar(
    content: Text('Gagal Mendapatkan Data'),
  );

  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(GetHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryBloc, HistoryState>(
      listener: (context, state) {
        if (state is HistoryLoadingState) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              _dialogContext = context;
              return PopScope(
                canPop: false,
                child: LoadingDialog(),
              );
            },
          );
        }

        if (state is HistoryLoadedState) {
          if (_dialogContext != null && _dialogContext!.mounted) {
            Navigator.pop(_dialogContext!);
          }
        }

        if (state is HistoryErrorState) {
          if (_dialogContext != null && _dialogContext!.mounted) {
            Navigator.pop(_dialogContext!);
          }

          ScaffoldMessenger.of(context).showSnackBar(failedSnackbar);
        }
      },
      builder: (context, state) {
        if (state is HistoryLoadedState) {
          return Scaffold(
            appBar: AppBar(
              leading: null,
              title: Text("History"),
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(1.0),
                  child: Container(
                    color: ColorsCustom.borderSoft,
                    height: 1.0,
                  )),
            ),
            body: SafeArea(
              child: _buildListView(
                  context, state.historyResponse.data?.items ?? List.empty()),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildListView(BuildContext context, List<Item> list) {
    return ListView.separated(
      padding: EdgeInsets.all(0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, index) {
        Item selected = list[index];
        return ListHistory(
          checkIn: DateTime.fromMicrosecondsSinceEpoch(selected.createdAt ?? 0),
          checkOut:
              DateTime.fromMicrosecondsSinceEpoch(selected.updatedAt ?? 0),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 20,
        );
      },
    );
  }
}
