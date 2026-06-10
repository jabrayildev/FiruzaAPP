import Foundation

final class FastingTimerService {

    private var timer: Timer?

    func start(
        action: @escaping () -> Void
    ) {

        stop()

        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { _ in
            action()
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
