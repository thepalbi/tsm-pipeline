import javascript
import AST

from ASTNode node
where node.getFile().getAbsolutePath().regexpMatch("^.+token.js$")
select node