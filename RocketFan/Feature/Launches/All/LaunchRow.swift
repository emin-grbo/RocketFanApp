import SwiftUI
import KingfisherSwiftUI

struct LaunchRow: View {
    let viewModel: LaunchCellViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.missionName)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer().fixedSize()
                ImageWithText(imageName: "calendar",
                              text: viewModel.launchDate,
                              font: .subheadline)
                
                ImageWithText(imageName: "map",
                              text: viewModel.siteShortName,
                              font: .subheadline)
                
                ImageWithText(imageName: "airplane",
                              text: viewModel.rocketName,
                              font: .subheadline)
            }
            
            Spacer()
            KFImage(viewModel.missingPatchSmallURL)
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
            
        }
    }
}

private struct ImageWithText: View {
    let imageName: String
    let text: String
    let font: Font
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(text)
                .font(font)
                .foregroundColor(.secondary)
        }
    }
}

#if DEBUG
struct LaunchRow_Previews: PreviewProvider {
    static var previews: some View {
        LaunchRow(viewModel: LaunchCellViewModel(with: launchesTestData[0], DateFormatter()))
            .previewLayout(.fixed(width: 320, height: 110))
    }
}
#endif
