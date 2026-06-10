import SwiftUI
import Combine

final class FastingRingViewModel: ObservableObject {
    
    // MARK: - Published
    
    @Published var progress: CGFloat = 0.0
    @Published var remainingTime: String = "16:00:00"
    @Published var percentageText: String = "100% remaining"
    
    @Published var isShowingElapsed = false
    
    @Published var selectedMarker: FastingMarker?
    @Published var showMarkerSheet = false
    
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    
    @Published var selectedPlan: FastingPlan = .sixteen {
        didSet {
            if isFastingActive {
                restartTimer()
                persistActiveState()
            } else {
                remainingTime = String(
                    format: "%02d:00:00",
                    selectedPlan.hours
                )
                
                endDate = Calendar.current.date(
                    byAdding: .hour,
                    value: selectedPlan.hours,
                    to: startDate
                ) ?? startDate
            }
        }
    }
    
    @Published var isFastingActive: Bool = false
    @Published var history: [FastingSession] = []
    
    // MARK: - Private

    private let storageService = FastingStorageService()
    
    private let calculationService = FastingCalculationService()
    
    // MARK: - Init
    
    init() {
        loadHistory()
        loadActiveState()
    }
    
    // MARK: - MARKERS
    
    var availableMarkers: [FastingMarker] {
        FastingMarker.allMarkers.filter {
            $0.hour <= totalPlanHours
        }
    }
    
    var totalPlanHours: Int {
        selectedPlan.hours
    }
    
    // MARK: - TEXT
    
    var titleText: String {
        isShowingElapsed
        ? "Прошло времени"
        : "Осталось времени"
    }
    
    var startTimeText: String {
        DateTimeFormatter.formatDate(startDate)
    }
    
    var endTimeText: String {
        DateTimeFormatter.formatDate(endDate)
    }
    
    // MARK: - TIMER CORE
    
    func startTimer() {

        timerService.start { [weak self] in
            self?.refreshFromDates()
        }
    }
    
    func restartTimer() {
        timerService.stop()
        startTimer()
    }
    
    // MARK: - START / STOP
    
    func startFasting() {
        
        timerService.stop()
        
        isFastingActive = true
        
        endDate = Calendar.current.date(
            byAdding: .hour,
            value: totalPlanHours,
            to: startDate
        ) ?? startDate
        
        progress = 0
        percentageText = "0% осталось"
        
        startTimer()
        persistActiveState()
    }
    
    func stopFasting() {
        
        timerService.stop()
        
        isFastingActive = false
        
        let end = Date()
        
        let elapsed = end.timeIntervalSince(startDate)
        let totalSeconds = TimeInterval(totalPlanHours * 60 * 60)
        
        progress = min(
            CGFloat(elapsed / totalSeconds),
            1.0
        )
        
        saveSession(endDate: end)
        
        remainingTime = "00:00:00"
        percentageText = "Остановлено"
        
        storageService.removeActiveState()
    }
    
    func toggleFasting() {
        isFastingActive
        ? stopFasting()
        : startFasting()
    }
    
    // MARK: - DATE CHANGE
    
    func applyStartDateChange(_ newDate: Date) {
        
        startDate = newDate
        
        endDate = Calendar.current.date(
            byAdding: .hour,
            value: totalPlanHours,
            to: startDate
        ) ?? startDate
        
        if isFastingActive {
            restartTimer()
            persistActiveState()
        }
    }
    
    // MARK: - CORE LOGIC
    
    func refreshFromDates() {
        
        if !isFastingActive {
            
            let totalSeconds = TimeInterval(
                totalPlanHours * 3600
            )
            
            if isShowingElapsed {
                
                remainingTime = "00:00:00"
                percentageText = "0% сделано"
                
            } else {
                
                remainingTime = DateTimeFormatter.formatTime(
                    totalSeconds
                )
                
                percentageText = "100% осталось"
            }
            
            return
        }
        
        let now = Date()
        
        let remaining = calculationService.remainingTime(
            endDate: endDate,
            currentDate: now
        )

        if remaining <= 0 {
            
            progress = 1.0
            
            remainingTime = "00:00:00"
            percentageText = "100% завершено"
            
            isFastingActive = false
            
            storageService.removeActiveState()
            
            return
        }

        let elapsed = calculationService.elapsedTime(
            startDate: startDate,
            currentDate: now
        )

        progress = calculationService.progress(
            startDate: startDate,
            endDate: endDate,
            currentDate: now
        )
        
        if isShowingElapsed {
            
            remainingTime = DateTimeFormatter.formatTime(elapsed)
            
            percentageText =
            "\(Int(progress * 100))% сделано"
            
        } else {
            
            remainingTime = DateTimeFormatter.formatTime(
                remaining
            )
            
            percentageText =
            "\(Int((1 - progress) * 100))% осталось"
        }
    }
    
    func onAppStart() {
        loadActiveState()
    }
    
    func toggleDisplayMode() {
        
        isShowingElapsed.toggle()
        
        refreshFromDates()
    }
    
    // MARK: - ACTIVE STATE SAVE/LOAD
    
    private func persistActiveState() {
        
        let state = ActiveFastingState(
            startDate: startDate,
            endDate: endDate,
            isFastingActive: isFastingActive,
            selectedPlan: selectedPlan
        )
        
        storageService.saveActiveState(state)
    }
    
    func loadActiveState() {
        
        guard let state = storageService.loadActiveState()
        else {
            return
        }
        
        self.startDate = state.startDate
        self.endDate = state.endDate
        self.isFastingActive = state.isFastingActive
        self.selectedPlan = state.selectedPlan
        
        refreshFromDates()
        
        if isFastingActive {
            startTimer()
        }
    }
    
    // MARK: - HISTORY
    
    func saveSession(endDate: Date) {
        
        let session = FastingSession(
            id: UUID(),
            startDate: startDate,
            endDate: endDate,
            progress: Double(progress)
        )
        
        history.append(session)
        persistHistory()
    }
    
    func loadHistory() {
        history = storageService.loadHistory()
    }
    
    private func persistHistory() {
        storageService.saveHistory(history)
    }
    
    // MARK: - FORMATTERS
    
    
    
    func markerIsCompleted(
        hour: Int
    ) -> Bool {
        
        guard isFastingActive else {
            return false
        }
        
        let elapsedHours =
        Date().timeIntervalSince(startDate) / 3600
        
        return elapsedHours >= Double(hour)
    }
    
    private let timerService = FastingTimerService()
}
