//
//  Comment.swift
//  Continuum
//
//  Created by Victor Monteiro on 6/30/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import Foundation
import CloudKit

struct CommentConstants {
  static let recordType = "Comment"
  static let textKey = "text"
  static let timestampKey = "timestamp"
  static let postReferenceKey = "post"
}

class Comment {
  let text: String
  let timestamp: Date
  weak var post: Post?
  let recordID: CKRecord.ID
  
  var postReference: CKRecord.Reference? {
    guard let post = post else { return nil }
    return CKRecord.Reference(recordID: post.recordID, action: .deleteSelf)
  }
  
  init(text: String, post: Post, timestamp: Date = Date(), recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
    self.text = text
    self.post = post
    self.timestamp = timestamp
    self.recordID = recordID
  }
  
  convenience init?(ckRecord: CKRecord, post: Post){
    guard let text = ckRecord[CommentConstants.textKey] as? String,
      let timestamp = ckRecord[CommentConstants.timestampKey] as? Date else { return nil }
    self.init(text: text, post: post, timestamp: timestamp, recordID: ckRecord.recordID)
  }
}

extension Comment: SearchableRecord {
  func matches(searchTerm: String) -> Bool {
    return text.contains(searchTerm)
  }
}

extension CKRecord {
    
    convenience init(comment: Comment) {
        
        self.init(recordType: CommentConstants.recordType, recordID: comment.recordID)
        
        self.setValuesForKeys([
            CommentConstants.textKey : comment.text,
            CommentConstants.timestampKey : comment.timestamp
        ])
        
        if let reference = comment.postReference {
            self.setValue(reference, forKey: CommentConstants.postReferenceKey)
        }
    }
}
