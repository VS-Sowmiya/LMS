    Scenario: File Processor Checks for New Files Availability
        Given Financial Fortune regularly sends agreements to onboard
        When the file processor checks for new files every 5 minutes
        Then it should detect the availability of new files
        And initiate processing for the newly available files

    Scenario: Continuous File Processing
        Given Financial Fortune sends agreements to onboard 24/7
        When the file processor continuously monitors for new files
        Then it should consistently detect and process incoming files without interruption

    Scenario: Handling Delay in File Availability
        Given Financial Fortune regularly sends agreements to onboard
        When there is a delay in the availability of new files beyond 5 minutes
        Then the file processor should still detect and process the files once available
        And handle the delayed processing without errors

    Scenario: Verification of File Processing Frequency
        Given Financial Fortune regularly sends agreements to onboard
        When the file processor checks for new files
        Then it should adhere to the specified frequency of checking every 5 minutes





