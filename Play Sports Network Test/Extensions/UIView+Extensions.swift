//
//  UIView+Extensions.swift
//  Play Sports Network Test
//
//  Created by Flávio Silvério on 11/02/2019.
//  Copyright © 2019 Flávio Silvério. All rights reserved.
//

import UIKit

protocol NoDataViewDelegate {
    func retry()
}

extension UIView {

    func showLoader(){
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .gray

        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.addSubview(indicator)

        indicator.center = view.center
        indicator.startAnimating()

        view.tag = -999

        self.addSubview(view)
    }

    func hideLoader(){
        self.viewWithTag(-999)?.removeFromSuperview()
    }

    func showNoDataView(delegate: NoDataViewDelegate){

    }
}
