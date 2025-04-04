# Set Up Local Commit Verification

echo "youremail@example.com $(cat ~/.ssh/id_ed25519.pub)" | tee ~/.config/git/allowed-signers > /dev/null
