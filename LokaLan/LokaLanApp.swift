//
//  LokaLanApp.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 21/06/23.
//

import SwiftUI

@main
struct LokaLanApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
