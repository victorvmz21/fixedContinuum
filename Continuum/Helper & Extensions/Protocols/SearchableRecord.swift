//
//  SearchableRecord.swift
//  Continuum
//
//  Created by Victor Monteiro on 7/1/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import Foundation

protocol SearchableRecord {
    func matches(searchTerm: String) -> Bool
}
