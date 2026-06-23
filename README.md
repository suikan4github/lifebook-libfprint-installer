# lifebook-fprind-installer
Tentative fprintd installer for Lifebook U9311/U9312

# Enroll the fingerprint and verify

```sh
sudo systemctl restart fprintd
fprintd-enroll      # place the SAME finger about 5 times
fprintd-verify      # the correct finger should report "verify-match"
```
