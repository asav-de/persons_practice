# План практики: Riverpod на примере списка персон

Цель: понять провайдеры (Riverpod 3), написав всё самому по шагам.
Образец: проект `../i12_intro_012` (todo-приложение с `Notifier<AppState>`).

Отмечай `[x]`, когда шаг готов.

Формат работы: код пишу сам, по маленьким шагам. Нужны подсказки и объяснения «почему», а не готовые решения. После шага проверка кода.

---

## Шаг 0. Проект ✅
- [x] `flutter create persons_practice`
- [x] `flutter pub add flutter_riverpod uuid`

## Шаг 1. Модель `Person` ✅
`lib/models/person.dart`
- [x] поля `id` (String, uuid), `name` (String), `age` (int)
- [x] `@immutable`, `final`, `const` конструктор
- [x] `copyWith`, `==`, `hashCode` (`toJson`/`fromJson` есть, но для практики не нужны)

## Шаг 2. Первый провайдер ✅
- [x] `runApp(const ProviderScope(child: MyApp()))`
- [x] `final helloProvider = Provider<String>((ref) => 'Hallo');` (вне классов)
- [x] `HomeScreen extends ConsumerWidget`, `Text(ref.watch(helloProvider))`
- [x] мелочь: в `HomeScreen.build` дописать тип возврата `Widget`

## Шаг 3. Notifier со списком
`lib/providers/person_notivier.dart`
- [x] `class PersonsNotifier extends Notifier<List<Person>>`
- [x] `build()` возвращает 3 персоны с `_uuid.v4()`
- [x] `personsProvider = NotifierProvider<PersonsNotifier, List<Person>>(PersonsNotifier.new)`
- [x] `removePerson(String id)` → `state = state.where((p) => p.id != id).toList();`
- [x] **3а. проверка:** в `main.dart` импортировать notifier, вывести `Text('${ref.watch(personsProvider).length}')`, на экране должно быть **3**. Потом удалить `helloProvider`.

## Шаг 4. Виджеты списка ✅
- [x] `lib/widgets/person_tile.dart`: `PersonTile extends StatelessWidget`
  - поля `final Person person;`, `final VoidCallback onDelete;`
  - `ListTile(title: имя, subtitle: возраст, trailing: IconButton(🗑, onPressed: onDelete))`
- [x] `HomeScreen`: `final persons = ref.watch(personsProvider);` → `ListView.builder` с `PersonTile`
- [x] пока `onDelete: () {}`

## Шаг 5. Удаление ✅ (← дальше шаг 6)
- [x] `onDelete: () => ref.read(personsProvider.notifier).removePerson(person.id)`
- [x] понять разницу:
  - `ref.watch(provider)`: в `build`, подписка и перерисовка
  - `ref.read(provider.notifier)`: в колбэках, вызвать метод

## Шаг 6. Добавление
- [ ] метод `addPerson(String name, int age)` в `PersonsNotifier` (`state = [...state, новая]`)
- [ ] FAB: сначала добавлять случайную персону, потом диалог с вводом

## Шаг 7. Эксперименты (самое полезное)
- [ ] сломать иммутабельность: `state.removeWhere(...)` вместо нового списка. Обновится ли UI? Почему?
- [ ] `print` в `build` экрана и тайла: кто перерисовывается при удалении?
- [ ] счётчик в AppBar: `ref.watch(personsProvider.select((p) => p.length))`
- [ ] производный провайдер `adultsProvider = Provider<List<Person>>(...)` + переключатель «только взрослые»
- [ ] заменить `ref.watch` на `ref.read` в `build`: что сломалось?

## Шаг 8. Бонус, как в i12
- [ ] выделение долгим нажатием (`ConsumerStatefulWidget` + `Set<String> _selectedIds`)
- [ ] удаление нескольких с диалогом подтверждения
- [ ] понять: что локальное состояние (`setState`), а что глобальное (провайдер)

---

## Что уже понятно (шпаргалка)
- `helloProvider` / `personsProvider`: **ключ/табличка**, объявляется вне классов, сам ничего не хранит
- `ProviderScope`: **склад**, где лежат значения
- `Notifier<T>`: **кладовщик**, `T` — тип того, что хранится (`state`)
- `build()` в Notifier: начальное содержимое склада
- менять `state` можно только внутри Notifier и только **новым** объектом, тогда Riverpod перерисует экран
- провайдер нужен не каждому классу, а каждому куску общего состояния; модели (`Person`) провайдеров не имеют
- методы, меняющие список (add/remove), лежат в Notifier, потому что `Person` не знает о списке
- не использовать `as` для «получения» значения из провайдера, нужно `ref.watch(...)`
- `.notifier` — объект класса `PersonsNotifier` (кладовщик), а не `Person`
- `onDelete: () => f(x)` передаёт функцию на потом; `onDelete: f(x)` вызывает сразу во время build
- `ref.read` лучше писать внутри колбэка, а не в `build`

## Вопросы для самопроверки перед ревью
- Чем `Provider` отличается от `NotifierProvider`?
- Зачем `.notifier`?
- Почему `state.add(x)` не обновляет UI?
- Где хранить выделенные элементы, в провайдере или в `State`? Почему?
