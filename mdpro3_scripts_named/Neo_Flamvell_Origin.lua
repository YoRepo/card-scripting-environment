--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 新炎狱火源  (ID: 66378485)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Pyro
-- Level 2
-- ATK 500 | DEF 200
-- Setcode: 44
--
-- Effect Text:
-- 自己场上有「新炎狱火源」以外的名字带有「炎狱」的怪兽表侧表示存在，对方墓地存在的卡是3张以下的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ネオフレムベル・オリジン
function c66378485.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c66378485.spcon)
	c:RegisterEffect(e1)
end
function c66378485.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x2c) and not c:IsCode(66378485)
end
function c66378485.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c66378485.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
		and	Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_GRAVE)<=3
end
