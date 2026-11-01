//
//  main.swift
//  
//
//  Created by Олеся Лыжина on 27.10.2026.
//

import RxSwift

let disposeBag = DisposeBag()

let source = Observable.just(1)
let mapped = source.map { $0 * 10 }
let filtered = mapped.filter { $0 > 5 }
print("цепочка собрана, подписки ещё нет")

filtered.subscribe(
        onNext: { print("next:", $0) },
        onCompleted: { print("completed") }
    ).disposed(by: disposeBag)
