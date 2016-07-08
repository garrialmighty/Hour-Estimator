//
//  AddTaskViewController.swift
//  Hours Estimator
//
//  Created by Garri Adrian Nablo on 7/8/16.
//  Copyright © 2016 Knack Studios. All rights reserved.
//

import UIKit

private final class AddTaskPresentationController: UIPresentationController {
    let dimmingView = UIView()
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        self.dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddTaskPresentationController.didTapDimmingView))
        self.dimmingView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func presentationTransitionWillBegin() {
        if let containerView = self.containerView {
            self.dimmingView.frame = containerView.bounds
            self.dimmingView.alpha = 0.0
            containerView.insertSubview(self.dimmingView, atIndex: 0)
            
            presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ context in
                self.dimmingView.alpha = 1.0
                }, completion: nil)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ context in
            self.dimmingView.alpha = 0.0
            }, completion: {
                context in
                self.dimmingView.removeFromSuperview()
        })
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        guard let containerView = self.containerView else { return .zero }
        
        let moduleHeight = ceil(UIScreen.mainScreen().bounds.height * 0.65)
        let yOrigin = containerView.bounds.height - moduleHeight
        
        return CGRect(x: 0.0, y: yOrigin, width: containerView.bounds.width, height: moduleHeight)
    }
    
    @objc private func didTapDimmingView() {
        self.presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}

protocol AddTaskViewControllerDelegate: class {
    func addTaskViewController(viewController: AddTaskViewController, didAddTask task: Task)
}

final class AddTaskViewController: UIViewController {

    private let taskTextField = UITextField()
    private let addButton = UIBarButtonItem(title: "Add", style: .Plain, target: nil, action: #selector(AddTaskViewController.didTapAdd))
    private let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: nil, action: #selector(AddTaskViewController.didTapAdd))
    
    weak var delegate: AddTaskViewControllerDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.transitioningDelegate = self
        self.modalPresentationStyle = .Custom
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Add Task"
        self.view.backgroundColor = .whiteColor()
        
        self.addButton.target = self
        self.navigationItem.rightBarButtonItem = self.addButton
        
        taskTextField.delegate = self
        taskTextField.borderStyle = .RoundedRect
        taskTextField.placeholder = "Enter Task Name"
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(taskTextField)
        NSLayoutConstraint.activateConstraints([
            taskTextField.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor, constant: 10.0),
            taskTextField.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor, constant: -10.0),
            taskTextField.topAnchor.constraintEqualToAnchor(self.topLayoutGuide.bottomAnchor, constant: 20.0)
            ])
        
        // create keyboard toolbar
        let toolbar = UIToolbar()
        toolbar.translucent = true
        toolbar.sizeToFit()
        
        // add bar button items
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
        doneButton.target = self
        doneButton.enabled = false
        toolbar.items = [flexibleSpace, doneButton]
        
        // set toolbar as input accessory view
        taskTextField.inputAccessoryView = toolbar
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        taskTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        taskTextField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func didTapAdd() {
        if let taskName = taskTextField.text {
            let task = Task()
            task.name = taskName
            RealmUtility.sharedUtility.save(task)
            
            self.delegate?.addTaskViewController(self, didAddTask: task)
        }
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
extension AddTaskViewController: UIViewControllerTransitioningDelegate {
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return AddTaskPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    */
}

extension AddTaskViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if var textFieldText = textField.text {
            textFieldText.appendContentsOf(string)
            doneButton.enabled = textFieldText.characters.count > 0
        }
        
        return string != "\n"
    }
}
