declare -a orgs=("Developer" "Partner Developer" "Partner Enterprise" "Partner Professional" "Partner Group" "Enterprise" "Group" "Professional")

for org in "${orgs[@]}"
do
  echo "\n---- $org ----"
  echo "Creating org..."
  sfdx force:org:create edition="$org" -a "$org" -d 7
  sfdx force:data:soql:query -u "$org" -q "SELECT MasterLabel,Name,Status,TotalLicenses,UsedLicenses,UsedLicensesLastUpdated FROM UserLicense order by MasterLabel"
  sfdx force:data:soql:query -u "$org" -q "SELECT MasterLabel,Status,TotalLicenses FROM PermissionSetLicense where Status='Active'"
  sfdx force:org:open -u "$org" -p /lightning/setup/CompanyProfileInfo/home
done
