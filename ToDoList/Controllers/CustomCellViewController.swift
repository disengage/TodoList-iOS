//
//  CustomCellViewController.swift
//  ToDoList
//
//  Created by Narongsak Kongpan on 13/8/2562 BE.
//  Copyright © 2562 mrhangz. All rights reserved.
//

import UIKit

class CustomCellViewController: UIViewController {
  
  @IBOutlet private var collectionView: UICollectionView!
  @IBOutlet private var textField: UITextField!
  
  var todoItems: [TodoItem] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  @IBAction func addTapped() {
    guard let title = textField.text, !title.isEmpty else {
      return
    }
    let todoItem = TodoItem(todoTitle: title)
    todoItems.append(todoItem)
    collectionView.reloadData()
    collectionView.layoutIfNeeded()
    
    textField.text = nil // Clear textfield
    textField.resignFirstResponder() // Dismiss keyboard
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    
    guard segue.identifier == "showDetailByTapCell",
      let viewController = segue.destination as? DetailViewController,
      let cell = sender as? UICollectionViewCell,
      let index = collectionView.indexPath(for: cell) else {
        return
    }
    let todoItem = todoItems[index.row]
    viewController.todoItem = todoItem
    viewController.backgroundColor = cell.backgroundColor
  }
}

extension CustomCellViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return todoItems.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.row % 2 == 1 {
      if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1CollectionViewCell", for: indexPath) as? Cell1CollectionViewCell {
        let todoItem = todoItems[indexPath.row]
        cell.setupCell(todoItem: todoItem)
        cell.delegate = self
        return cell
      }
    } else {
      if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2CollectionViewCell", for: indexPath) as? Cell2CollectionViewCell {
        let todoItem = todoItems[indexPath.row]
        cell.setupCell(todoItem: todoItem)
        cell.delegate = self
        return cell
      }
    }
    return UICollectionViewCell()
  }
}

extension CustomCellViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    // Default cell height
    var cellHeight: CGFloat = 40
    if indexPath.row % 2 == 0 {
      cellHeight = 60
    } else {
      cellHeight = 100
    }
    return CGSize(width: collectionView.frame.width, height: cellHeight)
  }
}

extension CustomCellViewController: TodoCollectionViewCellDelegate {
  func checkButtonDidTapped(cell: UICollectionViewCell) {
    guard let index = collectionView.indexPath(for: cell) else {
      return
    }
    let todoItem = todoItems[index.row]
    todoItem.isChecked = !todoItem.isChecked
    collectionView.reloadData()
  }
}
