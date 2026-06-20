--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 娱乐伙伴 时事秀舞者  (ID: 36527535)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 3
-- ATK 800 | DEF 1000
-- Setcode: 159
--
-- Effect Text:
-- ①：对方场上有怪兽存在，自己场上没有怪兽存在的场合，这张卡可以从手卡特殊召唤。
-- ②：「娱乐伙伴」怪兽上级召唤的场合，这张卡可以作为2只的数量解放。
--[[ __CARD_HEADER_END__ ]]

--EMレビュー・ダンサー
function c36527535.initial_effect(c)
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c36527535.sprcon)
	c:RegisterEffect(e1)
	--double tribute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e2:SetValue(c36527535.dtcon)
	c:RegisterEffect(e2)
end
function c36527535.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
		and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c36527535.dtcon(e,c)
	return c:IsSetCard(0x9f)
end
