# Getting started with Marlowe

[Marlowe](https://marlowe-research.stanford.edu/) is Stanford's GPU cluster for AI and GPU-accelerated research. It is an NVIDIA DGX H100 SuperPOD (31 DGX H100 nodes, each with 8 x H100 GPUs), operated by [Stanford Research Computing](https://srcc.stanford.edu/) with [Stanford HAI](https://hai.stanford.edu/) managing allocations and providing support to researchers.

Unlike S3DF and Sherlock, KIPAC does not own nodes on Marlowe. Access goes through a project belonging to a faculty PI, and usage is billed to that PI's research account (PTA) at subsidized recharge rates.

## Documentation

The Marlowe user guide is [here](https://marlowe-research.stanford.edu/documentation/). Hardware details are on the [Tech Specs](https://marlowe-research.stanford.edu/documentation/specs/) page.

## Getting help

For Marlowe questions, post in the #marlowe-researchers channel on the Stanford Slack workspace or email marlowe-info@stanford.edu. Each Marlowe PI is also paired with a Research Data Scientist who can help with code optimization and scaling.

For KIPAC-specific questions, use #kipac-computing or contact Marcelo Alvarez.

## Getting an Account

Access is requested by the faculty PI, who must fill out the application personally. See [Apply for access](https://marlowe-research.stanford.edu/access/). Students and postdocs work under their PI's project; to be added, have your PI (or you, with your PI copied) email marlowe-info@stanford.edu with your SUNet ID and the project account name.

There are two kinds of access:

| Tier | GPU-hours | Partition | Preemptible? | Duration |
|---|---|---|---|---|
| Basic Access | 5,000 free GPU-hours for PIs new to Marlowe, then billed | `preempt` | yes | one year |
| Medium / Large Project | allocated on a per-cycle basis | `batch` | no | one cycle (~12 weeks) |

Medium and Large projects are essentially the same: both require Basic Access first, and applications are accepted by cycle. Runs that require scheduling coordination for more than half the system ("hero runs") can be less than 10,000 GPU-hours total. Please reach out to Marcelo Alvarez for help with requesting KIPAC hero runs. See the [Project Application Guide](https://marlowe-research.stanford.edu/access/application-guide/).

Current recharge rates (September 1, 2026 to August 31, 2027) are $0.30 per GPU-hour for non-preemptible jobs (Medium and Large projects) and $0.25 per GPU-hour for preemptible jobs (Basic Access). CPU usage is billed separately, at $0.010 per CPU-hour for non-preemptible jobs and $0.005 per CPU-hour for preemptible jobs. For jobs using full nodes (i.e. 14 CPU cores per GPU), the effective rate is $0.44 per GPU-hour for non-preemptible and $0.32 per GPU-hour for preemptible jobs. Project storage on `/projects` is $20 per TB per month. Check the [recharge rates](https://marlowe-research.stanford.edu/access/#recharge) for the latest.

## Accounts and partitions

Slurm accounts are named `marlowe-` followed by the project ID, for example `marlowe-m000123`. Medium and Large projects add a suffix, like `-pm01` or `-pl01`; your welcome email lists it. The suffix is required for the `batch` partition.

| Partition | Who can use it | Limits |
|---|---|---|
| `preempt` | Basic Access (any project) | limits adjusted with demand; check with `sinfo -p preempt -o "%P %l"` |
| `batch` | Medium and Large projects (`-pm` or `-pl` suffix) | 16 nodes, 2 days |

Jobs in `preempt` can be preempted when a `batch` job needs the node. A preempted job is requeued and **restarts from the beginning**, so checkpoint your work. Also note that submitting to `preempt` with a medium or large suffix charges your GPU-hours allocation.

# Computing Environment

Log in with your SUNet ID (password plus Duo):

```
% ssh sunetid@login.marlowe.stanford.edu
```

There is also a web interface through [Open OnDemand](https://ood.marlowe.stanford.edu).

CUDA tools such as `nvcc` are in the `nvhpc` module, which is not loaded by default. Docker is not supported; use Apptainer, which can run Docker containers.

## Minimal Batch Script Example (preempt)

```bash
#!/bin/bash
#SBATCH --job-name=marlowe_test
#SBATCH --account=marlowe-<project-id>
#SBATCH --partition=preempt
#SBATCH --nodes=1
#SBATCH --gpus=1
#SBATCH --time=00:10:00

set -euo pipefail
module load slurm nvhpc
nvidia-smi
hostname
```

Submit with:

```bash
sbatch marlowe_test.slurm
```

For a Medium or Large project, use `--account=marlowe-<project-id>-pm<NN>` and `--partition=batch`.

## Interactive Slurm Command Templates

```bash
# preempt (Basic Access), 1 GPU
srun   --account marlowe-<project-id> --partition preempt --nodes=1 --gpus=1 --time=00:10:00 --pty /bin/bash
salloc --account marlowe-<project-id> --partition preempt --nodes=1 --gpus=1 --time=00:10:00

# batch (Medium or Large project), 1 GPU
srun   --account marlowe-<project-id>-pm<NN> --partition batch --nodes=1 --gpus=1 --time=00:10:00 --pty /bin/bash
```

## Checking GPU-hour usage

For a Medium or Large project, use the account with its suffix:

```bash
sreport cluster UserUtilizationByAccount -T gres/gpu Start=<start-of-cycle> End=now account=marlowe-<project-id>-pm<NN> -t hours
```
