from orchestration.steps import OrchestrationStep, Context
from optimizer.compute_scores import create_getReprScore_query_file

class GenerateScoresStep(OrchestrationStep):
    def populate(self, ctx: Context) -> Context:
        return ctx

    def run(self, ctx: Context) -> Context:
        create_getReprScore_query_file(ctx, self.orchestrator.query_type, self.orchestrator.scores_file)
        self.orchestrator.data_generator.generate_scores(
            self.orchestrator.query_type,  self.orchestrator.combinedScore, 
            self.orchestrator.kind)
        return ctx

    def name(self) -> str:
        return "generate_scores"

# This step (not included) just create the tsm_repr_pred.qll file
class GenerateTSMQueryStep(OrchestrationStep):
    """
    GenerateTSMQueryStep is an Orchestrator step that having the pipelien ran already, and given the learned results,
    creates a tsm_repr_pred.qll file containing the core getReprScore QL query.
    """
    def populate(self, ctx: Context) -> Context:
        return ctx

    def run(self, ctx: Context) -> Context:
        create_getReprScore_query_file(ctx, self.orchestrator.query_type, self.orchestrator.scores_file)
        return ctx

    def name(self) -> str:
        return "generate_tsm_query"

