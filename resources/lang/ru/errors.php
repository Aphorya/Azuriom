<?php

return [
    'error' => 'Ошибка',
    'code' => 'Ошибка :code',
    'home' => 'Вернуться на главную',
    'whoops' => 'Ууупс!',

    '401' => [
        'title' => 'Неавторизованный',
        'message' => 'Вы не имеете права доступа к этой странице.',
    ],
    '403' => [
        'title' => 'Доступ запрещён',
        'message' => 'Вам запрещён доступ к этой странице.',
    ],
    '404' => [
        'title' => 'Не найдена',
        'message' => 'Не удалось найти страницу, которую вы ищете.',
    ],
    '419' => [
        'title' => 'Страница устарела',
        'message' => 'Ваша сессия устарела. Пожалуйста, обновите и повторите попытку.',
    ],
    '429' => [
        'title' => 'Слишком много запросов',
        'message' => 'Вы делаете слишком много запросов к нашим серверам. Пожалуйста, попробуйте позже.',
    ],
    '500' => [
        'title' => 'Ошибка сервера',
        'message' => 'К сожалению, что-то пошло не так на наших серверах. Пожалуйста, попробуйте позже.',
    ],
    '503' => [
        'title' => 'Сервис недоступен',
        'message' => 'Мы делаем кое-какие техработы. Пожалуйста, зайдите позже.',
    ],

    'fallback' => [
        'message' => 'Произошла ошибка. Пожалуйста, попробуйте еще раз.',
    ],
];
