--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 水泡幻像  (ID: 80075749)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「元素英雄 水泡侠」在自己场上表侧表示存在时才能发动。这个回合，自己可以从手卡发动1张陷阱卡。
--[[ __CARD_HEADER_END__ ]]

--バブルイリュージョン
function c80075749.initial_effect(c)
	aux.AddSetNameMonsterList(c,0x3008)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c80075749.condition)
	e1:SetOperation(c80075749.activate)
	c:RegisterEffect(e1)
end
function c80075749.filter(c)
	return c:IsFaceup() and c:IsCode(79979666)
end
function c80075749.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c80075749.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c80075749.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(80075749,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetCountLimit(1,80075749)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
