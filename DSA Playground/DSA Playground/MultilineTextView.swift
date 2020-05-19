//
//  MultilineTextView.swift
//  DSA Playground
//
//  Created by Artyom Rudakov on 19.05.2020.
//  Copyright © 2020 Artyom Rudakov. All rights reserved.
//

import SwiftUI

struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.delegate = context.coordinator
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.font = .preferredFont(forTextStyle: .body)
        view.adjustsFontForContentSizeCategory = true
        view.backgroundColor = .clear
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        .init(text: $text)
    }
    
    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        
        init(text: Binding<String>) {
            self.text = text
        }
        
        func textViewDidChange(_ uiView: UITextView) {
            text.wrappedValue = uiView.text
        }
    }
}

struct MultilineTextView_Previews: PreviewProvider {
    static var previews: some View {
        MultilineTextView(text: .constant("Hello, TextView!"))
    }
}
