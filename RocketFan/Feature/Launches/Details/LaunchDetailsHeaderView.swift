import SwiftUI

struct LaunchDetailsHeaderView: View {
    private let viewModel: LaunchDetailsViewModel

    init(launch: Launch) {
        self.viewModel = LaunchDetailsViewModel(launch: launch)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(viewModel.title)
                .font(.title)
                .foregroundColor(.primary)

            Group {
                Text(viewModel.date)
                Text(viewModel.flightNumber)
            }
            .font(.caption)
            .foregroundColor(.secondary)

            Text(viewModel.description)
                .font(.body)
                .lineLimit(nil)
                .padding(.top, 30)
        }
    }
}

#if DEBUG
struct LaunchDetailsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchDetailsHeaderView(launch: launchesTestData[30])
    }
}
#endif
