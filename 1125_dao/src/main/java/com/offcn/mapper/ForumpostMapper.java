package com.offcn.mapper;


import com.offcn.bean.Forumpost;

import java.util.List;

public interface ForumpostMapper {

    int saveForumPost(Forumpost forumpost);

    List<Forumpost> showAllForumPost();
}