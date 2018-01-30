//
//  DialogControllerBase.swift
//  Reactant
//
//  Created by Filip Dolnik on 08.11.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

open class DialogControllerBase<STATE, ROOT: View>: ControllerBase<STATE, ROOT> where ROOT: Component {

    public var dialogView: DialogView
    
    private let rootViewContainer = ControllerRootViewContainer()
    
    open override var configuration: Configuration {
        didSet {
            dialogView.configuration = configuration
            configuration.get(valueFor: Properties.Style.dialogControllerRoot)(rootViewContainer)
        }
    }

    public override init(title: String = "", root: ROOT = ROOT()) {
        dialogView = DialogView(content: root)
        
        super.init(title: title, root: root)

        #if os(iOS)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
        #endif
    }
    
    open override func loadView() {
        view = rootViewContainer
        
        view.addSubview(dialogView)
    }

    #if os(iOS)
    open override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        let dismissalListener = presentingViewController as? DialogDismissalListener
        dismissalListener?.dialogWillDismiss()
        super.dismiss(animated: flag) {
            dismissalListener?.dialogDidDismiss()
            completion?()
        }
    }
    #elseif os(macOS)
    open override func dismissViewController(_ viewController: NSViewController) {
        let dismissalListener = presenting as? DialogDismissalListener
        dismissalListener?.dialogWillDismiss()
        super.dismiss(viewController)
        dismissalListener?.dialogDidDismiss()
    }

    #endif
    
    open override func updateRootViewConstraints() {
        dialogView.snp.updateConstraints { make in
            make.edges.equalTo(view)
        }
    }
}
