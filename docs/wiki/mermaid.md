---
tags:
- markdown
title: mermaid
---

## Directions

```
graph TD  # top down
graph TB  # top to bottom
graph BT  # bottom to top
graph LR  # left to right
graph RL  # right to left
```

## Shapes

```mermaid
graph TD

Box(Box with Rounded Edges)
```

```mermaid
graph TD

Box[Box with Sharp Edges]
```

```mermaid
graph TD

Box>Asymmetric Shape]
```

```mermaid
graph TD

Box{Rhombus}
```

```mermaid
graph TD

Box{{Hexagon Shaped Box}}
```

```mermaid
graph TD

Box((Circle))
```

```mermaid
graph TD

Box([Pill Shaped Box])
```

```mermaid
graph TD

Box[(Cylindrical Shaped Box)]
```

```mermaid
graph TD

Box[Subroutine Shaped Box]
```

```mermaid
graph TD

Box1[/Parallelgram Shaped Box/]

Box2[\Parallelgram Shaped Box\]

```

```mermaid
graph TD

Box3[/Parallelgram Shaped Box\]

Box4[\Parallelgram Shaped Box/]

```

## Links

```mermaid
graph TD

A(Arrow Head) --> B

A1(Open Link) --- B1

A3(Dotted Link) -.-> B3

A5(Thick Link) ==> B5
```

```mermaid
graph TD

A2(Text on Link) --Text--> B2

A4(Dotted Link with Text) -.Text.-> B4
```

## Flow Chart

https://mermaid-js.github.io/mermaid/#/flowchart

```mermaid
flowchart TD

A[Christmas] -->|Get money| B(Go shopping)

B --> C{Let me think}

C -->|One| D[Laptop]

C -->|Two| E[iPhone]

C -->|Three| F[fa:fa-car Car]
```

## Class Diagram

```mermaid
classDiagram

Animal <|-- Duck

Animal <|-- Fish

Animal <|-- Zebra

Animal : +int age

Animal : +String gender

Animal : +isMammal()

Animal : +mate()

class Duck {
    +String beakColor
    +swim()
    +quack()
}

class Fish {
    -int sizeInFeet
    -canEat()
}

class Zebra {
    +bool is_wild
    +run()
}
```

## State Diagram

```mermaid
stateDiagram-v2

[*] --> Still

Still --> [*]

Still --> Moving

Moving --> Still

Moving --> Crash

Crash --> [*]
```

## Pie Chart

```mermaid
pie title Pets adopted by volunteers

"Dogs" : 386

"Cats" : 85

"Rats" : 15
```