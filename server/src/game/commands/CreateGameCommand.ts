import { CreateGameParameters } from "../../api/Mutations";
import AuthorizeUserCommand from "../../auth/commands/AuthorizeUserCommand";
import { Board } from "../entities/Board";
import Player from "../entities/Player";
import { BoardRepository } from "../repositories/BoardRepository";
import Utils from "../utils/Utils";

export default
    class CreateGameCommand {
    constructor(
        private repository: BoardRepository,
        private getUserCommand: AuthorizeUserCommand
    ) { }

    execute(params: CreateGameParameters): Board {
        const user = this.getUserCommand.execute(params.sessionId)

        const player1 = new Player(
            user.id,
            user.nickName,
            params.symbol,
        )

        const board = new Board(
            Utils.generateId(),
            player1,
        )

        this.repository.saveBoard(board)

        return board;
    }
}