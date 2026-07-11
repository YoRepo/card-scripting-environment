--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Jurrac Protops  (ID: 23927545)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Dinosaur
-- Level: 4
-- ATK 1700 | DEF 1200
-- Setcode: 0x22
-- Scope: OCG / TCG
--
-- Effect Text:
-- Gains 100 ATK for each monster your opponent controls.
--[[ __CARD_HEADER_END__ ]]

--ジュラック・プロトプス
function c23927545.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c23927545.val)
	c:RegisterEffect(e1)
end
function c23927545.val(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)*100
end
