import { JoinGame } from "../../api/Mutations";
import AuthorizeUserCommand from "../../auth/commands/AuthorizeUserCommand";
import { BoardNotFoundError, FullBoardError } from "../Errors";
import { Board } from "../entities/Board";
import Player from "../entities/Player";
import { BoardRepository } from "../repositories/BoardRepository";
import Notifier from "../utils/Notifier";

export default
    class JoinGameCommand {
    constructor(
        private repository: BoardRepository,
        private getUserCommand: AuthorizeUserCommand,
        private playerNotifier: Notifier,
    ) { }

    execute(params: JoinGame): Board {
        const user = this.getUserCommand.execute(params.sessionId)

        let board = this.repository.getBoard(params.boardId)

        if (board == null) throw new BoardNotFoundError();
        if (board.player2) throw new FullBoardError();

        const player2Symbol = board.player1.value == "X" ? "O" : "X";

        board.player2 = new Player(
            user.id,
            user.nickName,
            player2Symbol
        )
        board.status = "in game"

        this.repository.saveBoard(board);

        const opponent = board.player1
        this.playerNotifier.notifyGameState(board, opponent.userId)

        return board;
    }
}