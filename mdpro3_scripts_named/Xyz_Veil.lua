--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Xyz Veil  (ID: 96457619)
-- Type: Trap / Continuous
-- Setcode: 0x73
-- Scope: OCG / TCG
--
-- Effect Text:
-- Face-up Xyz Monsters with Xyz Material cannot be targeted by card effects.
--[[ __CARD_HEADER_END__ ]]

--エクシーズ・ヴェール
function c96457619.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--untargetable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c96457619.etarget)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c96457619.etarget(e,c)
	return c:GetOverlayCount()~=0
end
