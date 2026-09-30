from pathlib import Path
p=Path('architecture/build.mjs')
lines=p.read_text(encoding='utf-8-sig').splitlines()
for i,line in enumerate(lines):
    for _ in range(8):
        try:
            repaired=line.encode('cp1252').decode('utf-8')
        except (UnicodeEncodeError,UnicodeDecodeError):
            break
        if repaired==line: break
        line=repaired
    lines[i]=line
p.write_text('\n'.join(lines)+'\n',encoding='utf-8')
