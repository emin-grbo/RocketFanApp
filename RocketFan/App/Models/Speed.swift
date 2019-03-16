import Foundation

//swiftlint:disable identifier_name
struct Speed {
    let kn: Double?
    let kph: Double?
    let mph: Double?

    init?(kn: Double? = nil,
          kph: Double? = nil,
          mph: Double? = nil) {

        if kn == nil &&
            kph == nil &&
            mph == nil {
            return nil
        }

        self.kn = kn
        self.kph = kph
        self.mph = mph
    }
}
