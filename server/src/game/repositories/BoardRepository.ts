import { Board } from "../entities/Board"

export interface BoardRepository {
    saveBoard(board: Board): String
    getBoard(id: String): Board | null
    deleteBoard(id: String): boolean
}


class ArrayBoardRepo implements BoardRepository {
    private readonly boards: Map<String, Board> = new Map()
    
    
    saveBoard(board: Board): String {
        this.boards.set(board.id, board)

        return board.id;
    }

    getBoard(id: String): Board | null {
        return this.boards.get(id) ?? null
    }

    deleteBoard(id: String): boolean {
        return this.boards.delete(id)
    }
    
}


