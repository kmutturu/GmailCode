trigger LeadFixPhoneFormat on Lead (before insert, before update) {
for (Lead i : Trigger.new) {
// Fix Phone Number issues
if (i.Phone != NULL) {
if (i.Phone.startsWith('+1')) {
i.Phone = i.Phone.substring(3);
i.Phone = i.Phone.replace('.', '-');
i.Phone = i.Phone.replaceFirst('(^[0-9][0-9][0-9]).','($1) ');
}
i.Phone = i.Phone.replace('.', '-');
}
    }
}