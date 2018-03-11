import Foundation

final class TutorServiceExercise {

    enum ExerciseType {
        case fillTheGap
        case nameTheObject
        case translateToOriginLanguage
        case translateToNativeLanguage
    }

    enum ResponseType {
        case audio
        case image
        case text
    }

    enum FeedbackType {
        case incorrect
        case correct
    }

    enum ResultType {
        case notFinished
        case failed
        case succeededWithManyErrors
        case succeededWithAnError
        case succeededWithNoErrors
    }

    private(set) var resultType: ResultType = .notFinished {
        didSet {
            service?.updateCompetency(for: entry.hashValue, result: resultType)
        }
    }

    // MARK: - Private properties

    private weak var service: TutorService?
    private let entry: DictionaryEntry
    private let exerciseType: ExerciseType
    private let responseType: ResponseType
    private let attemptsCount: Int
    private var currentAttempt: Int = 0

    init(entry: DictionaryEntry, exerciseType: ExerciseType,
         responseType: ResponseType, attemptsCount: Int) {
        // TODO: Handle invalid configurations
        self.entry = entry
        self.exerciseType = exerciseType
        self.responseType = responseType
        self.attemptsCount = attemptsCount
    }

    func verify(answer answerData: Data) -> (feedback: FeedbackType, message: String) {
        guard resultType == .notFinished else {
            return (feedback: .incorrect, message: "Not again")
        }

        currentAttempt += 1
        let isCorrect = checkCorrectAnswer(answerData)

        let feedbackType: FeedbackType
        let message: String

        if isCorrect {
            feedbackType = .correct
            if currentAttempt == 1 {
                resultType = .succeededWithNoErrors
                message = "That's great!"
            }
            else if currentAttempt == 2 {
                resultType = .succeededWithAnError
                message = "Good! Next time you'll crack it for sure!"
            }
            else {
                resultType = .succeededWithManyErrors
                message = "You finally did it! I'm so proud of you!"
            }
        }
        else {
            feedbackType = .incorrect
            if currentAttempt == attemptsCount {
                resultType = .failed
                message = "I'm sorry! Don't give up!"
            }
            else {
                message = "Try again"
            }
        }

        return (feedback: feedbackType, message: message)
    }

    private func checkCorrectAnswer(_ data: Data) -> Bool {
        switch (exerciseType, responseType) {
        case (.fillTheGap, .text):
            return true

        case (.fillTheGap, .audio):
            return true

        case (.fillTheGap, .image):
            return true

        case (.nameTheObject, .text):
            return true

        case (.nameTheObject, .audio):
            return true

        case (.translateToOriginLanguage, .text):
            return true

        case (.translateToNativeLanguage, .text):
            return true

        default:
            assertionFailure("Unsupported")
            return false
        }
    }

}

final class TutorService: DictionaryManagerObserver {

    enum Competence: Int {
        case notLearnt
        case barelyLearnt
        case almostLearnt
        case learnt
    }

    typealias DictionaryEntryHashValue = Int

    // MARK: - Static internal properties

    static let shared = TutorService()

    // MARK: - Internal properties

    private(set) var exercisesQueue: [TutorServiceExercise] = []

    // MARK: - Private properties

    private var competenceStorage: [DictionaryEntryHashValue:Competence] = [:]
    private var dateStorage: [DictionaryEntryHashValue:Date] = [:]
    private let repeatTimeInterval: TimeInterval = 60.0 * 10
    private let dayTimeInterval: TimeInterval = 60.0 * 60.0 * 24

    init() {
        DictionaryManager.shared.subscribe(observer: self)
    }

    deinit {
        DictionaryManager.shared.unsubscribe(observer: self)
    }

    func startScheduling() {
        Timer.scheduledTimer(withTimeInterval: repeatTimeInterval, repeats: true) { [weak self] timer in
            guard let `self` = self else { return }

            let currentDate = Date()
            for (entryHashValue, date) in self.dateStorage where date <= currentDate {
                guard let entryIndex = DictionaryManager.shared.storage.index(where: { $0.hashValue == entryHashValue }) else { continue }
                let entry = DictionaryManager.shared.storage[entryIndex]
                let exercise = TutorServiceExercise(entry: entry, exerciseType: .nameTheObject, responseType: .text, attemptsCount: 3)
                self.exercisesQueue.append(exercise)
            }
        }
    }

    func updateCompetency(for entryHashValue: DictionaryEntryHashValue, result: TutorServiceExercise.ResultType) {
        guard competenceStorage[entryHashValue] != nil else { return }

        switch result {
        case .notFinished:
            return

        case .failed:
            competenceStorage[entryHashValue] = .notLearnt
            dateStorage[entryHashValue] = Date().addingTimeInterval(repeatTimeInterval / 2.0)

        case .succeededWithManyErrors, .succeededWithAnError:
            if competenceStorage[entryHashValue] == .notLearnt {
                competenceStorage[entryHashValue] = .barelyLearnt
                dateStorage[entryHashValue] = Date().addingTimeInterval(dayTimeInterval / 2.0)
            }
            else {
                dateStorage[entryHashValue] = Date().addingTimeInterval(dayTimeInterval)
            }

        case .succeededWithNoErrors:
            if competenceStorage[entryHashValue] == .notLearnt {
                competenceStorage[entryHashValue] = .barelyLearnt
                dateStorage[entryHashValue] = Date().addingTimeInterval(dayTimeInterval / 2.0)
            }
            else if competenceStorage[entryHashValue] == .barelyLearnt {
                competenceStorage[entryHashValue] = .almostLearnt
                dateStorage[entryHashValue] = Date().addingTimeInterval(dayTimeInterval)
            }
            else if competenceStorage[entryHashValue] == .almostLearnt {
                competenceStorage[entryHashValue] = .learnt
                dateStorage[entryHashValue] = Date().addingTimeInterval(dayTimeInterval * 2.0)
            }
        }
    }

    // MARK: - DictionaryManagerObserver protocol

    func storageManager<Manager, Entry>(_ storageManager: Manager, onDataChangedFor entry: Entry)
        where Manager: StorageManager, Entry: Storable {
            guard let entry = entry as? DictionaryEntry else { return }
            competenceStorage[entry.hashValue] = .notLearnt
            dateStorage[entry.hashValue] = Date().addingTimeInterval(repeatTimeInterval / 2.0)
    }

}
