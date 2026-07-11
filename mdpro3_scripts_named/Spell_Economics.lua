--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Spell Economics  (ID: 4259068)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- You do not pay Life Points to activate Spell Cards.
--[[ __CARD_HEADER_END__ ]]

--魔力倹約術
function c4259068.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Cost Change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_LPCOST_CHANGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,0)
	e2:SetValue(c4259068.costchange)
	c:RegisterEffect(e2)
end
function c4259068.costchange(e,re,rp,val)
	if re and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsType(TYPE_SPELL) and not re:GetHandler():IsCode(9236985,57496978) then
		return 0
	else
		return val
	end
end
