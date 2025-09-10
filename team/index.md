---
title: Team
nav:
  order: 1
  tooltip: Unser Team
---

# {% include icon.html icon="fa-solid fa-users" %}Team

{% include section.html %}

{% include list.html data="members" component="portrait" filters="role:prof, active:" %}
{% include list.html data="members" component="portrait" filters="role:wma, active:" %}
{% include list.html data="members" component="portrait" filters="role:shk, active:" %}
{% include list.html data="members" component="portrait" filters="role:undergrad, active:" %}

{% assign former_members = site.data["member"]
  | default: site["members"]
  | default: emptyarray
  | data_filter: "active:former"
%}

{% if former_members.size > 0  %}

## Ehemalige Teammitglieder

{% include list.html data="members" component="portrait" filters="active:former" %}

{% endif %}
