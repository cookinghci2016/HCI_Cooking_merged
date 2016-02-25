//
//  ViewTest.swift
//  HCI_recipe
//
//  Created by allen woo on 2/20/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//

import UIKit

class Viewtest: UIViewController {

    @IBOutlet weak var BacktoFirst: UIButton!
    override func performSegueWithIdentifier(identifier: String, sender: AnyObject!) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
