//
//  RegisterCellViewController.swift
//  ToDoList
//
//  Created by Narongsak Kongpan on 13/8/2562 BE.
//  Copyright © 2562 mrhangz. All rights reserved.
//

import UIKit

class RegisterCellViewController: UIViewController {
  
  @IBOutlet private var collectionView: UICollectionView!
  @IBOutlet private var textField: UITextField!
  
  var todoItems: [TodoItem] = []
  
  private let cellIdentifier = "CustomTodoCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let bundle = Bundle(for: CustomTodoCollectionViewCell.self)
    let nib = UINib(nibName: "CustomTodoCollectionViewCell", bundle: bundle)
    collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
  }
  
  @IBAction func addTapped() {
    guard let title = textField.text, !title.isEmpty else {
      return
    }
    let todoItem = TodoItem(todoTitle: title)
    todoItems.append(todoItem)
    collectionView.reloadData()
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    if segue.identifier == "showDetail",
      let viewController = segue.destination as? DetailViewController,
      let todoItem = sender as? TodoItem {
      viewController.todoItem = todoItem
    }
  }
}

extension RegisterCellViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return todoItems.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CustomTodoCollectionViewCell {
      let todoItem = todoItems[indexPath.row]
      cell.setupCell(todoItem: todoItem)
      cell.delegate = self
      return cell
    }
    return UICollectionViewCell()
  }
}

extension RegisterCellViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let todoItem = todoItems[indexPath.row]
    self.performSegue(withIdentifier: "showDetail", sender: todoItem)
  }
}

extension RegisterCellViewController: TodoCollectionViewCellDelegate {
  func checkButtonDidTapped(cell: UICollectionViewCell) {
    guard let index = collectionView.indexPath(for: cell) else {
      return
    }
    let todoItem = todoItems[index.row]
    todoItem.isChecked = !todoItem.isChecked
    collectionView.reloadData()
  }
}
