--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 正义盟军 宇宙封闭机  (ID: 8822710)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 8
-- ATK 2400 | DEF 1200
-- Setcode: 1
--
-- Effect Text:
-- 对方场上包含光属性有怪兽2只以上存在的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--A・O・J コズミック・クローザー
function c8822710.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c8822710.spcon)
	c:RegisterEffect(e1)
end
function c8822710.spfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c8822710.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)>1
		and	Duel.IsExistingMatchingCard(c8822710.spfilter,c:GetControler(),0,LOCATION_MZONE,1,nil)
end
