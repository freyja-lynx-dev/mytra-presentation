#import "@preview/diatypst:0.7.1": *

#set text(rgb("#575279").darken(50%))
#set align(horizon)

#show: slides.with(
  title: "Sasha Zurek",
  subtitle: "Technical Presentation",
  date: "10.06.2025",
  authors: (""),
  theme: "full",
  bg-color: rgb("#faf4ed"),
  title-color: rgb("#907aa9"),
  layout: "medium",
  count: "number"
)

= Introduction

== Background
- Chicago suburbs native
- Northern Michigan University, B.S. in Computer Science
  - Senior Project
    - #link("https://gitlab.com/sashazurek/cs480")[Wildcat Instruction Set]
      - 24-bit MISC CPU instruction set
    - #link("https://github.com/freyja-lynx-dev/wildcat")[Wildcat Conceptual Architectural Template (WildCAT)]
      - Reference implementation of the Wildcat ISA
      - Built with Chisel + Scala
- During University
  - General Motors
    - iOS App Development
  - Kioxia America
    - SSD performance analysis tooling
 

== Professional Experience
- After University
  - SiFive
    - Platform Engineer, developer tooling
      - #link("https://github.com/sifive/wake")[Wake (ML clone for build orchestration)]
      - Python
    - Integrating simulation software into build workflow, CI/CD
  - Intel Corporation (Now)
    - De jure: Firmware Validation Technician
      - Flash firmware, remove/insert cables, assist debug efforts
    - De facto: Wildcat DevOps Engineer
      - Automation with Ansible/Semaphore, Bash
      - Self hosted services like Forgejo, Zabbix
      - Digital archaeology :>


== What else do I do?
#grid(
  columns: (2),
  align: horizon,
  column-gutter: 16,
  list(
    [#link("https://grain.social/profile/freyja-lynx.dev")[Photography]],
    [CRT repair],
    [Fighting games (Melee, Rivals of Aether 2)],
    [Drive-by OSS contributions,
      #list(
      [SSBM Decompilation],
      [Pixelfed],
      [Ansible]
    )],
    [ATproto ecosystem,
      #list(
        link("https://github.com/freyja-lynx-dev/bluesky-rss-bot")[BART Alerts Bot],
        link("https://github.com/freyja-lynx-dev/bsky-notifs-for-gnome")[Bluesky Notifications for GNOME],
        link("https://github.com/freyja-lynx-dev/branches")[Branches],
        link("https://tangled.org/@freyja-lynx.dev/geocache-world")[geocache.world]
      )]
  ),
  align(right)[
    #grid(
      columns: (1),
      rows: (2),
      row-gutter: 1fr,
      align: horizon,
       image("media/photo.jpg", width: 92%),
       image("media/crt.jpg", width: 92%),
    )
  ]
)


= Technical Achievement

== The Problem
My primary focus when I worked at Kioxia:
- Performance testing and analysis of solid state drives
- Tested Kioxia's SSDs to identify performance bottlenecks and firmware issues
- Tested competitor SSDs to keep tabs on the competition

How did we do this?
- `fio`, a tool that simulates I/O operations
- Cascading mix of reads and writes
  - 100% reads, 0% writes
  - ...
  - 50% reads, 50% writes
  - ...
  - 0% reads, 100% writes
- Excel spreadsheets with raw data, graphs, and statistical calculations

== What I started with
The team had:
- A shell script for running `fio` with our standard workload
- Some Excel macros that assisted with data import and layout

It was a painful, long, mostly-manual, error prone process that would take *24 hours* for turnaround:
- Kick off the test at 5PM Monday
- Get results by 9AM Wednesday

== The first attempt
I created `performance-analyzer`
- Python
  - xlsxwriter
  - Pandas
  - Pyinstaller for distribution
- Ran the standard workload with no configurable options

#pagebreak()
#image("media/kioxia3.svg")
#pagebreak()
#image("media/kioxia4.svg")
#pagebreak()
#image("media/kioxia5.svg")

== The Problem
When I tried extending `performance-analyzer` to support another workload:
- Internal structure was overly tied to the main workload
- Code was hard to parse and understand
- Debugging was very difficult
  - Pyinstaller made debugging runtime errors difficult
  - There was no mechanism for dry-runs, so no local testing

It worked, but it was clearly flawed, so I went back to the drawing board.

== The second, refined attempt
With the new understanding I had, I created `io-cat`:
- A well defined object structure
  - Target device was abstracted into an object
    - Supported NVMe, SATA, RAM disks, `/dev/null` for local testing
  - Workloads were abstracted, with a focus on composable and reusable functions
- Functional flow of data
  - Give `io-cat` a set of options
  - Option set gets passed to the test runner
  - Test runner passes results to the charter
  - Charter returns an Excel spreadsheet
- Native Python module instead of Pyinstaller

#pagebreak()
#image("media/kioxia7.svg")
#pagebreak()
#image("media/kioxia8.svg")

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
