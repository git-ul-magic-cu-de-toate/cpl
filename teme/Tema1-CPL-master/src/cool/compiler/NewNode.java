package cool.compiler;

import org.antlr.v4.runtime.Token;

public class NewNode extends Expression {
    private String type;

    public NewNode(Token token, String type) {
        super(token);
        this.type = type;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public <T> T accept(ASTVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
