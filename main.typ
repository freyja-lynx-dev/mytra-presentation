#import "@preview/diatypst:0.7.1": *

#set text(rgb("#575279").darken(50%))
#set align(horizon)

#show: slides.with(
  title: "Placewcholder",
  subtitle: "A candidate of all time",
  date: "10.06.2025",
  authors: ("Sasha Zurek"),
  theme: "full",
  bg-color: rgb("#faf4ed"),
  title-color: rgb("#907aa9"),
  layout: "medium"
)

= Introduction

== Background
- Chicago suburbs native
- Northern Michigan University, B.S. in Computer Science
  - Senior Project
    - Wildcat Instruction Set
      - 24-bit MISC CPU instruction set
    - Wildcat Conceptual Architectural Template (WildCAT)
      - Reference implementation of the Wildcat ISA
      - Built with Chisel + Scala
 

== Professional Experience
- \~3 years of experience
- Internships and co-ops
  - General Motors (06/2020 -> 08/2020)
    - iOS App Development
  - Kioxia America (08/2020 -> 08/2021)
    - SSD performance analysis tooling
- Post-college
  - SiFive (06/2022 -> 10/2023)
    - Platform Engineer
    - Developer tooling
    - Integrating simulation software into build workflow, CI/CD
  - Intel (06/2025 -> Now)
    - De jure: Validation Technician
    - De facto: Wildcat DevOps Engineer


== What else do I do?
- Photography
- Fighting games (Melee, Rivals of Aether 2)
- Drive-by OSS contributions
  - SSBM Decompilation
- ATproto ecosystem
  - BART Alerts Bot
  - Bluesky Notifications for GNOME
  - geocache.world

= Technical Achievement

== The Problem
My team at Kioxia was responsible for:
- Tracking firmware progress, in terms of performance
- Help assembling competitive analysis

How did we do this?
- `fio`, a tool that simulates I/O operations
- Cascading mix of reads and writes
  - 100% reads, 0% writes
  - ...
  - 50% reads, 50% writes
  - ...
  - 0% reads, 100% writes

== What I started with
The previous intern had:
- A handful of Excel macros that only did part of the work
- Some shell scripts that didn't do much

This meant performance tests would take about *24 hours* for turnaround!
- Test itself ran overnight
- Intern would hand assemble the Excel spreadsheet after importing run data

== The first attempt
I created `performance-analyzer`
- Python
  - xlsxwriter
  - pandas
  - some Python packaging tool

It took a few weeks to get it finished, but it worked...

== Cue
Show the example...

== The Problem
... until we had to add a new format of performance test.
- The internal structure was not conducive to extension
- The distribution tool I used was not great
- 

== The second, refined attempt
While working on other duties, I started a rewrite: `nvme-cat`. With a better understanding
of the problem set, I was able to:
- Create an object hierarchy that was:
  - conducive to reusable code
  - easily extended to support new workloads and devices
  - arranged in a more functional, unidirectional data flow
- Distribute it as a native Python module

== Cue 2
Show the others

== Why was this important?
I got to:
- Create something that I was proud of
- Realize my beautiful creation was flawed
- Kill that creation, and rebuild it from scratch
- Practice the lessons I learned in university in a real-world context


== What would I do now?
- Turn the CLI program into an HTTP agent that:
  - can trigger runs with options
  - replaces Excel with custom graphs and a database interface
  - Can be hooked into firmware CI/CD to allow automatic testing
- Controlled by a web interface

= Afterword

== Questions?
#link("https://github.com/freyja-lynx-dev/mytra-presentation")[
This presentation was built with:
]
- Typst + diatypst
- Nix
- Github Actions

#align(bottom + center)[
  #grid(
    columns: (2),
    column-gutter: 1fr,
    align: center + horizon,
    image("media/Typst.svg",height: 25%),
    image("media/Nix_Snowflake_Logo.svg", height: 35%)
  )
]
