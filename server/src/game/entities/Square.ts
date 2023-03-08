export type SquareValue = "X" | "O"

class Square {
    constructor(
        public value: SquareValue | null
    ) {}
    
    static blank(): Square {
        return new Square(null)
    }
    
}

export default Square