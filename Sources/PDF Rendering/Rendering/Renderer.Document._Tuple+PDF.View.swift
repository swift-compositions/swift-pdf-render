public import PDF_Standard
public import Renderer

extension Renderer.Document._Tuple: PDF.View where repeat each Content: PDF.View {
    public typealias Content = Never

    public var body: Never { fatalError("_Tuple uses direct rendering") }

    public static func _render(_ view: Self, context: inout PDF.Context) {

        if context.spacing.isHorizontal {
            _renderHorizontal(view, context: &context)
        } else {
            _renderVertical(view, context: &context)
        }
    }

    private static func _renderVertical(_ view: Self, context: inout PDF.Context) {
        func render<T: PDF.View>(_ element: T) {

            if let spacing = context.spacing.vertical,
                let lastY = context.lastY,
                context.layout.box.lly > lastY
            {

                context.advance(spacing)
            }

            let yBefore = context.layout.box.lly

            T._render(element, context: &context)

            if context.layout.box.lly > yBefore {
                context.lastY = yBefore
            }
        }
        repeat render(each view.content)
    }

    private static func _renderHorizontal(_ view: Self, context: inout PDF.Context) {
        var rowStartY = context.beginRow { context in
            _renderHorizontal(view, context: &context)
        }

        func render<T: PDF.View>(_ element: T) {
            context.renderRowCell(startY: &rowStartY) { context in
                T._render(element, context: &context)
            }
        }
        repeat render(each view.content)
    }
}
