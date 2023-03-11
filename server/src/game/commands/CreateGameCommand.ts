import { CreateGameParameters } from "../../api/Mutations";
import { Board } from "../entities/Board";
import Player from "../entities/Player";
import { BoardRepository } from "../repositories/BoardRepository";
import Utils from "../utils/Utils";
import GetGameStateCommand from "./GetGameStateCommand";

export default
class CreateGameCommand {
    constructor(
        private repository: BoardRepository,
        private getBoardCommand: GetGameStateCommand
    ) {}
    
    execute(params: CreateGameParameters): Board {
        const player1 = new Player(
            Utils.generateId(),
            params.playerName!,
            params.symbol,
        )

        const board = new Board(
                Utils.generateId(),
                player1,
        )

        return this.repository.saveBoard(board)
    }
}