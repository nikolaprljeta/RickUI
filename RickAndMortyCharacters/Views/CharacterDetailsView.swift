//
//  CharacterDetailsView.swift
//  RickAndMortyCharacters
//
//  Created by Nikola Prljeta on 14.11.22..
//

import SwiftUI

struct CharacterDetailsView: View {
    
    @StateObject var charactersViewModel: CharactersViewModel
    var result: Result
    
    var body: some View {
        Form {
            HStack(alignment: .top) {
                ImageView(result: result)
                    .frame(width: 150, height: 150)
                VStack(spacing: 20) {
                    HStack {
                        Text("Name")
                        Spacer()
                        Button(action: {
                            charactersViewModel.toggleFav(result: result)
                        }, label: {
                            Image(systemName: charactersViewModel.contains(result) ? "star.fill" : "star")
                                .foregroundColor(.green)
                        })
                    }
                    HStack {
                        Text(result.name)
                            .font(.title)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
            }
            DetailsView(result: result)
        }
    }
}

struct ImageView: View {
    var result: Result
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: result.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(maxWidth: 150, maxHeight: 150)
                         .cornerRadius(5)
                case .failure:
                    Image(systemName: "questionmark.diamond.fill")
                        .imageScale(.large)
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

struct DetailsView: View {
    
    var result: Result
    
    var body: some View {
        HStack(alignment: .top, spacing: 25) {
            
            VStack(alignment: .leading, spacing: 0) {
                
                let labels = ["Status", "Species", "Type", "Gender", "Origin", "Location"]
                
                ForEach(labels, id: \.self) { labelItem in
                    Text(labelItem)
                        .font(.headline.weight(.light))
                        .foregroundColor(.gray)
                        .frame(height: 50)
                }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                
                let values = [result.status, result.species, result.type, result.gender, result.origin.name, result.location.name]
                
                ForEach(values, id: \.self) { valueItem in
                    Text(valueItem)
                        .font(.headline.weight(.bold))
                        .frame(height: 50)
                }
            }
        }
    }
}

let sampleRick = Result(id: 1,
                        name: "Rick Sanchez",
                        status: "Single",
                        species: "More Human Than Human",
                        type: "AnyObject",
                        gender: "12",
                        origin: sampleCrib,
                        location: sampleCrib,
                        image: "www.failedtoload.not",
                        episode: ["All"],
                        url: "404",
                        created: "Perfect",
                        isFaved: true)

let sampleCrib = Location(name: "Crib 401", url: "401")

struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsView(charactersViewModel: CharactersViewModel(), result: sampleRick)
    }
}
