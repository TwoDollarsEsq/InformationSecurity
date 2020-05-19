//
//  ContentView.swift
//  DSA Playground
//
//  Created by Artyom Rudakov on 19.05.2020.
//  Copyright © 2020 Artyom Rudakov. All rights reserved.
//

import SwiftUI
import Combine
import DSA

struct ContentView: View {
    enum ContentState: String, Hashable, CaseIterable {
        case signing = "Подпись", verifying = "Проверка"
    }
    
    @State private var parameters: DSA.Parameters?
    @State private var keys: DSA.Keys?
    @State private var message: String = "Сообщение"
    @State private var state: ContentState = .signing
    @State private var customSignature: DSA.Signature?
    private var signature: DSA.Signature? {
        guard let key = keys?.private, let parameters = parameters else { return nil }
        return DSA.sign(message, with: key, using: parameters)
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                configurationArea
                Spacer()
                stateSwitcher
            }
                
            MultilineTextView(text: $message)
                .padding()
                .background(textColor)
                .cornerRadius(16)
                .onDrag { NSItemProvider(object: self.message as NSItemProviderWriting)}
            
            if state == .signing {
                signature
                .map { _ in Button("Забрать подпись") {
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    let data = try! encoder.encode(self.signature!)
                    let url = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!.appendingPathComponent("\(self.message)-Signature.json")
                    try! data.write(to: url)
                    }
                }
                .padding()
                .font(.headline)
                .foregroundColor(.primary)
                .background(Color.orange)
                .cornerRadius(16)
            }
        }
        .padding()
    }
    
    var textColor: Color {
        guard state == .verifying else { return .secondary}
        guard
            let signature = customSignature,
            let key = keys?.public,
            let parameters = parameters
        else { return .red }
        
        return DSA.verify(message, using: parameters, publicKey: key, signature: signature)
            ? .green
            : .red
    }
    
    var configurationArea: some View {
        VStack(alignment: .leading, spacing: 8) {
            DroppableAreaFor<DSA.Parameters>(
                modifier: "Общие Параметры",
                droppedValue: $parameters
            )
            
            DroppableAreaFor<DSA.Keys>(
                modifier: "Ключи",
                droppedValue: $keys
            )
        }
    }
    
    var stateSwitcher: some View {
        VStack {
            Text("Режим работы")
            Picker("Режим работы", selection: $state) {
                ForEach(ContentState.allCases, id: \.self) { value in
                    Text(value.rawValue)
                        .tag(value)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            if state == .verifying {
                DroppableAreaFor<DSA.Signature>(
                    modifier: "Подпись",
                    droppedValue: $customSignature
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
