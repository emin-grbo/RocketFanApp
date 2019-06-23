import SwiftUI

struct LaunchesListView: View {
    @ObjectBinding var model: LaunchesViewModel
    private let dateFormatter = DateFormatter()

    var body: some View {
        List(model.launches.identified(by: \.missionId)) { launch in
            LaunchRow(viewModel: self.launchViewModel(with: launch))
        }
    }

    private func launchViewModel(with launch: Launch) -> LaunchCellViewModel {
        return LaunchCellViewModel(with: launch, dateFormatter)
    }
}

//#if DEBUG
//struct LaunchesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchesListView(launches: launchesTestData)
//    }
//}
//#endif
