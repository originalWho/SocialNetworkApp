import Foundation

protocol Storable: Hashable, Comparable {

}

protocol StorageManager {

    associatedtype Observer
    associatedtype Entry: Storable

    var storage: [Entry] { get }

    func add(entry: Entry)
    func remove(entry: Entry)
    func subscribe(observer: Observer)
    func unsubscribe(observer: Observer)

}

protocol StorageManagerObserver: class {

    func storageManager<Manager: StorageManager, Entry: Storable>(_ storageManager: Manager, onDataChangedFor entry: Entry)

}

class BaseStorageManager<E: Storable>: StorageManager {

    var storage: [E] {
        return _storage.sorted(by: <)
    }

    private var _storage: Set<E>
    private var observers: [StorageManagerObserver]

    init() {
        _storage = []
        observers = []
    }

    func add(entry: E) {
        _storage.insert(entry)
        notifyObservers(for: entry)
    }

    func remove(entry: E) {
        _storage.remove(entry)
        notifyObservers(for: entry)
    }

    func subscribe(observer: StorageManagerObserver) {
        if !observers.contains(where: { $0 === observer }) {
            observers.append(observer)
        }
    }

    func unsubscribe(observer: StorageManagerObserver) {
        if let index = observers.index(where: { $0 === observer }) {
            observers.remove(at: index)
        }
    }

    func notifyObservers(for entry: E) {
        for observer in observers {
            observer.storageManager(self, onDataChangedFor: entry)
        }
    }

}
