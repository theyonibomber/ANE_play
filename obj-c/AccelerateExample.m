//
//  AcceleateExample.m
//  AIRExtensionC
//
//  Created by Yoni Tsafir
//

#include "FlashRuntimeExtensions.h"

#include <Accelerate/Accelerate.h>

// Recieves a vector of floats as an argument and returns its sum as a float
FREObject CalculateVectorSum(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    FREObject flashVec = argv[0];
    uint32_t length;
    FREGetArrayLength(flashVec, &length);
    
    float *nativeVec = calloc(sizeof(float), length);
    
    // this of course is highly inefficient, but it serves the purpose of demonstrating the use of vDSP_sve from the
    // Accelerate.framework
    for (uint32_t i = 0; i < length; i++) {
        FREObject flashDouble;
        FREGetArrayElementAt(flashVec, i, &flashDouble);
        
        double nativeDouble;
        FREGetObjectAsDouble(flashDouble, &nativeDouble);
        
        nativeVec[i] = (float)nativeDouble;
    }
    
    float result;
    
    // this is the actual call to Acceleate.framework - this line is the sole purpose of writing this whole shitty file
    vDSP_sve(nativeVec, 1, &result, length);

    
    free(nativeVec);
    
    FREObject retval;
    FRENewObjectFromDouble((double)result, &retval);
    
	return retval;
}

// A native context instance is created
void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) {
	*numFunctionsToTest = 1;
	FRENamedFunction* func = (FRENamedFunction*)malloc(sizeof(FRENamedFunction) * *numFunctionsToTest);
	func[0].name = (const uint8_t*)"CalculateVectorSum";
	func[0].functionData = NULL;
	func[0].function = &CalculateVectorSum;
	
	*functionsToSet = func;
}

// A native context instance is disposed
void ContextFinalizer(FREContext ctx) {
	return;
}

// Initialization function of each extension
void ExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
	*extDataToSet = NULL;
	*ctxInitializerToSet = &ContextInitializer;
	*ctxFinalizerToSet = &ContextFinalizer;
}

// Called when extension is unloaded
void ExtFinalizer(void* extData) {
	return;
}

