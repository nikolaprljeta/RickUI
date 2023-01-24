//
//  CharactersView.swift
//  RickAndMortyCharacters
//
//  Created by Nikola Prljeta on 14.11.22..
//

import SwiftUI

struct CharactersView: View {
    
    @StateObject private var charactersViewModel = CharactersViewModel()
    
    var body: some View {
        
        NavigationView {
            List(charactersViewModel.filteredResults.indices, id: \.self) { resultIndex in
                let result = charactersViewModel.filteredResults[resultIndex]
                CellView(result: result, charactersViewModel: charactersViewModel)
            }
            .navigationTitle(Text("Characters"))
            .searchable(text: $charactersViewModel.searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Characters")
            .refreshable {
                charactersViewModel.clearResponse()
                charactersViewModel.fetchCharacters()
            }
            .safeAreaInset(edge: .bottom, alignment: .trailing, content: {
                Button("★", action: charactersViewModel.sortFavs)
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(width: 55, height: 25)
                    .padding(.vertical)
                    .background( .indigo.opacity(0.9))
                    .cornerRadius(50)
                    .padding(.trailing)
            })//end of list
        }
        .onAppear {
            charactersViewModel.fetchCharacters()
        }
    }
}

struct CellView: View {
    var result: Result
    var charactersViewModel: CharactersViewModel
    
    var body: some View {
        NavigationLink(destination: CharacterDetailsView(charactersViewModel: charactersViewModel, result: result), label: {
            HStack {
                ThumbnailView(result: result)
                    .frame(width: 65, height: 65)
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(result.name)
                            .font(.title2)
                        Image(systemName: charactersViewModel.contains(result) ? "star.fill" : "star")
                            .foregroundColor(.green)
                            .onTapGesture {
                                charactersViewModel.toggleFav(result: result)
                            }
                    }
                    Text(result.status)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        })
    }
}

struct ThumbnailView: View {
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
                         .frame(maxWidth: 65, maxHeight: 65)
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

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
