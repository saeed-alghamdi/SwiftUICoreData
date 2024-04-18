//
//  Persistence.swift
//  SwiftUiCoreData
//
//  Created by RMP on 28/09/1445 AH.
//

import Foundation
import CoreData



class PersistenceController {
    
    // sengelton
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        
        // with Entity name
        container = NSPersistentContainer(name: "Products")
        
        container.loadPersistentStores { loadDescription, loadError in
            
            print("the description of loading: \(loadDescription.type)")
            
            if let error = loadError {
                
                fatalError(error.localizedDescription)
                
            }
            
        }
        
    }
    
}
