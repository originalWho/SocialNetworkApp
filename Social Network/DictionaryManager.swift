import Foundation

protocol DictionaryManagerObserver: StorageManagerObserver {



}

final class DictionaryManager: BaseStorageManager<DictionaryEntry> {

    static let shared = DictionaryManager()

}
