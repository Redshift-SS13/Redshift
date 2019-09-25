// Test.dm
// Runs all verbs on all test_classes
// Sends a message to world based on the value of the test object's "success" var

// Run all tests
/proc/dd_run_tests()
	// Create an instance of each item we're testing, then call all of its verbs
	var/test_classes = typesof(/obj/test)
	for(var/class in test_classes)
		var/obj/test/tester = new class()
		for(var/test in tester.verbs)
			call(tester, test)()
			if (!( tester.success ))
			else
				//Foreach continue //goto(59)
		// If the "success" var on any test object is null, then the test fails, and all further tests are stopped
		if (!( tester.success ))
			world << "Test failed."
			return
		//Foreach goto(26)
	// If no tests failed, then we'll output a message to world
	world << "All tests passed."
	return

// If the test object dies, then fail the test and force a crash
/obj/test/proc/die(message)
	src.success = 0
	CRASH(message)
	return
