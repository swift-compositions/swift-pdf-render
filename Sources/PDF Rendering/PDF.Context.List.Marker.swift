public import Byte
public import Geometry
public import PDF_Standard

extension PDF.Context.List {

    public enum Marker: Sendable {

        case text(bytes: [Byte], font: PDF.Font)

        case strokedCircle(
            PDF.UserSpace.Circle,
            strokeWidth: PDF.UserSpace.Width
        )

        case filledCircle(PDF.UserSpace.Circle)

        case filledSquare(PDF.UserSpace.Rectangle)
    }
}
