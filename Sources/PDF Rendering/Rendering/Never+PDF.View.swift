extension Never: PDF.View {
    public typealias Content = Never

    public var body: Never { Self.unrendered }

    public static func _render(_ view: Self, context: inout PDF.Context) {}
}
