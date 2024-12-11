import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leviosa/model/game_model.dart';

class GameCubit extends Cubit<GameModel> {
  GameCubit()
      : super(
          GameModel(
            lastActive: Timestamp(0, 0),
            lesson: 1,
            level: 1,
            coins: 0,
            streak: 0,
          ),
        );

  void setGame(GameModel gameModel) {
    emit(gameModel);
  }
}
