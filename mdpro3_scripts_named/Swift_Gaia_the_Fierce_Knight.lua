--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 疾风之暗黑骑士 盖亚  (ID: 16589042)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 7
-- ATK 2300 | DEF 2100
-- Setcode: 189
--
-- Effect Text:
-- ①：手卡只有这1张卡的场合，这张卡可以不用解放作召唤。
--[[ __CARD_HEADER_END__ ]]

--疾風の暗黒騎士ガイア
function c16589042.initial_effect(c)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16589042,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c16589042.ntcon)
	c:RegisterEffect(e1)
end
function c16589042.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)==1
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
