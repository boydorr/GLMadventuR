setting_up_the_problem <- "Welcome to the Viking village of Berk, located on a remote island, is attacked
frequently by dragons, which take livestock and damage property. You are Hiccup, the awkward
fifteen-year-old son of the village chieftain, Stoick the Vast, and are considered too scrawny and
weak to hunt the dragons. Instead you resolve to study them and the effect that your village's
hunting and livestock management has on dragon numbers."

experimental_design <- "The island Berk is built on can be divided into at least 10 even sized
regions. You will set up a sampling station in each of these regions to monitor dragon population size
as well as some environmental covariates. You have been told that the main covariates that are likely
to affect dragon population size are sheep number (count), vegetation height (numeric), hunting
intensity (low, medium, high), the presence of a unicorn colony (1 or 0). Thanks to your status as
the firstborn of the village chieftain you have a lot of helpers, this means you will have records
collected from all your sites simultaneously over the course of a month."

weight_vs_count <- "During your apprenticeship with Gobber, the village blacksmith, you have built
an assortment of mechanical devices. You think two of these might allow you to get a handle on the
population size of the dragons around Berk. The first is a large weighing scale stationed
next to a dragon feeder (used to monitor dragon health in Gobber's training ring). The second is
an automatedcounter which can be set up to count the number of dragons that fly within its sights. You only have
the materials to run one of these techniques at each of your sites so you need to choose between counting
and weighing dragons. Which will it be? Think about the ecological and modelling consequences for
your choice."

visualise_your_data <- "Now that you have collected your data (see the object 'dragons') it might be a good idea to explore it.
We recommend you visualise the collected data and look at a range of summary statistics."

model_family_selection <- "Choosing which probability distribution (or family) your data come from is
often challenging. While students are often tempted to plot a histogram of their data to determine
this, these visualisations can often be misleading. Instead, try to think of the characteristics
of the population you are collecting from. Are your data numbers or categories? In the case of a
population size they are likely to be numbers. If so, are they whole numbers (discrete) or can they
be decimals (continuous)? Can the numbers go below zero?
"

poisson_for_mass <- "Oh no! You tried a Poisson distribution. The Poisson is a positive, discrete
distribution and thus is best for modelling integer values. The dragons are unimpressed you are assuming
their masses are integer values and get ready to launch a major attack on Berk. Would you
like to choose a different distribution?"

normal_for_count <- "You have selected the Gaussian distribution. The Gaussian is a continuous
distribution and thus might not be the best distribution for discete data (like your counts).
The dragons, furious at your discussion of .43 of a dragon decide to turn each viking into .43 of
a dragon. You lose your legs and a hand. Would you like to choose a different distribution that
represents your counted dragons as whole (integer) individuals?"

choose_your_complex_model <- "Now that you have decided the distribution your response data come
from we can start to think about the relationship between the response and explanatory variables.
There are lots of options when we think about constructing models and choosing the 'best' one. We
need to balance model fit (how well it explains our data) and the model's predictive power (how
well it can be used to predict or interpolate beyond our data. If we produce an overfit model that
explains our data perfectly then we might struggle to predict what the dragon population will do
if we change one of our sites from low dragon hunting to high dragon hunting, or if we try to apply
our model to a new territory. One way to balance these competing demands is to try to balance the
goodness of fit of our model (i.e. how well it describes the data) with the model's complexity (as
a model with more terms with almost always have a better fit). expand expand explain explain"

nhst_chosen <- "You have chosen to compare the importance of explanatory variables using p-values.
This is understandable as you have probably always been told that p-values and significance are
the be all and end all of statistics in ecology. However, there has been increasing dissatisfaction
with this approach among modellers. First and foremost, even when used correctly selecting variables
for a model based on p-values tends to produce poorly performing models, not least because the test
being performed is generally 'is this coefficient significantly different from zero' rather than
'is this coefficient important or having a large effect' as it is often interpreted. Secondly, it is
actually really hard to do a statistically fair comparison based on p-values. Often, the comparison
is done after model selection has already been carried out and thus the hypothesis being tested is
already biased. Papers papers. Expand expand. Link link."

aic_chosen <- "You have chosen to carry out model selection using the Akaike Information Criterion
(AIC). AIC, and many other information crtieria, tend to score a model positively based on its fit
and negatively based on the number of parameters in the model (i.e. it's complexity). The difference
between most information criteria is the relative weight of these parts. Information criteria allow
you to compare the fit of different models fit to the same data. It is therefore possible to explore
the different potential models and to choose the best overall model. This final model contains only
important covariates whose effects can be compared using coefficients (but not p-values!!!)"

end_of_adventure <- "Congratulations! You've fit your GLM and your resultant understanding of dragon
dynamics will serve your people well going forward. On the graphs below we have drawn the True values
that define the relationships between the dragon population and the covariates you collected data on.
How will did your model's estimate and 95% confidence interval stack up against the truth?"


