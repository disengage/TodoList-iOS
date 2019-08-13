//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Narongsak Kongpan on 13/8/2562 BE.
//  Copyright © 2562 mrhangz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  // @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet private weak var titleLabel: UILabel!
  
  var todoItem: TodoItem?
  var backgroundColor: UIColor?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    setupView()
    setupBackground()
  }
  
  private func setupView() {
    guard let todoItem = todoItem else { return }
    titleLabel.text = todoItem.todoTitle
  }
  
  private func setupBackground() {
    guard let customColor = backgroundColor else { return }
    self.view.backgroundColor = customColor
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
