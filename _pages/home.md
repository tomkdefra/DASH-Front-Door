---
title: "DASH"
layout: splash
permalink: /
date: 2024-07-31T16:38
header:
  overlay_color: "#000"
  overlay_filter: "0.2"
  overlay_image: /assets/images/2024-07-10-00_00_2024-07-10-23_59_Sentinel-1_AWS-IW-VVVH_SAR_urban (1).jpg
  caption: "Modified Copernicus Sentinel data 2024/Sentinel Hub"
excerpt: "This is a proof of concept for a website"
intro: 
  - excerpt: "Browse the tiles below for more information on the projects."
feature_row:
  - image_path: /assets/images/lter_penguins.png
    alt: "placeholder image 1"
    title: "Penguins!"
    excerpt: "Everybody's favourite bird?"
    url: "/showcase/Re-engineered%20human-resource%20help-desk/"
    btn_label: "Read More"
    btn_class: "btn--primary"
  - image_path: /assets/images/Screenshot_16-8-2024_13146_dap-prd2-connect.azure.defra.cloud.jpeg
    image_caption: "Image courtesy of [Unsplash](https://unsplash.com/)"
    alt: "placeholder image 2"
    title: "A Project"
    excerpt: "This is some sample content that goes here with **Markdown** formatting."
    url: "/showcase/baz-boom-identity/"
    btn_label: "Read More"
    btn_class: "btn--primary"
  - image_path: /assets/images/2023-09-04-00_00_2023-09-04-23_59_Sentinel-2_L2A_True_color.jpg
    title: "A different Project"
    excerpt: "Earth Observation Science"
    url: "#test-link"
    btn_label: "Read More"
    btn_class: "btn--primary"
feature_row2:
  - image_path: /assets/images/
    alt: "placeholder image 2"
    title: "English chalk streams"
    excerpt: 'This is some longer sample content that goes here with **Markdown** formatting. 
    It is just a short introduction to the featured project. Left aligned with `type="left"`'
    url: "#test-link"
    btn_label: "Read More"
    btn_class: "btn--primary"
feature_row3:
  - image_path: /assets/images/Screenshot_16-8-2024_131213_dap-prd2-connect.azure.defra.cloud.jpeg
    alt: "placeholder image 2"
    title: "Another project"
    excerpt: 'This is some sample content that goes here with **Markdown** formatting. Right aligned with `type="right"`'
    url: "#test-link"
    btn_label: "Read More"
    btn_class: "btn--primary"
feature_row4:
  - image_path: /assets/images/
    alt: "placeholder image 2"
    title: "Placeholder Image Center Aligned"
    excerpt: 'This is some sample content that goes here with **Markdown** formatting. Centered with `type="center"`'
    url: "#test-link"
    btn_label: "Read More"
    btn_class: "btn--primary"
---

{% include feature_row id="intro" type="center" %}

{% include feature_row %}

{% include feature_row id="feature_row2" type="left" %}

{% include feature_row id="feature_row3" type="right" %}

{% include feature_row id="feature_row4" type="center" %}