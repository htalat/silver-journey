//
//  ContentView.swift
//  SilverJourney
//
//  Created by Hassan Talat on 8/17/22.
//

import SwiftUI
import AppKit

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

struct ContentView: View {
    private let pasteboard = NSPasteboard.general

    var body: some View {
        VStack {
            List(Command.samples) { command in
                HStack{
                    Text("\(command.cmd)")
                    Spacer()
                    Button {
                        copyToClipboard(command: command.cmd)
                    } label: {
                        Image(systemName:"doc.on.doc.fill")
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func copyToClipboard(command: String) {
        pasteboard.clearContents()
        pasteboard.setString(command, forType: .string)

//        Animate on copy.
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            self.buttonText = "Copy to clipboard"
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

