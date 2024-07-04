---
title: Forschung
nav:
  order: 3
  tooltip: Forschungsporjekte
---

# {% include icon.html icon="fa-solid fa-microscope" %}Forschung

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

{% include section.html %}

## Aktuelle Projekte

{% capture text %}

Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo.

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
