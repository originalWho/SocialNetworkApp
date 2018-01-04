import Foundation

protocol TranslateManagerObserver: StorageManagerObserver {

}

final class TranslateManager: BaseStorageManager<TranslatedText> {

    static let shared = TranslateManager()
    
}
