//
//  ContentView.swift
//  SwiftUiCoreData
//
//  Created by RMP on 28/09/1445 AH.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var name: String = ""
    @State private var quantity: String = ""
    
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(entity: Product.entity(), sortDescriptors: [.init(key: "quantity", ascending: true)])
    
    private var products: FetchedResults<Product>
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                TextField("Name", text: $name).textFieldStyle(.roundedBorder)
                TextField("Quantity", text: $quantity).textFieldStyle(.roundedBorder)
                
                HStack {
                    
                    Spacer()
                    
                    Button("Add") {
                        addProduct()
                    }
                    
                    Spacer()
                    Button("clear") {
                        
                        name = ""
                        quantity = ""
                        
                    }
                    Spacer()
                }.padding().frame(maxWidth: .infinity)
                
                List {
                    
                    ForEach(products) { product in
                        
                        HStack {
                            
                            Text(product.name ?? "No Names")
                            Spacer()
                            Text(product.quantity ?? "No Quantities")
                            
                        }
                        
                    }.onDelete(perform: deleteProduct)
                    
                }.navigationTitle("CoreData")
                
            }.padding()
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



extension ContentView {
    
    
    
    // Method to add info into coredata store and save it
    func addProduct() {
        
        withAnimation {
            
            let product = Product(context: viewContext)
            
            product.name = name
            product.quantity = quantity
            
            
            saveContext()
            
        }
        
    }
    
    
    func deleteProduct(offsets: IndexSet) {
        
        withAnimation {
            
            
            // return the item you need to delete or clikced on it
            let deletedItem = offsets.map { index in
                
                return products[index]
                
            }
            
            
            print("the item you need to delete: \(deletedItem.first!)")
            
            // delete one item at the current time
//            viewContext.delete(deletedItem.first!)
//
//            for h in deletedItem {
//
//                viewContext.delete(h)
//
//            }
            
            offsets.map { products[$0] }.forEach(viewContext.delete)
            
            saveContext()
            
        }
        
    }
    
    
    
    func saveContext() {
        
        do {
            
            try viewContext.save()
            
        } catch let coreDataSavedError {
            
            fatalError(coreDataSavedError.localizedDescription)
            
        }
        
    }
    
}
