package cool.compiler;

public abstract class ASTNode {
    public abstract <T> T accept(ASTVisitor<T> visitor);
}