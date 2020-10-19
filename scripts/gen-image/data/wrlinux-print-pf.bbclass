#
# Copyright (C) 2020 Wind River Systems, Inc.
#
python(){
    if d.getVar('SRC_URI'):
        bb.note('PRINT_PF: %s' % d.getVar('PF'))
}
