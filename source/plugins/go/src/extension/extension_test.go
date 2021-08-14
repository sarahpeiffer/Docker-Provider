package extension

import (
	"testing"

	"github.com/golang/mock/gomock"
)

// func Test_isValidUrl(t *testing.T) {
// 	type test_struct struct {
// 		isValid bool
// 		url     string
// 	}

// 	tests := []test_struct{
// 		{true, "https://www.microsoft.com"},
// 		{true, "http://abc.xyz"},
// 		{true, "https://www.microsoft.com/tests"},
// 		{false, "()"},
// 		{false, "https//www.microsoft.com"},
// 		{false, "https:/www.microsoft.com"},
// 		{false, "https:/www.microsoft.com*"},
// 		{false, ""},
// 	}

// 	for _, tt := range tests {
// 		t.Run(tt.url, func(t *testing.T) {
// 			got := isValidUrl(tt.url)
// 			if got != tt.isValid {
// 				t.Errorf("isValidUrl(%s) = %t, want %t", tt.url, got, tt.isValid)
// 			}
// 		})
// 	}
// }

type FluentSocketWriterMock struct{}

func Test_getDataTypeToStreamIdMapping(t *testing.T) {

	type test_struct struct {
		testName     string
		mdsdResponse string
		fluentSocket FluentSocket
		output       map[string]string
		err          error
	}

	tests := []test_struct{
		{
			"basic test",
			"asdfasdfasdfasdfasdf not valid json",
			FluentSocket{},
			map[string]string{"a": "b"},
			nil,
		},
	}

	for _, tt := range tests {
		t.Run(tt.testName, func(t *testing.T) {
			mockCtrl := gomock.NewController(t)
			defer mockCtrl.Finish()
			mock := NewMockIFluentSocketWriter(mockCtrl)
			sock := FluentSocket{}
			mock.EXPECT().WriteAndRead(sock, []byte("asdf")).Return([]byte("asdf"), nil).Times(1)
			mock.WriteAndRead(sock, []byte("asdf"))

			_, err := getDataTypeToStreamIdMapping()
			if err != nil {
				t.Errorf("got error")
			}
			// if got != tt.isValid {
			// 	t.Errorf("isValidUrl(%s) = %t, want %t", tt.url, got, tt.isValid)
			// }
		})
	}

	mockCtrl := gomock.NewController(t)
	defer mockCtrl.Finish()
	mock := NewMockIFluentSocketWriter(mockCtrl)
	sock := FluentSocket{}
	mock.EXPECT().WriteAndRead(sock, []byte("asdf")).Return([]byte("asdf"), nil).Times(1)
	mock.WriteAndRead(sock, []byte("asdf"))

}
