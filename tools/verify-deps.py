"""Verify source snapshots against immutable Git archives; never modify dependencies."""
import hashlib
import json
import tarfile
from pathlib import Path

root = Path(__file__).resolve().parents[1]
pins = json.loads((root / 'docs/FRAMEWORK_PIN.json').read_text())
snapshots = [('framework', 'gbarecomp', '.deps/gbarecomp'),
             ('tomlplusplus', 'tomlplusplus', '.deps/tomlplusplus'),
             ('recomp-ui', 'recomp-ui', '.deps/recomp-ui')]
snapshots += [(n, n, f'.deps/gbarecomp/external/{n}')
              for n in ('arm-recomp-core', 'recomp-net', 'rbengine')]
for archive, pin, destination in snapshots:
    with tarfile.open(root / f'.deps/{archive}.tar') as source:
        assert source.pax_headers.get('comment') == pins[pin], f'Wrong pin: {pin}'
        for member in source:
            if member.isfile():
                expected = source.extractfile(member).read()
                actual = (root / destination / member.name).read_bytes()
                assert hashlib.sha256(actual).digest() == hashlib.sha256(expected).digest(), member.name
print('PASS: six pinned dependency snapshots match their Git archives')
