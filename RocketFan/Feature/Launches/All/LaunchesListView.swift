import SwiftUI

struct LaunchesListView: View {
    @ObservedObject var model: LaunchesViewModel
    private let dateFormatter = DateFormatter()

    var body: some View {
        List(model.launches, id: \.flightNumber) { launch in
            LaunchRow(viewModel: self.launchViewModel(with: launch))
        }
    }

    private func launchViewModel(with launch: Launch) -> LaunchCellViewModel {
        return LaunchCellViewModel(with: launch, dateFormatter)
    }
}
