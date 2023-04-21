
abstract class GenKeyState {}

class GenKeyInitialState implements GenKeyState {
  GenKeyInitialState();
}
class GenKeyLoadingState implements GenKeyState {
  GenKeyLoadingState();
}
class  GenKeyPasteFinishState implements GenKeyState {
  GenKeyPasteFinishState();
}
class  GenKeyPasteErrorState implements GenKeyState {
  GenKeyPasteErrorState();
}


