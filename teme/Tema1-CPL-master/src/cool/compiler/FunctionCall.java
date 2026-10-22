package cool.compiler;

import org.antlr.v4.runtime.Token;

import java.util.ArrayList;

public class FunctionCall extends Expression {
    private ArrayList<Expression> params;
    private Expression name;
    private Expression expression;
    private String upcast;

    public FunctionCall(Expression name, Token token) {
        super(token);
        this.params = new ArrayList<>();
        this.name = name;
    }

    public FunctionCall(Expression name, Expression expression, String upcast, Token token) {
        this(name, token);
        this.expression = expression;
        this.upcast = upcast;
    }

    public ArrayList<Expression> getParams() {
        return params;
    }

    public void setParams(ArrayList<Expression> params) {
        this.params = params;
    }

    public Expression getName() {
        return name;
    }

    public void setName(Expression name) {
        this.name = name;
    }

    public Expression getExpression() {
        return expression;
    }

    public void setExpression(Expression expression) {
        this.expression = expression;
    }

    public String getUpcast() {
        return upcast;
    }

    public void setUpcast(String upcast) {
        this.upcast = upcast;
    }

    public void addParam(Expression param) {
        this.params.add(param);
    }

    @Override
    public <T> T accept(ASTVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
