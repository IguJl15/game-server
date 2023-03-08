import { SquareValue } from "./Square";

export default 
class Player {
    constructor(
        public id: String,
        public name: String,
        public value: SquareValue
    ) {}
}