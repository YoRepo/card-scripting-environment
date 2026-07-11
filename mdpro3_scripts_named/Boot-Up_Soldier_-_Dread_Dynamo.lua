--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Boot-Up Soldier - Dread Dynamo  (ID: 13316346)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 4
-- ATK 0 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- While you control a "Gadget" monster, this card gains 2000 ATK.
--[[ __CARD_HEADER_END__ ]]

--起動兵士デッドリボルバー
function c13316346.initial_effect(c)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c13316346.atkcon)
	e1:SetValue(2000)
	c:RegisterEffect(e1)
end
function c13316346.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x51)
end
function c13316346.atkcon(e)
	return Duel.IsExistingMatchingCard(c13316346.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
