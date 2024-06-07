> 👇🖱️Clicking on grayed command like below will execute it in the terminal.

Just has an impressive installation targets list which also includes `ubuntu`
which this environment uses. However the `apt` package is only available for
`ubuntu 24.04` and derivatives and this environment uses `ubuntu 20.04`. So we
need to install just via `MPR`

```bash
git clone https://mpr.makedeb.org/just
cd just
makedeb -si
```{{exec}}
