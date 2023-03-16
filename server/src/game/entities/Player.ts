import Cloneable from "../utils/Cloneable";
import { SquareValue } from "./Square";

export default
class Player extends Cloneable {
    constructor(
        public id: string | null,
        public name: string,
        public value: SquareValue
    ) { super() }
}