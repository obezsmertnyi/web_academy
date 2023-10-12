# 02-Gitlab
### Create branches
```console
❯ git --no-pager branch
  1-deploy-new-nginx-version
  2-added-file-with-materials
  feature/dp_nginx
  feature/wiki
* main
```
### git log
```console
❯ git --no-pager l
* 34a1ef3 - Thu, 12 Oct 2023 21:59:51 +0300 (15 хвилин тому) (HEAD -> main, origin/main, origin/HEAD)
|  #02-GitLab [OBEZS] png file - obezsmertnyi
* e02d4f1 - Thu, 12 Oct 2023 16:37:37 +0300 (6 годин тому)
|  #02-GitLab [OBEZS] jpeg file - obezsmertnyi
* 8177ea0 - Thu, 12 Oct 2023 16:28:57 +0300 (6 годин тому)
|  #02-GitLab [OBEZS] Added temp submodule - obezsmertnyi
*   b55de30 - Thu, 12 Oct 2023 12:41:13 +0000 (7 годин тому)
|\   Merge branch '2-added-file-with-materials' into 'main' - obezsmertnyi
| * e25d290 - Thu, 5 Oct 2023 18:38:37 +0300 (7 днів тому) (origin/feature/wiki, feature/wiki, 2-added-file-with-materials)
| |  #02-GitLab [OBEZS] Added materials from 02 lessons - obezsmertnyi
* |   c7d159b - Thu, 12 Oct 2023 12:25:13 +0000 (7 годин тому)
|\ \   Merge branch '1-deploy-new-nginx-version' into 'main' - Administrator
| |/  
|/|   
| * 055cacb - Thu, 12 Oct 2023 14:51:49 +0300 (7 годин тому) (origin/feature/dp_nginx, feature/dp_nginx, 1-deploy-new-nginx-version)
|/   #02-GitLab [OBEZS] Added nginx:1.52.2 - obezsmertnyi
* db8fbbc - Thu, 5 Oct 2023 14:32:32 +0000 (7 днів тому)
|  Update README.md - Administrator
* 7eb3b4a - Thu, 5 Oct 2023 01:57:12 +0000 (8 днів тому)
   Initial commit - Administrator%                                                                                    
```
### Add submodule
```console
❯ git submodule
 dd83c9a0972c053a705767066bb0b89b85cbe33b tempwa (heads/main)
```
### Gitlab merge requests
 
```console
❯ glab mr ls -c | cat
Showing 2 closed merge requests on webacademy/webac (Page 1)

!2	webacademy/webac!2	Draft: Resolve "Deploy new nginx version"	(main) ← (1-deploy-new-nginx-version-2)
!1	webacademy/webac!1	Resolve "Added file with materials"	(main) ← (2-added-file-with-materials)
```
```console
❯ glab mr view 1 | cat
title:	Resolve "Added file with materials"
state:	closed
author:	obezsmertnyi
labels:	wa
assignees:	obezsmertnyi
reviewers:	obezsmertnyi
comments:	0
milestone:	test 02 lab
number:	1
url:	http://gitlab.bol-v.com/webacademy/webac/-/merge_requests/1
--
Closes #2
```
```console
❯ glab mr view 2 | cat
title:	Draft: Resolve "Deploy new nginx version"
state:	closed
author:	obezsmertnyi
labels:	wa
assignees:	obezsmertnyi
reviewers:	obezsmertnyi
comments:	0
number:	2
url:	http://gitlab.bol-v.com/webacademy/webac/-/merge_requests/2
--
Closes #1
``` 
### Gitlab issues https://gitlab.com/gitlab-org/cli
```console
#❯ glab issue view | cat
accepts 1 arg(s), received 0
```
```console
❯ glab issue ls -c| cat
Showing 2 closed issues in webacademy/webac that match your search (Page 1)

#2	webacademy/webac#2	Added file with materials		about 7 days ago
#1	webacademy/webac#1	Deploy new nginx version	(wa)	about 7 days ago
```
```console
❯ glab issue view  1 | cat
title:	Deploy new nginx version
state:	closed
author:	obezsmertnyi
labels:	wa
comments:	0
assignees:	obezsmertnyi
--
Change to latest nginx versions
```
```console
❯ glab issue view 2 | cat
title:	Added file with materials
state:	closed
author:	obezsmertnyi
labels:	
comments:	0
assignees:	
milestone:	test 02 lab
--
Create file materials.md with links from 02 lessons
```
### GitLFS = true
```console
❯ git push
Locking support detected on remote "origin". Consider enabling it with:
  $ git config lfs.https://gitlab.bol-v.com/webacademy/webac.git/info/lfs.locksverify true
Uploading LFS objects: 100% (1/1), 12 KB | 0 B/s, done.                                                                                                
```
### Migrate LFS to Minio
```console
root@gitlab:/# gitlab-rake gitlab:lfs:migrate
I, [2023-10-12T18:45:56.502605 #5955]  INFO -- : Starting transfer of LFS files to object storage
I, [2023-10-12T18:45:57.177368 #5955]  INFO -- : Transferred LFS object 2e4a7664603336067f14f78964c6f3cf11c8f59b7072ad2797a05c558ee1e372 of size 11692 to object storage
```
```console
gitlabhq_production=# SELECT count(*) AS total, sum(case when file_store = '1' then 1 else 0 end) AS filesystem, sum(case when file_store = '2' then 1 else 0 end) AS objectstg FROM lfs_objects;
 total | filesystem | objectstg 
-------+------------+-----------
     2 |          0 |         2
(1 row)
```

```console
❯ git lfs ls-files
2e4a766460 * 02-gitlab/devops.jpeg
c7e06a1570 * 02-gitlab/devsecops.png
```

### Minio backet for gitlab
```console
❯ mn ls webac/gitlab-lfs-storage

[2023-10-12 22:23:03 EEST]     0B 2e/
[2023-10-12 22:23:03 EEST]     0B c7/
```