#!/bin/bash

# Default VM name
DEFAULT_VM_NAME="win10"

# Use first argument if provided, else fallback to default
VM_NAME="${1:-$DEFAULT_VM_NAME}"

# Check if the VM exists
if ! virsh list --all | grep -qw "$VM_NAME"; then
    echo "❌ VM '$VM_NAME' not found. Please check the name with 'virsh list --all'."
    exit 1
fi

# Start the VM if not already running
if ! virsh domstate "$VM_NAME" | grep -q running; then
    echo "🚀 Starting VM '$VM_NAME'..."
    virsh start "$VM_NAME"
    sleep 2
else
    echo "✅ VM '$VM_NAME' is already running."
fi

# Wait for SPICE display to become available
echo "⏳ Waiting for SPICE display to become available..."
until virsh domdisplay "$VM_NAME" | grep -q spice; do
    sleep 1
done

# Launch remote-viewer in fullscreen mode
DISPLAY_URL=$(virsh domdisplay "$VM_NAME")
echo "Connecting to $DISPLAY_URL in fullscreen..."
remote-viewer --full-screen "$DISPLAY_URL"
