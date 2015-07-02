//
//  EditUserViewController.swift
//  UserTokens
//
//  Created by John Regner on 7/1/15.
//  Copyright © 2015 HumanAPI-JohnRegner. All rights reserved.
//

import UIKit

class EditUserViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!

    var user: TokensUser! { //initialize this before presenting this VC
        willSet {
            userNameLabel?.text = newValue.userName
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = user?.userName
    }

    @IBAction func done(sender: UIBarButtonItem) {
        if let pres = presentingViewController as? DetailViewController {
            pres.detailItem = user
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
