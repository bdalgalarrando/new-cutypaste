//
//  SwipeBarObject.swift
//  CutyPaste
//
//  Created by Catalina Balmaceda on 24-08-15.
//  Copyright (c) 2015 Catalina Balmaceda. All rights reserved.
//

import UIKit

@objc protocol SideBarDelegate{
    func sideBarDidSelectButtonAtIndex(index:Int)
    optional func sideBarWillClose()
    optional func sideBarWillOpen()
    
}

class SideBar: NSObject, sidebarTableViewControllerDelegate {
    
    let barWidth:CGFloat = 200.0
    let sideBarTableViewTopInset:CGFloat = 20.0
    let sideBarContainerView: UIView = UIView()
    let sideBarTableViewController:SideBarTableViewController = SideBarTableViewController()
    var originView:UIView!
    
    var animator: UIDynamicAnimator!
    var delegate:SideBarDelegate?
    var inSideBarOpen:Bool = false
    var menuItems = ["VITRINA", "BELLEZA", "MODA", "ESTILO DE VIDA", "TENDENCIA", "NOTICIAS"]
    
    override init() {
        super.init()
    }
    
    init (sourceView:UIView){
        super.init()
        
        
        originView = sourceView
        
        sideBarTableViewController.tableData = self.menuItems
        setupSideBar()
        
        //where the animation is
        animator = UIDynamicAnimator(referenceView: originView)
        
        let showGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        showGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Right
        originView.addGestureRecognizer(showGestureRecognizer)
        
        let hideGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        hideGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        originView.addGestureRecognizer(hideGestureRecognizer)
    }
    
    func setupSideBar(){
        sideBarContainerView.frame = CGRectMake(-barWidth - 1, originView.frame.origin.y, barWidth, originView.frame.size.height)
        sideBarContainerView.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        sideBarContainerView.clipsToBounds = false
        
        originView.addSubview(sideBarContainerView)

        sideBarTableViewController.delegate = self
        sideBarTableViewController.tableView.frame = sideBarContainerView.bounds
        sideBarTableViewController.tableView.clipsToBounds = false
        sideBarTableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        sideBarTableViewController.tableView.backgroundColor = UIColor.clearColor()
        sideBarTableViewController.tableView.scrollsToTop = false
        sideBarTableViewController.tableView.contentInset = UIEdgeInsetsMake(sideBarTableViewTopInset, 0, 0, 0)
        
        sideBarTableViewController.tableView.reloadData()
        
        sideBarContainerView.addSubview(sideBarTableViewController.tableView)
        
    }
    
    func handleSwipe(recognizer: UISwipeGestureRecognizer) {
        if recognizer.direction == UISwipeGestureRecognizerDirection.Left {
            showSideBar(false)
            delegate?.sideBarWillClose?()
        }else{
            showSideBar(true)
            delegate?.sideBarWillOpen?()
        }
    }
    
    func showSideBar(shouldOpen:Bool){
        animator.removeAllBehaviors()
        inSideBarOpen = shouldOpen
        
        let gravityX:CGFloat = (shouldOpen) ? 0.5 : -0.5
        let magnitude:CGFloat = (shouldOpen) ? 20 : -20
        let boundaryX:CGFloat = (shouldOpen) ? barWidth : -barWidth - 1
        
        let gravityBehavior:UIGravityBehavior = UIGravityBehavior(items: [sideBarContainerView])
        gravityBehavior.gravityDirection = CGVectorMake(gravityX, 0)
        animator.addBehavior(gravityBehavior)

        
        let collisionBehavior:UICollisionBehavior = UICollisionBehavior(items: [sideBarContainerView])
        collisionBehavior.addBoundaryWithIdentifier("sideBarBoundary", fromPoint: CGPointMake(boundaryX, 20), toPoint: CGPointMake(boundaryX, originView!.frame.size.height))
        
        animator.addBehavior(collisionBehavior)
        
        let pushBehavior: UIPushBehavior = UIPushBehavior(items: [sideBarContainerView], mode: UIPushBehaviorMode.Instantaneous)
        pushBehavior.magnitude = magnitude
        animator.addBehavior(pushBehavior)
        
        let sideBarBehavior:UIDynamicItemBehavior = UIDynamicItemBehavior(items: [sideBarContainerView])
        sideBarBehavior.elasticity = 0.4
        animator.addBehavior(sideBarBehavior)
        
    }
    
    func sidebarDidSelectRow(indexPath: NSIndexPath) {
        delegate?.sideBarDidSelectButtonAtIndex(indexPath.row)
    }
}
