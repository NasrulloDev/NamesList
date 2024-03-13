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
            NavigationStack{
                PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
                List{
                    ForEach(peopleList, id: \.self){ person in
                        NavigationLink{
                            Text(person.name)
                                .font(.headline)
                            Image(uiImage: UIImage(data: person.photo!)!)
                                .resizable()
                                .scaledToFit()
                        }label: {
                            HStack{
                                Image(uiImage: UIImage(data: person.photo!)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                Text(person.name)
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $askName) {
            Form{
                TextField("Name", text: $newPerson.name)
            }
            Button("Close"){
                askName = false
                peopleList.append(newPerson)
                newPerson.name = ""
            }
        }
        .onChange(of: pickerItem) {
            Task{
                askName = true
                selectedImage = try await pickerItem?.loadTransferable(type: Data.self)
                newPerson.photo = selectedImage
            }
        }
        
    }
}

#Preview {
    ContentView()
}
