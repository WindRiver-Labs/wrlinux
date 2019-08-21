import bb.siggen
import oe.sstatesig

class SignatureGeneratorOverCBasicHash(oe.sstatesig.SignatureGeneratorOEBasicHash):
    name = "OverCBasicHash"

    def init_rundepcheck(self, data):
        oe.sstatesig.SignatureGeneratorOEBasicHash.init_rundepcheck(self, data)

        self.undefined_msgs = []

        self.dev_mode = data.getVar("SIGGEN_OVERC_DEVEL") or "0"

        if self.dev_mode != "0":
            # Clear the locked sigs, to avoid contamination in devel mode
            self.lockedsigs = {}

    def get_taskhash(self, tid, deps, dataCache):
        if self.dev_mode == "0":
            (mc, _, task, fn) = bb.runqueue.split_tid_mcfn(tid)
            recipename = dataCache.pkg_fn[fn]
            if recipename not in self.lockedsigs:
                self.undefined_msgs.append('The %s:%s task does not have a defined signature.'
                                      % (recipename, task))

        h = oe.sstatesig.SignatureGeneratorOEBasicHash.get_taskhash(self, tid, deps, dataCache)
        return h

    def checkhashes(self, sq_data, missed, found, d):
        if self.mismatch_msgs or self.undefined_msgs:
            if self.mismatch_msgs:
                bb.error("\n".join(self.mismatch_msgs))
            if self.undefined_msgs:
                bb.error("\n".join(self.undefined_msgs))
            bb.fatal("Mismatched signatures or undefined signatures indicate "
                     "a possibly unsupported configuration. Only tested "
                     "configurations are supported. Please follow the "
                     "configuration steps exactly. If you believe this "
                     "message is in error, please open a support ticket.")

        oe.sstatesig.SignatureGeneratorOEBasicHash.checkhashes(self, sq_data, missed, found, d)

bb.siggen.SignatureGeneratorOverCBasicHash = SignatureGeneratorOverCBasicHash
