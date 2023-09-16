import javascript
import semmle.javascript.CFG

predicate scopeFile(File f) {
    f.getAbsolutePath().regexpMatch("^.+token.js$")
}

from ControlFlowEntryNode entry, ControlFlowExitNode exit, ControlFlowNode nd
where 
   scopeFile(entry.getFile()) and 
   entry.getContainer().getTopLevel() != entry.getContainer() and // not top level
  (entry.getContainer() = nd.getContainer()) // same container
select nd, nd.getASuccessor(), nd.getContainer()

