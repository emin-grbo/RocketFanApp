import Foundation
import Files

let scriptsFolder = try Folder.current.subfolder(named: "Scripts")
let currentTimestamp = Date().timeIntervalSinceReferenceDate

//Run once a day, verify against a .lastRun file
if let lastRunFile = try? scriptsFolder.file(named: ".launchpadLastRun") {
    let lastRunTimestamp = try TimeInterval(lastRunFile.readAsInt())
    let oneDayInterval: TimeInterval = 60 * 60 * 24
    let timestampDelta = currentTimestamp - lastRunTimestamp

    //Less than a day passed, let's not run the script
    if timestampDelta < oneDayInterval {
        exit(0)
    }
}

//Download time!
let url = URL(string: "https://api.spacexdata.com/v3/launchpads")!
let json = try Data(contentsOf: url)

//Writing file...
let resourceFolder = try Folder.current.subfolder(atPath: "RocketFan/Resources/Data")
try resourceFolder.createFile(named: "launchpad.json", contents: json)

//Save lastRun
let lastRunFile = try scriptsFolder.createFile(named: ".launchpadLastRun")
try lastRunFile.write(string: String(Int(currentTimestamp)))
