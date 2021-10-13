//
//  BottomMessageContainerViewController.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import CommonsPack

public protocol BottomMessageContainerDelegate: AnyObject {
    func bottomAlertViewContainerDismissed()
}

public class BottomMessageContainerViewController: UIViewController {

    // Properties
    public struct Properties {
        public var customView: UIView
        public var isDismissable: Bool
        public var edgeInsets: UIEdgeInsets
        public var componentsSpacing: CGFloat
        public var bordered: Bool

        public init(
            customView: UIView,
            edgeInsets: UIEdgeInsets = UIEdgeInsets.zero,
            componentsSpacing: CGFloat = 0,
            isDismissable: Bool = true,
            bordered: Bool = true
            ) {
            self.customView = customView
            self.isDismissable = isDismissable
            self.edgeInsets = edgeInsets
            self.componentsSpacing = componentsSpacing
            self.bordered = bordered
        }

        public init() {
            customView = UIView()
            isDismissable = true
            componentsSpacing = 0
            edgeInsets = UIEdgeInsets.zero
            bordered = true
        }
    }

    // MARK: Outlets
    lazy var topButtonBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UITheme.Style.Colors.Extras.shadowLevel3
        view.alpha = 0
        return view
    }()

    lazy var viewContentsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    lazy var stackViewContents: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        return stackView
    }()

    var layoutConstraintTopContainer: NSLayoutConstraint = .init()

    // MARK: - Attr
    public weak var delegate: BottomMessageContainerDelegate?
    private var properties: Properties = .init()

    // MARK: - View

    override private init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    public convenience init(_ properties: Properties) {
        self.init()
        self.properties = properties
        setup()
    }

    func setup() {
        definesPresentationContext = true
        providesPresentationContextTransitionStyle = true
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve

        setupUIComponents()
        setupConstraints()
        setupUIProperties()
    }

    func setupUIComponents() {
        view.backgroundColor = .clear

        let viewContents = properties.customView
        viewContents.backgroundColor = .white
        viewContents.alpha = 0

        stackViewContents.spacing = properties.componentsSpacing
    }

    func setupConstraints() {
        view.addSubview(topButtonBackground)
        view.addSubview(viewContentsContainer)

        topButtonBackground.translatesAutoresizingMaskIntoConstraints = false
        topButtonBackground.topAnchor.constraint(
            equalTo: view.topAnchor, constant: 0
            ).isActive = true
        topButtonBackground.bottomAnchor.constraint(
            equalTo: view.bottomAnchor, constant: 0
            ).isActive = true
        topButtonBackground.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: 0
            ).isActive = true
        topButtonBackground.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: 0
            ).isActive = true

        viewContentsContainer.translatesAutoresizingMaskIntoConstraints = false
        viewContentsContainer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: 0
            ).isActive = true
        viewContentsContainer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: 0
            ).isActive = true
        layoutConstraintTopContainer = viewContentsContainer.topAnchor.constraint(
            equalTo: view.bottomAnchor, constant: 0
            )
        layoutConstraintTopContainer.isActive = true

        viewContentsContainer.addSubview(stackViewContents)
        stackViewContents.translatesAutoresizingMaskIntoConstraints = false
        stackViewContents.leadingAnchor.constraint(
            equalTo: viewContentsContainer.leadingAnchor,
            constant: 0
            ).isActive = true
        stackViewContents.trailingAnchor.constraint(
            equalTo: viewContentsContainer.trailingAnchor,
            constant: 0
            ).isActive = true
        stackViewContents.bottomAnchor.constraint(
            equalTo: viewContentsContainer.bottomAnchor,
            constant: 0
            ).isActive = true
        stackViewContents.topAnchor.constraint(
            equalTo: viewContentsContainer.topAnchor,
            constant: 0
            ).isActive = true

        stackViewContents.layoutMargins = properties.edgeInsets

        let viewContents = properties.customView
        stackViewContents.addArrangedSubview(viewContents)
    }

    func setupUIProperties() {
        layoutConstraintTopContainer.constant = 0

        if properties.isDismissable {
            setupGestures()
        }
    }
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateAppearance()
    }

    func setupGestures() {
        topButtonBackground.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(topViewTapped)
            )
        )
    }

    func animateAppearance() {
        if properties.bordered {
            viewContentsContainer.roundCorners(corners: [.topLeft, .topRight], radius: 6.0)
        }
        layoutConstraintTopContainer.constant = -viewContentsContainer.bounds.height
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.topButtonBackground.alpha = 1
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                self.animateContentsAppearance()
            }
        )
    }

    func animateContentsAppearance() {
        let viewContents = properties.customView
        UIView.animate(withDuration: 0.15) {
            viewContents.alpha = 1
        }
    }

    func animateDisappearance() {
        layoutConstraintTopContainer.constant = 0
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.topButtonBackground.alpha = 0
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                self.dismiss()
            }
        )
    }

    @objc
    func topViewTapped() {
        animateDisappearance()
        delegate?.bottomAlertViewContainerDismissed()
    }

    @IBAction private func buttonPressed() {
        animateDisappearance()
    }

    // MARK: - Public

    public func addViewInContainer(_ view: UIView, index: Int) {
        stackViewContents.insertArrangedSubview(view, at: index)
    }

    public func dimissAnimated() {
        animateDisappearance()
    }

    public func dismiss() {
        guard let root = UIApplication.shared.windows.last?.rootViewController else {
            return
        }
        root.dismiss(animated: false)
    }

    public func display() {
        guard let root = UIApplication.shared.windows.last?.rootViewController else {
            return
        }
        root.present(self, animated: false)
    }
}
