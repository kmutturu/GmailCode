global with sharing class DummyClass {

    WebService static String convertNumber(decimal value) {
        return 'did apply some magic to ' + String.valueOf(value);
    }

}