import './Button.css'

interface ButtonProps {
    onClick: () => void;
}

export const Button = (props: ButtonProps) => {
    return (
        <button className="button" onClick={props.onClick}>Resetar Jogo</button>
    )
}
