//
//  String+File.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/15/20.
//

import Foundation

extension String {
    var fileName: String {
       URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }

    var fileExtension: String{
       URL(fileURLWithPath: self).pathExtension
    }
}
