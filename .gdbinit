source /home/xian_wen/Downloads/pwndbg/gdbinit.py
source /home/xian_wen/Downloads/splitmind/gdbinit.py

python
import splitmind
(splitmind.Mind()
  .below(display="backtrace")
  .right(display="stack")
  .right(display="regs")
  .right(of="main", display="disasm")
  .show("legend", on="disasm")
).build()
end
