--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 人造天使  (ID: 16946849)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：只要这张卡在魔法与陷阱区域存在，每次反击陷阱卡发动，在自己场上把1只「人造天使衍生物」（天使族·光·1星·攻/守300）特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--人造天使
function c16946849.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--token
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetCondition(c16946849.tokencon)
	e2:SetOperation(c16946849.tokenop)
	c:RegisterEffect(e2)
end
function c16946849.tokencon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_COUNTER) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,16946850,0,TYPES_TOKEN_MONSTER,300,300,1,RACE_FAIRY,ATTRIBUTE_LIGHT)
end
function c16946849.tokenop(e,tp,eg,ep,ev,re,r,rp)
	local token=Duel.CreateToken(tp,16946850)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end
