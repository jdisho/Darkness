//
//  Observable.swift
//  Darkness
//
//  Created by Joan Disho on 27.10.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Foundation

/// An Observable will give any subscriber the most recent element
/// and everything that is emitted by that sequence after the subscription happened.
class Observable<T> {
    private let lock = Mutex()
    private var observers = [UUID: ((T) -> Void)]()

    private var _value: T {
        didSet {
            observers.values.forEach { $0(_value) }
        }
    }

    var value: T {
        return _value
    }

    init(_ value: T) {
        self._value = value
    }

    func subscribe(_ observer: @escaping ((T) -> Void)) {
        lock.lock()
        defer { lock.unlock() }

        observers[UUID()] = observer
        observer(value)
    }

    func next(_ newValue: T) {
        lock.lock()
        defer { lock.unlock() }

        _value = newValue
    }
}
private final class Mutex {
    private var mutex: pthread_mutex_t = {
        var mutex = pthread_mutex_t()
        pthread_mutex_init(&mutex, nil)
        return mutex
    }()

    func lock() {
        pthread_mutex_lock(&mutex)
    }

    func unlock() {
        pthread_mutex_unlock(&mutex)
    }
}
