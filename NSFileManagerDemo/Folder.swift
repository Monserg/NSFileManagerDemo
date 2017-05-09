//
//  Folder.swift
//  NSFileManagerDemo
//
//  Created by msm72 on 09.05.17.
//  Copyright © 2017 Omniesoft. All rights reserved.
//

import Foundation

struct Folder {
    // MARK: - Properties
    let url: URL
    let name: String
    var isSelected: Bool = false
    
    
    // MARK: - Class Initialization
    init(withURL url: URL) {
        self.url = url
        self.name = self.url.lastPathComponent
    }
    
    init?(fromSearchPathDirectory searchPathDirectory: FileManager.SearchPathDirectory) {
        let urls = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask)

        if urls.count > 0 {
            self.url = urls.first!
            self.name = self.url.lastPathComponent
        } else {
            return nil
        }
    }
    
    
    // MARK: - Custom Functions
}
