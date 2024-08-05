---
title: Forschung
nav:
  order: 3
  tooltip: Forschungsporjekte
---

# {% include icon.html icon="fa-solid fa-microscope" %}Forschung

The Chair of Psychological Methods focuses on advancing the theoretical and practical aspects of clinical psychological assessment and intervention research. Our interdisciplinary approach combines theoretical rigor with practical applications, aiming to bridge the gap between state-of-the-art methodological approaches and their usability to advance evidence generation for better mental health outcomes. 

To this end our key research areas include:

1. Stress and Digital Health Applications
We investigate the impact of stress and the efficacy of digital health applications in managing psychological well-being. By exploring these contemporary issues, we strive to develop effective interventions and tools that leverage technology to improve mental health outcomes.

2. Theory-Based Modeling of Trait Distributions and Changes
Our research involves the theoretical modeling of how psychological traits are distributed and how they change over time. We use advanced statistical techniques (e.g. stochastic differential equation modeling) to understand the dynamics of those traits and their implications for long-term mental health.

3. Construction and Validation of Psychobiological Instruments
We are dedicated to developing and validating psychobiological instruments for outcome assessments. These tools are designed to accurately measure psychological and biological markers, ensuring reliable and valid assessments in clinical practice.

4. Signal Detection and Feature Selection in High-Dimensional Data
Our work addresses the challenges of analyzing high-dimensional data where the number of predictors exceeds the number of observations. We focus on advanced methods for signal detection and feature selection to extract meaningful information from complex datasets.

5. Bayesian Methods of Evidence Generation and Evaluation
We employ Bayesian approaches to evidence generation and evaluation, including adaptive study designs, sample size planning, and effect size pooling (meta-analyses). These methods allow for more flexible and robust inferences in psychological research.

6. Standardization of Research Processes and Meta-Psychology
Our research aims to harmonize research processes and develop consensus guidelines. By promoting transparency and reproducibility, we contribute to the integrity and credibility of psychological science.


{% include section.html %}

## Aktuelle Projekte

{% capture text %}

...

{%
  include button.html
  link="research"
  text="Mehr erfahren"
  icon="fa-solid fa-arrow-right"
  flip=true
  style="bare"
%}

{% endcapture %}

{%
  include feature.html
  image="images/photo.jpg"
  link="research"
  title="Maecenas tempus"
  text=text
%}

{% include section.html %}

## Veröffentlichungen

{% include search-box.html %}

{% include search-info.html %}

{% include list.html data="citations" component="citation" style="rich" %}
