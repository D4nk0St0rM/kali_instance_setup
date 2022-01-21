```bash
#!/bin/bash

for eachline in $(cat myfile.txt);do
    STUFF
done

```

```bash
#!/bin/bash

while read l; do
    STUFF
done <myfile.txt
```

```bash

#!/bin/bash

for ((i = 0; i < 10; i++)); do
    STUFF
done

```

