import Foundation
import Files

let scriptsFolder = try Folder.current.subfolder(named: "Scripts")
let currentTimestamp = Date().timeIntervalSinceReferenceDate

//Run once a day, verify against a .lastRun file
if let lastRunFile = try? scriptsFolder.file(named: ".landpadLastRun") {
    let lastRunTimestamp = try TimeInterval(lastRunFile.readAsInt())
    let oneDayInterval: TimeInterval = 60 * 60 * 24
    let timestampDelta = currentTimestamp - lastRunTimestamp

    //Less than a day passed, let's not run the script
    if timestampDelta < oneDayInterval {
        exit(0)
    }
}

//Download time!
let url = URL(string: "https://api.spacexdata.com/v3/landpads")!
let json = try Data(contentsOf: url)

//Writing file...
let resourceFolder = try Folder.current.subfolder(atPath: "RocketFan/Resources/Data")
try resourceFolder.createFile(named: "landpad.json", contents: json)

//Save lastRun
let lastRunFile = try scriptsFolder.createFile(named: ".landpadLastRun")
try lastRunFile.write(string: String(Int(currentTimestamp)))
