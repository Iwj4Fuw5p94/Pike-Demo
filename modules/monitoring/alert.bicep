param vmId string

resource cpuAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'HighCPUAlert'
  location: 'global'

  properties: {
    description: 'CPU > 80%'
    severity: 3
    enabled: true

    scopes: [
      vmId
    ]

    evaluationFrequency: 'PT1M'
    windowSize: 'PT5M'

    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'

      allOf: [
        {
          name: 'HighCPU'

          metricName: 'Percentage CPU'
          metricNamespace: 'Microsoft.Compute/virtualMachines'
          operator: 'GreaterThan'
          threshold: 80
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
    }
  }
}
