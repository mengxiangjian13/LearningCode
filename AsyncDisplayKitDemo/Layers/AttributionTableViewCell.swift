//
//  AttributionTableViewCell.swift
//  Layers
//
//  Created by René Cacheaux on 10/9/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

class AttributionTableViewCell: UITableViewCell, UITextViewDelegate {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var articleAttributionTextView: UITextView!
  @IBOutlet weak var articleLicenseTextView: UITextView!
  @IBOutlet weak var imageAttributionTextView: UITextView!
  @IBOutlet weak var imageLicenseTextView: UITextView!
  
  func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
    return true
  }
}
