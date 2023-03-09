
type GameState
{
	"player1": Player,
	"player2": Player?,
	"board": Board,
	"status": "waiting" | "in game" | "finished"
}

type Player
{
	"id": String | null,
	"nome": String,
	"points": Int,
	"isCurrent": Boolean
}

type Board
{
	"id": String,
	"positions": []
}

 ---

Queries

query GameState -> GameState
{
	"boardId": String,
	"playerId": String | null
}

Mutations

mutation CreateGame -> GameState
{
	"playerName": String,
	"symbol": "X" | "O"
}

mutation JoinGame -> GameState
{
	"playerName": String,
	"boardId": String
}

mutation MarkPosition -> GameState
{
	"playerId": String,
	"position": Int
} 

mutation disconnect -> null
{ }

 ---

Exemplos de uso:

client.write(
{
	"CreateGame": {
		"playerName": "Decartes",
		"symbol": "X"
	}
}.toString()
);

 ---

{
	"MarkPosition": {
		"playerId": "idsiaj",
		"position": "1"
	} 
}


{
	"GameState"
}