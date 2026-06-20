--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 雪尘龙  (ID: 67675300)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Dragon
-- Level 8
-- ATK 2800 | DEF 1800
--
-- Effect Text:
-- 这张卡可以把场上4个冰指示物取除，从手卡特殊召唤。只要这张卡在场上表侧表示存在，这张卡以外的有冰指示物放置的怪兽不能攻击，也不能作表示形式的变更。
--[[ __CARD_HEADER_END__ ]]

--スノーダスト・ドラゴン
function c67675300.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c67675300.spcon)
	e1:SetOperation(c67675300.spop)
	c:RegisterEffect(e1)
	--atk,pos limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c67675300.target)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	c:RegisterEffect(e3)
end
function c67675300.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and Duel.IsCanRemoveCounter(c:GetControler(),1,1,0x1015,4,REASON_COST)
end
function c67675300.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.RemoveCounter(tp,1,1,0x1015,4,REASON_RULE)
end
function c67675300.target(e,c)
	return c~=e:GetHandler() and c:GetCounter(0x1015)~=0
end
