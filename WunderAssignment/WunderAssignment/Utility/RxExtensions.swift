//
//  RxExtensions.swift
//  WunderAssignment
//
//  Created by AmritPandey on 13/12/19.
//  Copyright © 2019 Wunder. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import KRProgressHUD


extension Reactive where Base: UIViewController {
    
    /// For showing loading view to restrict user interaction
    public var isAnimate: Binder<Bool> {
        return Binder(self.base) { (_, isShow) in
            if isShow {
                KRProgressHUD.show()
            }
            else {
                KRProgressHUD.dismiss()
            }
        }
    }
}
