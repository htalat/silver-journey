//
//  ContentView.swift
//  SilverJourney
//
//  Created by Hassan Talat on 8/17/22.
//

import SwiftUI
import AppKit

struct ContentView: View {

    @StateObject private var modelData = SimpleParser(filename: fullpath)
    private let pasteboard = NSPasteboard.general
    @State var username: String = ""
    @State private var isSelected: Bool = false

    var body: some View {
        VStack {
            HStack {
                Text(filename)
                .onTapGesture {
                    let file = URL(fileURLWithPath: fullpath)

                    // canonical path i.e. /User/path instead of file://User/path.
                    if let cp = (try? file.resourceValues(forKeys: [.canonicalPathKey]))?.canonicalPath {
                        NSWorkspace.shared.selectFile(cp, inFileViewerRootedAtPath: "/Users/")
                    }
                }

                Button {
                    modelData.reload()
                } label: {
                    Image(systemName:"square.and.arrow.down")
                }

                Button {
                    NSApp.terminate(self)
                } label: {
                    Text("Quit")
                }
            }

            if(modelData.commands.isEmpty){
                Text("file is empty. Go add some stuff")
            }else{
                List(modelData.commands) { command in
                    HStack{
                        Text("\(command.cmd)")
                        Spacer()
                        Button {
                            copyToClipboard(command: command.cmd)
                        } label: {
                            Image(systemName:"doc.on.doc.fill")
                        }
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 3)
                    )
                }
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func copyToClipboard(command: String) {
        pasteboard.clearContents()
        pasteboard.setString(command, forType: .string)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

