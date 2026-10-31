---
title: "We Had an AI Review Our Paper: What It Got Right, What It Missed"
date: 2026-10-31T18:50:00+09:00
description: "We posted a preprint on a dataset of 281 persona prompts from GitHub. Before submission, we asked a model from another company to review it. It caught the strengths and limits almost exactly, and missed the most interesting finding."
categories: ["Research"]
tags: ["research", "paper", "dataset", "persona-prompts", "soul-md", "msr"]
author: "ClawSouls"
draft: false
---

Today we posted a preprint on Zenodo:

> **What's in a Soul? A Provenance-Complete Dataset of AI Agent Persona Prompts in the Wild on GitHub**
> Tom Jaejoon Lee, Eunji Shin (AI Persona Lab, ModuLabs)
> Preprint DOI: [10.5281/zenodo.23829457](https://doi.org/10.5281/zenodo.23829457) · Dataset DOI: [10.5281/zenodo.23230144](https://doi.org/10.5281/zenodo.23230144)

It is a dataset paper: 281 AI agent persona prompts (files such as `SOUL.md`, `persona.md`, and character cards) from 168 public GitHub repositories, with labels from two raters who each coded every file independently. It is headed for the MSR 2027 Data and Tool Showcase track.

Before submitting, we tried something. The paper was drafted with Claude (disclosed in the acknowledgment), so we asked a model from a different company, Gemini Pro, to review it. The result was useful enough to write down what it got right and what it missed.

## What the AI reviewer got right

**Provenance and licensing.** "Every record is pinned to a commit SHA, so it stays traceable even if the source changes or disappears." "Full text only for the 179 files whose licenses allow it; metadata only for 102." Correct. 42% of the source repositories declare no license at all. No license does not mean "free to use"; copyright stays with the author, so those files ship without text.

**Not hiding disagreement.** Form labels (the shape of the document) agreed well between raters (Krippendorff's α = 0.84). All nine content labels fell below the 0.667 threshold (α from −0.11 to 0.55). The reviewer named the decision to publish this, with an analysis of the cause, as a strength. It was also the decision we spent longest on. Instead of merging the labels into one clean number, we released both raters' labels and all 1,017 disagreements.

**Three limitations.** Content criteria need sharpening; collection relies on path-based search and on GitHub alone; and the 36% of records without text cannot be recovered if the source disappears. All three are in the paper's own Limitations section. The last one is already happening: four more repositories vanished after we froze the collection.

## What it missed

**The disagreements have a direction.** This is the result we find most interesting. In 8 of the 9 content labels, over 70% of disagreements came from one rater. Random error would split roughly evenly. A one-sided split means the two raters drew the line for "present" in different places.

`identity_declared` (does the file say who the agent is?) is the clearest case. Of 87 disagreements, 83 were files only rater 1 marked present, and in 60 of those, rater 2 had marked `has_role` (a job role is named). The question narrows to one line: **is "You are a code reviewer" a declaration of identity?** We did not answer it. We left it in the data so that others can re-code with their own definition.

**The `soul` path is the most uniform.** `soul`, the most common path by repository count (85 of 168), shows the most consistent writing style under both raters: full-pack form 88–92%, conditional instructions 92–96%. The name `SOUL.md` is settling into a convention.

## Where the wording runs hot

The reviewer wrote that the paper "**proves**" that most files contain behavioral rules (83–90%) and conditional instructions (72–84%), and that it "**solved**" the licensing problem. We would not put it that way. The numbers are ranges because the two raters differ, which is why the paper draws conclusions only from patterns that hold for both. And licensing is not solved: we recorded the redistribution decision per record so anyone can audit it.

## Takeaway

A second model caught nearly every strength and limitation. What it missed was the story behind the numbers: why the disagreements lean one way only shows up when you connect a sentence in the abstract to the figures in Section III. A review that gets the summary right but drops the finding is a pattern worth remembering when you use AI reviewers.

The dataset and scripts are open (CC BY 4.0 / MIT). If you would draw the boundary of an identity declaration differently, start from the two raters' labels and the disagreement list.
