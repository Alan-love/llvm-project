; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=fiji < %s | FileCheck -check-prefix=GCN %s
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdhsa -mcpu=fiji < %s | FileCheck -check-prefix=GCN %s

define half @v_sqrt_f16(half %src)  {
; GCN-LABEL: v_sqrt_f16:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_sqrt_f16_e32 v0, v0
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %sqrt = call half @llvm.amdgcn.sqrt.f16(half %src)
  ret half %sqrt
}

define half @v_fabs_sqrt_f16(half %src)  {
; GCN-LABEL: v_fabs_sqrt_f16:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_sqrt_f16_e64 v0, |v0|
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %fabs.src = call half @llvm.fabs.f16(half %src)
  %sqrt = call half @llvm.amdgcn.sqrt.f16(half %fabs.src)
  ret half %sqrt
}

define half @v_fneg_fabs_sqrt_f16(half %src)  {
; GCN-LABEL: v_fneg_fabs_sqrt_f16:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_sqrt_f16_e64 v0, -|v0|
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %fabs.src = call half @llvm.fabs.f16(half %src)
  %neg.fabs.src = fneg half %fabs.src
  %sqrt = call half @llvm.amdgcn.sqrt.f16(half %neg.fabs.src)
  ret half %sqrt
}

declare half @llvm.amdgcn.sqrt.f16(half) #0
declare half @llvm.fabs.f16(half) #0

attributes #0 = { nounwind readnone speculatable willreturn }
