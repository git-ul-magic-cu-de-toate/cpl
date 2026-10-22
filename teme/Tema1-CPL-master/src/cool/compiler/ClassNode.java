package cool.compiler;

import org.antlr.v4.runtime.Token;

import java.util.ArrayList;

public class ClassNode extends Expression {
    private String name;
    private String parent;
    private ArrayList<Definition> definitions;

    public ClassNode(String name, Token token) {
        super(token);
        this.name = name;
        definitions = new ArrayList<>();
    }

    public ClassNode(String name, String parent, Token token) {
        this(name, token);
        this.parent = parent;
    }

    public void addDefinition(Definition def) {
        definitions.add(def);
    }

    public String getParent() {
        return parent;
    }

    public void setParent(String parent) {
        this.parent = parent;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ArrayList<Definition> getDefinitions() {
        return definitions;
    }

    public void setDefinitions(ArrayList<Definition> definitions) {
        this.definitions = definitions;
    }

    @Override
    public <T> T accept(ASTVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
