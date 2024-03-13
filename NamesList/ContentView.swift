//
//  ContentView.swift
//  NamesList
//
//  Created by Насрулло Исмоилжонов on 12/03/24.
//
import PhotosUI
import SwiftUI

struct Person: Hashable {
    var name: String = ""
    var photo: Data?
    
}

struct ContentView: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Data?
    @State private var peopleList = [Person]()
    @State private var askName = false
    @State private var newPerson = Person()
    
    var body: some View {
        VStack {
            PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
            List{
                ForEach(peopleList, id: \.self){ person in
                    Image(uiImage: UIImage(data: person.photo!)!)
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .onChange(of: pickerItem) {
            Task{
                selectedImage = try await pickerItem?.loadTransferable(type: Data.self)
                newPerson.photo = selectedImage
                peopleList.append(newPerson)
                askName = true
                
            }
        }
        
    }
}

#Preview {
    ContentView()
}
