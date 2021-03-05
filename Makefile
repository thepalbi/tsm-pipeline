autoformat:
	codeql query format -i $$(find ql -name *.ql -or -name *.qll -and -not -name tsm_repr_pred.qll)
