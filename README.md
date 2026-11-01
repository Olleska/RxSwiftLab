# RxSwiftLab

**Исследуемая библиотека:** RxSwift, версия **6.10.2**
**Репозиторий библиотеки:** https://github.com/ReactiveX/RxSwift

**Механизм:** цепочка операторов Observable (разделение Producer и Sink)
на примере `just → map → filter → subscribe`

## Что делает демо
`main.swift` собирает цепочку `Observable.just(1).map { $0 * 10 }.filter { $0 > 5 }`
(на этом этапе замыкания ещё не вызываются) и затем подписывается на неё
Демо нужно запускать с breakpoint'ами, чтобы видеть путь события через внутренние классы

## Как запустить
1. Откройте `RxSwiftLab.xcodeproj` в Xcode.
2. Дождитесь загрузки пакета RxSwift 6.10.2. Если не загрузился:
   File → Packages → Resolve Package Versions
3. Выберите схему `RxSwiftLab`, устройство `My Mac`, нажмите Run

Ожидаемый вывод:
цепочка собрана, подписки ещё нет
next: 10
completed


## Где ставить breakpoint
В навигаторе: Package Dependencies → RxSwift → Sources → RxSwift
- `Producer.swift`: начало `subscribe` (сработает 2 раза: Filter, затем Map)
- `Filter.swift`: `Filter.run` и `FilterSink.on`
- `Map.swift`: `Map.run` и `MapSink.on`
- `Just.swift`: `Just.subscribe`
- `Sink.swift`: `forwardOn`

Порядок: Producer.subscribe (Filter) → Filter.run → Producer.subscribe (Map) →
Map.run → Just.subscribe → MapSink.on → forwardOn → FilterSink.on → forwardOn →
(печать `next: 10`) → то же для `completed`


