//
//  ContentView.swift
//  NamesList
//
//  Created by Насрулло Исмоилжонов on 12/03/24.
//
import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Data?
    @State private var imagesList = [Data?]()
    
    var body: some View {
        Text("New app")
    }
}

#Preview {
    ContentView()
}
