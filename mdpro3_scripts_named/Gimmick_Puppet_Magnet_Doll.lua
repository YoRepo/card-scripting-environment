--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Gimmick Puppet Magnet Doll  (ID: 39806198)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 8
-- ATK 1000 | DEF 1000
-- Setcode: 0x1083
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls a monster, and all monsters you control are face-up "Gimmick Puppet"
-- monsters (min. 1), you can Special Summon this card (from your hand).
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
