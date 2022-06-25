
part of 'serializers.dart';


Serializers _$serializers = (new Serializers().toBuilder()
      ..add(ChatMessagesRecord.serializer)
      ..add(ChatsRecord.serializer)
      ..add(UsersRecord.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(DocumentReference, const [const FullType(Object)])
          ]),
          () => new ListBuilder<DocumentReference<Object>>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(DocumentReference, const [const FullType(Object)])
          ]),
          () => new ListBuilder<DocumentReference<Object>>()))
    .build();

