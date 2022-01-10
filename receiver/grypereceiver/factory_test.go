package grypereceiver

import (
	"context"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"go.opentelemetry.io/collector/component/componenttest"
	"go.opentelemetry.io/collector/config"
	"go.opentelemetry.io/collector/consumer/consumertest"
	"go.opentelemetry.io/collector/receiver/scraperhelper"
	"reflect"
	"testing"
	"time"
)

func TestNewFactoryWithInvalidConfig(t *testing.T) {
	factory := NewFactory()
	require.NotNil(t, factory)

	params := componenttest.NewNopReceiverCreateSettings()
	cfg := createDefaultConfig()
	r, err := factory.CreateMetricsReceiver(context.Background(), params, cfg, consumertest.NewNop())
	require.Error(t, err)
	assert.Equal(t, "grype missing required fields: `include`", err.Error())
	require.Nil(t, r)
}

func TestNewFactoryWithValidConfig(t *testing.T) {
	factory := NewFactory()
	require.NotNil(t, factory)

	params := componenttest.NewNopReceiverCreateSettings()
	cfg := createDefaultConfig().(*Config)
	cfg.Include = []string{"/"}
	r, err := factory.CreateMetricsReceiver(context.Background(), params, cfg, consumertest.NewNop())
	require.NoError(t, err)
	require.NotNil(t, r)
}

func Test_createDefaultConfig(t *testing.T) {
	want := &Config{
		ScraperControllerSettings: scraperhelper.ScraperControllerSettings{
			ReceiverSettings:   config.NewReceiverSettings(config.NewComponentID(typeStr)),
			CollectionInterval: 24 * time.Hour,
		},
		Include: make([]string, 0),
	}

	got := createDefaultConfig()
	if !reflect.DeepEqual(got, want) {
		t.Errorf("createDefaultConfig() got = %v, want %v", got, want)
	}
}
