//
//  Favorites.swift
//  MusicPlayerII - with persistence
//
//  Created by mlee73 on 5/10/18.
//  Copyright © 2018 mlee. All rights reserved.
//

import Foundation

//store favorite tracks
var favTracks:[Track] = []


func save() {
    var encodedFavs: Data?
    //encode array
    let propertyListEncoder = PropertyListEncoder()
    encodedFavs = try? propertyListEncoder.encode(favTracks)
    if let encodedFavs = encodedFavs{
        print("We have encoded favs. it is \(encodedFavs.count) bytes")
    }
    
    //open file handle to write to
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let archiveURL = documentsDirectory[0].appendingPathComponent("favsData").appendingPathExtension("plist")
    
    do{
        try encodedFavs?.write(to: archiveURL, options: .noFileProtection)
    }catch{
        print("error writing favs file")
    }
}

func reload() {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let archiveURL = documentsDirectory[0].appendingPathComponent("favsData").appendingPathExtension("plist")
    
    let propertyListDecoder = PropertyListDecoder()
    if let retrievedData = try? Data(contentsOf: archiveURL),
        let decodedFavs = try? propertyListDecoder.decode([Track].self, from: retrievedData){
            print("we decoded favs")
            favTracks = decodedFavs
    }


    
}
