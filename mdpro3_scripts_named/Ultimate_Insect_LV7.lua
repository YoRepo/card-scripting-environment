--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Ultimate Insect LV7  (ID: 19877898)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level: 7
-- ATK 2600 | DEF 1200
-- Setcode: 0x41
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card was Special Summoned by the effect of "Ultimate Insect LV5", while it remains on the
-- field all of your opponent's monsters lose 700 ATK and DEF.
--[[ __CARD_HEADER_END__ ]]

--アルティメット・インセクト LV7
function c19877898.initial_effect(c)
	--atk,def down
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCondition(c19877898.con)
	e1:SetValue(-700)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
c19877898.lvup={34830502}
c19877898.lvdn={49441499,34088136,34830502}
function c19877898.con(e)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_LV
end
