import SwiftUI

struct NavigationLinkView<Destination>: View where Destination: View {
    let title: String
    let buttonTitle: String
    let destination: Destination

    @State private var isActive = false

    var body: some View {
        HStack {
            NavigationLink(destination: destination,
                           isActive: $isActive,
                           label: { EmptyView() })

            Text(title)

            Spacer()

            Button(buttonTitle) {
                self.isActive.toggle()
            }
            .modifier(PrimaryButton())
        }
    }
}

struct NavigationLinkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkView(title: "Mission",
                           buttonTitle: "ABC DEF",
                           destination: Text("Hello world")
        )
        .padding()
    }
}
