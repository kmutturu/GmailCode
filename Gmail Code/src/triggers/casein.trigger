trigger casein on Case (before insert,before update,after insert,after update) {

system.debug('hai'+trigger.isupdate);
}