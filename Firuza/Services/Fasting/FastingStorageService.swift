import Foundation

final class FastingStorageService {
    
    private let activeKey = "active_fasting_state"
    private let historyKey = "fasting_history"
    
    // MARK: - Active State
    
    func saveActiveState(
        _ state: ActiveFastingState
    ) {
        if let data = try? JSONEncoder().encode(state) {
            UserDefaults.standard.set(
                data,
                forKey: activeKey
            )
        }
    }
    
    func loadActiveState() -> ActiveFastingState? {
        
        guard
            let data = UserDefaults.standard.data(
                forKey: activeKey
            ),
            let state = try? JSONDecoder().decode(
                ActiveFastingState.self,
                from: data
            )
        else {
            return nil
        }
        
        return state
    }
    
    func removeActiveState() {
        UserDefaults.standard.removeObject(
            forKey: activeKey
        )
    }
    
    // MARK: - History
    
    func saveHistory(
        _ history: [FastingSession]
    ) {
        if let data = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(
                data,
                forKey: historyKey
            )
        }
    }
    
    func loadHistory() -> [FastingSession] {
        
        guard
            let data = UserDefaults.standard.data(
                forKey: historyKey
            ),
            let history = try? JSONDecoder().decode(
                [FastingSession].self,
                from: data
            )
        else {
            return []
        }
        
        return history
    }
}
