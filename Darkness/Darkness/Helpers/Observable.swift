//
//  Observable.swift
//  Darkness
//
//  Created by Joan Disho on 27.10.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Foundation

struct Observation<T> {
    var observer: ((T) -> Void)
}

class Observable<T> {
    private let lock = Mutex()
    private var observers = [UUID: Observation<T>]()

    private var _value: T {
        didSet {
            observers.values.forEach { observation in
                observation.observer(_value)
            }
        }
    }

    var value: T {
        get {
            _value
        }
        set {
            lock.lock()
            defer { lock.unlock() }

            _value = newValue
        }
    }

    init(_ value: T) {
        self._value = value
    }

    func observe(_ observation: Observation<T>) {
        lock.lock()

        defer {
            lock.unlock()
        }

        observers[UUID()] = observation
        observation.observer(value)
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
