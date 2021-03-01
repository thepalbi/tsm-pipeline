import javascript

/** A data-flow node with a comment of the form "event: e" next to it. */
class NamedEvent extends DataFlow::Node {
  string name;

  NamedEvent() {
    exists(Comment c | name = c.getText().regexpCapture("\\s*event:\\s*(\\S+)\\s*", 1) |
      this.asExpr().getLastToken() = c.getNextToken().getPreviousToken()
    )
  }

  /** Gets the name associated with the data-flow node. */
  string getName() { result = name }
}
