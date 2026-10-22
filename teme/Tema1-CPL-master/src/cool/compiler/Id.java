package cool.compiler;

import org.antlr.v4.runtime.Token;

public class Id extends Expression {

    public Id(Token token) {
        super(token);
    }

    @Override
    public <T> T accept(ASTVisitor<T> visitor) {
        return visitor.visit(this);
    }

    @Override
    public String toString() {
        return "Id{" +
                "token=" + token.getText() +
                '}';
    }
}
