//
//  ModelData.swift
//  SilverJourney
//
//  Created by Hassan Talat on 8/21/22.
//

import Foundation

func pathToDocuments() -> String{
    let homeDir: String = NSHomeDirectory()
    return homeDir + "/" + "Documents"
}

var filename = "commands.txt"
var fullpath = pathToDocuments() + "/" + filename


struct Command: Identifiable {
  var id = UUID()
  var isActive: Bool = true
  var cmd: String
}

extension Command {
  static let samples = [
    Command(cmd: "git status"),
    Command(cmd: "git remote -v"),
    Command(cmd: "ls -alh")
  ]
}

/*
 Parse simple text with separated by two newlines.
*/
final class SimpleParser: ObservableObject {
    @Published var filename: String
    @Published var commands: [Command] = []
    
    init(filename: String) {
        let fileContents: String = load(filename)
        self.filename = filename
        if(!fileContents.isEmpty){
            fileContents.components(separatedBy: "\n\n").forEach { rawCommand in
                self.commands.append(Command(cmd: rawCommand))
            }
        }
    }
    
    func getCommands() -> [Command] {
        return commands
    }
}

func load(_ filename: String) -> String {
    do {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: filename) {
            let url = URL(fileURLWithPath: filename)
            try "".write(to: url, atomically: true, encoding: .utf8)
        }
        return try String(contentsOfFile: filename)
    } catch {
        fatalError("Couldn't load \(filename) :\n\(error)")
    }
}
