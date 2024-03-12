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
        VStack {
            PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
            ForEach(imagesList, id: \.self){ photo in
                Image(uiImage: UIImage(data: photo!)!)
                    .resizable()
                    .scaledToFit()
            }
        }
        .onChange(of: pickerItem) {
            Task{
                selectedImage = try await pickerItem?.loadTransferable(type: Data.self)
                imagesList.append(selectedImage)
            }
        }
    }
}

#Preview {
    ContentView()
}
