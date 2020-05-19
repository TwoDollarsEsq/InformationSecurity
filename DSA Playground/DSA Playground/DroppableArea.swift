//
//  DroppableArea.swift
//  DSA Playground
//
//  Created by Artyom Rudakov on 19.05.2020.
//  Copyright © 2020 Artyom Rudakov. All rights reserved.
//

import SwiftUI

struct DroppableAreaFor<Type: Decodable>: View {
    let modifier: String
    @Binding var droppedValue: Type?
    @State private var shouldHighlightText = false
    private var label: String {
        didDrop ? modifier + "✅" : "Положите \(modifier) Сюда"
    }
    private var didDrop: Bool {
        droppedValue != nil
    }
    
    var body: some View {
        Text(label)
            .font(.headline)
            .padding()
            .background(shouldHighlightText || didDrop ? Color.green : .yellow)
            .cornerRadius(16)
            .onDrop(
                of: [Self.type],
                isTargeted: $shouldHighlightText,
                perform: process
            )
    }
    
    func process(_ providers: [NSItemProvider]) -> Bool {
        for provider in providers where provider.hasItemConformingToTypeIdentifier(Self.type) {
            provider.loadItem(
                forTypeIdentifier: Self.type,
                options: nil
            ) { data, error in
                let url = data as! URL
                do {
                    let value = try Data(contentsOf: url)
                    let decoded = try JSONDecoder().decode(Type.self, from: value)
                    self.droppedValue = decoded
                } catch {
                    self.droppedValue = nil
                }
            }
        }
            
        return didDrop
    }
    
    static var type: String { kUTTypeJSON as String }
}

struct DroppableArea_Previews: PreviewProvider {
    static var previews: some View {
        DroppableAreaFor<Int>(modifier: "Number", droppedValue: .constant(nil))
    }
}
