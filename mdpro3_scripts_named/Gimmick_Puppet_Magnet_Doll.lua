--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 机关傀儡-磁力人偶  (ID: 39806198)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 8
-- ATK 1000 | DEF 1000
-- Setcode: 4227
--
-- Effect Text:
-- ①：对方场上有怪兽存在，自己场上的怪兽只有「机关傀儡」怪兽的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ギミック・パペット－マグネ・ドール
function c39806198.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c39806198.spcon)
	c:RegisterEffect(e1)
end
function c39806198.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0
		and	Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
		and not Duel.IsExistingMatchingCard(c39806198.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c39806198.cfilter(c)
	return c:IsFacedown() or not c:IsSetCard(0x1083)
end
