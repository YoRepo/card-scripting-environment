--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Valkyrie Chariot  (ID: 19190082)
-- Type: Monster / Effect / Union
-- Attribute: WIND
-- Race: Fairy
-- Level: 3
-- ATK 500 | DEF 1000
-- Setcode: 0x122
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, you can either: Target 1 Fairy monster you control; equip this card to that target,
-- OR: Unequip this card and Special Summon it.
-- If the equipped monster would be destroyed by battle or card effect, destroy this card instead.
-- When the equipped monster declares an attack: You can have it gain 500 ATK.
-- (This ATK gain remains even if this card leaves the field.)
--[[ __CARD_HEADER_END__ ]]

--戦乙女の戦車
function c19190082.initial_effect(c)
	aux.EnableUnionAttribute(c,c19190082.filter)
	--atk up
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(19190082,2))
	e5:SetCategory(CATEGORY_ATKCHANGE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_ATTACK_ANNOUNCE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCondition(c19190082.atkcon)
	e5:SetOperation(c19190082.atkop)
	c:RegisterEffect(e5)
end
function c19190082.filter(c)
	return c:IsRace(RACE_FAIRY)
end
function c19190082.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetEquipTarget()
	return ec and Duel.GetAttacker()==ec
end
function c19190082.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	if ec and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		ec:RegisterEffect(e1)
	end
end
