//
//  SwiftUiCoreDataApp.swift
//  SwiftUiCoreData
//
//  Created by RMP on 28/09/1445 AH.
//

import SwiftUI

@main
struct SwiftUiCoreDataApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
