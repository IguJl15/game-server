import './Board.css'
import { Square } from '../Square/Square'
import { SquareValue } from '../Square/Square';
import { useState } from 'react';
import { Button } from '../Button';


export const Board = () => {
    const [gameState, setGameState] = useState(Array<SquareValue>(9).fill(null))

    const handleSquareClick = (index: number) => {
        const newGameState = [...gameState];
        newGameState[index] = 'X';
        setGameState(newGameState);
    }

    const handleResetClick = () => {
        setGameState(Array(9).fill(null));
    }

    return (
        <div className="gameArena">
            <div className="board">
                <Square value={gameState[0]} onClick={() => handleSquareClick(0)} />
                <Square value={gameState[1]} onClick={() => handleSquareClick(1)} />
                <Square value={gameState[2]} onClick={() => handleSquareClick(2)} />

                <Square value={gameState[3]} onClick={() => handleSquareClick(3)} />
                <Square value={gameState[4]} onClick={() => handleSquareClick(4)} />
                <Square value={gameState[5]} onClick={() => handleSquareClick(5)} />

                <Square value={gameState[6]} onClick={() => handleSquareClick(6)} />
                <Square value={gameState[7]} onClick={() => handleSquareClick(7)} />
                <Square value={gameState[8]} onClick={() => handleSquareClick(8)} />
            </div>

            <div className="buttonWapper">
                <Button onClick={handleResetClick}/>
            </div>
        </div>
    )
}
