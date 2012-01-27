# Cython wrapper for the Saleae Device SDK library# Declarations from the Saleae device librarycdef extern from "SaleaeDeviceApi.h":    ctypedef char S8    ctypedef short S16    ctypedef int S32    ctypedef long long int S64    ctypedef unsigned char U8    ctypedef unsigned short U16    ctypedef unsigned int U32    ctypedef unsigned long long int U64    ctypedef signed long long int S64    cdef cppclass GenericInterface:        pass    cdef cppclass LogicInterface    cdef cppclass GenericDevice    cdef cppclass LogicAnalyzerDevice    cdef cppclass LogicDevice    cdef cppclass Logic16Device    cdef cppclass DevicesManager    cdef cppclass LogicAnalyzerInterface(GenericInterface):        LogicAnalyzerInterface()    # This must be here due to a limitation in Cython        LogicAnalyzerInterface( LogicAnalyzerDevice* )        bint IsUsb2pt0()        bint IsStreaming()        void SetSampleRateHz( U32 sample_rate_hz )        U32 GetSampleRateHz()        S32 GetSupportedSampleRates( U32* buffer, U32 count )        U32 GetChannelCount()        void RegisterOnReadData( void (__stdcall *callback)( U64 device_id, U8* data, U32 data_length, void* user_data ), void* user_data = ? )        void RegisterOnWriteData( void (__stdcall *callback)( U64 device_id, U8* data, U32 data_length, void* user_data ), void* user_data = ? )        void RegisterOnError( void (__stdcall *callback)( U64 device_id, void* user_data ), void* user_data = ? )        void OnReadData( U64 device_id, U8* data, U32 data_length )        void OnWriteData( U64 device_id, U8* data, U32 data_length )        void OnError( U64 device_id )    cdef cppclass LogicInterface(LogicAnalyzerInterface):        LogicInterface( LogicDevice* )        void ReadStart()        void WriteStart()        void Stop()        U8 GetInput()        void SetOutput( U8 val )        #void OnReadData( U64 device_id, U8* data, U32 data_length )    cdef cppclass Logic16Interface(LogicAnalyzerInterface):        Logic16Interface( Logic16Device* )        void ReadStart()        void Stop()        void SetActiveChannels( U32* channels, U32 count )        U32 GetActiveChannels( U32* channels )        void SetUse5Volts( bint use_5_volts )        bint GetUse5Volts()        #void OnReadData( U64 device_id, U8* data, U32 data_length )# ----------------------------------------------------------------------------cdef extern from "SaleaeDeviceApi.h" namespace "DevicesManagerInterface":    cdef void BeginConnect()    cdef void RegisterOnConnect( void (__stdcall *callback)( U64 device_id, GenericInterface* device_interface, void* user_data ), void* user_data = ? )    cdef void RegisterOnDisconnect( void (__stdcall *callback)( U64 device_id, void* user_data ), void* user_data = ? )    cdef void DeleteU8ArrayPtr( U8* array_ptr )