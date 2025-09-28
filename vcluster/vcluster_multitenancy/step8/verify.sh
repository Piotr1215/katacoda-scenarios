#!/bin/bash

# Step 8 Verification Script
echo "🔍 Verifying Challenge Completion..."
echo "===================================="

# Check if at least 2 vClusters exist
VCLUSTER_COUNT=$(vcluster list --output json 2>/dev/null | jq '. | length')
if [ "$VCLUSTER_COUNT" -ge "2" ]; then
    echo "✅ Multiple vClusters: $VCLUSTER_COUNT vClusters running"
else
    echo "❌ Need at least 2 vClusters, found: $VCLUSTER_COUNT"
    exit 1
fi

# Check if dev-team vCluster exists with resource limits
DEV_EXISTS=$(vcluster list --output json 2>/dev/null | jq -r '.[] | select(.Name == "dev-team") | .Name')
if [ "$DEV_EXISTS" = "dev-team" ]; then
    echo "✅ Dev Team vCluster: Created"

    # Check resource quota
    QUOTA=$(kubectl get resourcequota -n vcluster-dev-team --no-headers 2>/dev/null | wc -l)
    if [ "$QUOTA" -ge "1" ]; then
        echo "✅ Resource Quotas: Configured for dev-team"
    else
        echo "⚠️  Resource Quotas: Not found for dev-team"
    fi
else
    echo "❌ Dev Team vCluster: Not found"
    exit 1
fi

# Check if application is deployed
APP_DEPLOYED=$(kubectl get deployment -n vcluster-dev-team -l app=web-app --no-headers 2>/dev/null | wc -l)
if [ "$APP_DEPLOYED" -ge "1" ]; then
    echo "✅ Application: Deployed in at least one vCluster"
else
    echo "⚠️  Application: No web-app deployment found"
fi

echo ""
echo "🎉 Challenge verification complete!"
echo "You're ready to continue with advanced scenarios locally!"

exit 0