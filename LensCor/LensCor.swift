//
//  LensCor.swift
//  LensCor
//
//  Created by Akash Saxena on 12/06/24.
//

import SwiftUI

@main
struct LensCor: App {
    @StateObject private var manager: DataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
        }
    }
}
