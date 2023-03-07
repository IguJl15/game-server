import express, { Request, Response } from 'express';

const app = express();

app.post('/create', (req: Request, res: Response) => {

	

})

app.get('/jogo?code=DASDJASDUNAD', (req, res) => {
	res.send('<h1>Home</h1>')
})

app.get('/login', (req, res) => {
	res.send('<h1>Login</h1>')
})

const port = 3000;
app.listen(port, () => console.log('Server running. Check it out on http://localhost:' + port))
