#
# Copyright (C) 2018 Wind River Systems, Inc.
#

def base_get_metadata_git_branch(path, d):
    """
    Try to return where m/master points to when HEAD isn't on any branch.
    """
    import subprocess

    try:
        cmd = 'git rev-parse --abbrev-ref HEAD'.split()
        branch = subprocess.check_output(cmd, cwd=path).decode('utf-8').strip()
        if branch == 'HEAD':
            bb.debug(1, "Trying to get branch name from m/master...")
            # Check whether HEAD == m/master
            cmd1 = 'git rev-parse HEAD'.split()
            cmd2 = 'git rev-parse m/master^0'.split()
            if subprocess.check_output(cmd1, cwd=path) == subprocess.check_output(cmd2, cwd=path):
                cmd = 'git rev-parse --abbrev-ref m/master'.split()
                branch = subprocess.check_output(cmd, cwd=path).decode('utf-8')
        if branch == 'HEAD':
            bb.debug(1, "Trying to get tag name...")
            cmd = 'git describe HEAD'.split()
            branch = subprocess.check_output(cmd, cwd=path).decode('utf-8')

    except subprocess.CalledProcessError:
        branch = '<unknown>'

    return branch.strip().replace('base/', '')
