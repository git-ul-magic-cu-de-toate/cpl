package cool.compiler;

import org.antlr.v4.runtime.Token;

public class AssignmentNode extends Expression {
    private String varName;
    private Expression value;

    public AssignmentNode(String var, Expression val, Token start) {
        super(start);
        varName = var;
        value = val;
    }

    public String getVarName() {
        return varName;
    }

    public void setVarName(String varName) {
        this.varName = varName;
    }

    public Expression getValue() {
        return value;
    }

    public void setValue(Expression value) {
        this.value = value;
    }

    @Override
    public <T> T accept(ASTVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
