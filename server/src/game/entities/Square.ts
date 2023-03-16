import Cloneable from "../utils/Cloneable"

export type SquareValue = "X" | "O"

class Square extends Cloneable {
    constructor(
        public value: SquareValue | null
    ) { super() }

    static blank(): Square {
        return new Square(null)
    }
}

export default Square