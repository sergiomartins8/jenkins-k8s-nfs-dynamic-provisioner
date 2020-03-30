CREDENTIALS_ID = '<<credentials_id>>'

[
        [title: 'title', repo: 'git@github.com:sergiomartins8/<<repo>>.git', jenkinsfile: 'Jenkinsfile'],
        [title: 'title', repo: 'git@github.com:sergiomartins8/<<repo>>.git', jenkinsfile: 'Jenkinsfile', pollScm: 'H/5 * * * *']
].each { job ->
    pipelineJob(job.title) {
        properties {
            disableConcurrentBuilds()
        }
        cron = job.get('pollScm')
        if (cron != null) {
            triggers {
                scm(cron)
            }
        }
        definition {
            cpsScm {
                lightweight(true)
                scm {
                    git {
                        branch(job.get('branch', '*/master'))
                        remote {
                            url(job.repo)
                            credentials(CREDENTIALS_ID)
                        }
                        scriptPath(job.get('jenkinsfile', 'Jenkinsfile'))
                    }
                }
            }
        }
    }
}
