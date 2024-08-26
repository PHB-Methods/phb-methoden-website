---
title: Team
nav:
  order: 1
  tooltip: Unser Team
---

# {% include icon.html icon="fa-solid fa-users" %}Team

{% include section.html %}

{% include list.html data="members" component="portrait" filters="role: prof" %}
{% include list.html data="members" component="portrait" filters="role:wma" %}
{% include list.html data="members" component="portrait" filters="role:shk" %}
{% include list.html data="members" component="portrait" filters="role:undergrad" %}
