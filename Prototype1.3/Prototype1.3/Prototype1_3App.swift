//
//  Prototype1_3App.swift
//  Prototype1.3
//
//  Created by 雷定霏 on 14/08/2022.
//

import SwiftUI

@main
struct SampleCoreDataApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              dataController.container.viewContext)
        }
    }
}
