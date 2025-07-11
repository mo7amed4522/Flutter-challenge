#!/bin/bash
# Script to generate localization files for Flutter using both gen-l10n and intl_utils

set -e

# Generate using Flutter's built-in tool
echo "Running flutter gen-l10n..."
flutter gen-l10n

echo "Running intl_utils:generate..."
flutter pub run intl_utils:generate

echo "Localization files generated successfully." 