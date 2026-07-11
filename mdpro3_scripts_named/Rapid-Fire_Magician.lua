--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Rapid-Fire Magician  (ID: 6337436)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 4
-- ATK 1600 | DEF 1200
-- Setcode: 0x98
-- Scope: OCG / TCG
--
-- Effect Text:
-- Inflict 400 damage to your opponent each time you activate a Normal Spell Card.
--[[ __CARD_HEADER_END__ ]]

--連弾の魔術師
function c6337436.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c6337436.damop)
	c:RegisterEffect(e1)
end
function c6337436.damop(e,tp,eg,ep,ev,re,r,rp)
	if re:GetActiveType()==TYPE_SPELL and re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp==tp then
		Duel.Damage(1-tp,400,REASON_EFFECT)
	end
end
