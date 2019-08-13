//
//  Cell2CollectionViewCell.swift
//  ToDoList
//
//  Created by Narongsak Kongpan on 13/8/2562 BE.
//  Copyright © 2562 mrhangz. All rights reserved.
//

import UIKit

class Cell2CollectionViewCell: UICollectionViewCell {
  
  @IBOutlet private var checkButton: UIButton!
  @IBOutlet private var titleLabel: UILabel!
  
  weak var delegate: TodoCollectionViewCellDelegate?
  
  func setupCell(todoItem: TodoItem) {
    self.titleLabel.text = todoItem.todoTitle
    checkButton.isSelected = todoItem.isChecked
  }
  
  @IBAction func checkButtonDidTapped() {
    delegate?.checkButtonDidTapped(cell: self)
  }
}
