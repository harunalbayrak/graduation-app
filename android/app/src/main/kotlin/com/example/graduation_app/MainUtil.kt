package com.example.graduation_app

fun printHashMap(map: HashMap<String, Boolean>?): Int{
    try{
        for ((key, value) in map as HashMap<String, Boolean>) {
            println("$key = $value")
        }
    } catch (e: Throwable) {
        println(e.message);
        println(e.cause);
        return -1;
    }
    return 0;
}