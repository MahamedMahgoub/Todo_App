import 'package:bloc/bloc.dart';

/* دا عباره عن تراس للبلوكات اللى عندى بيعرفنى انا فين واى التغير اللى حصل ةهلى فيه خطأ ولا لا ولو البلوك اتقفل برده  */
class MyBlocObserver extends BlocObserver {
  // اول ما البلوك يتفتح او يتكريت
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

// هنا هيقولك اى التغيرات اللى حصلت واتغير من اى ل اى
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

// هنا لو فيه ايرور حصل هيقول الايرور فين واى هو
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

// هنا لما البلوك يتقفل بيعرفك ان كدا البلوك دا اتقفل او مقفول
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
