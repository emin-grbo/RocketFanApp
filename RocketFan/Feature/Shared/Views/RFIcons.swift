import SwiftUI

enum RFIcons: String {
    
    // Mission detail icons
    case apoapsis
    case block
    case customers
    case flightNumber
    case images
    case inclanation
    case landingSuccess
    case landingType
    case landingVehicle
    case load
    case longitude
    case manufacturer
    case nationality
    case orbit
    case periapsis
    case reused
    case serial
    case type
    case watchVideo
    
    // Missions list icons
    case date
    case launchPad
    case rocket
    
    var icon: some View {
        // Defining tint instead of having it in initially setup in case we'd want to adapt the color based on the theme light/dark
        return Image(self.rawValue).foregroundColor(Theme.secondary)
    }
}

// conforming to CaseIterable for testing
extension RFIcons: CaseIterable { }
