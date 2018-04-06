//
//  UIViewControllerExtensions.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit

extension UIViewController: View {
	
	func show(error: Error?) {
		let title = NSLocalizedString("Error", comment: "")
		let alert = UIAlertController(title: title, message: error?.localizedDescription, preferredStyle: .alert)
		let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel) { (action) in
			//
		}
		alert.addAction(action)
		
		self.present(alert, animated: true) {
			//
		}
	}
}
