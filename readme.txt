This code is intended to supplement the NSOperation and NSOperationQueue classes. 
After viewing the video of the WWDC 2015 "Advanced NSOperation" presentation,
I wanted to be able to do similar work, but in Objective-C (the sample
code was released in Swift).  

I was also unimpressed with some of the design decisions, which I feel lead to overly
cumbersome, clunky interfaces.

The biggest departure between this code and the Apple code is that the role of the
Operation Queue has been expanded to encompass the underlying design decision that
a queue represents a "job", and that operations in a queue are all pieces of 
work that prorgress towards job completion.  In the Apple approach, queues are 
far more anonymous and interchangeable.  In my design, a JobOperationQueue can 
(and should) be subclassed to include information relevant to a specific job,
and it facilitates sharing data between job operations through a thread safe 
mutable dictionary.
