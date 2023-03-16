import Cloneable from "../utils/Cloneable";
import { SquareValue } from "./Square";

export default
class Player extends Cloneable {
    constructor(
        public userId: string,
        public name: string,
        public value: SquareValue
    ) { super() }
}